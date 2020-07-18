



$events = Get-WinEvent -FilterHashtable @{ProviderName="Microsoft-Windows-Sysmon"; Id = 11; StartTime = [datetime]::Now.AddMinutes(-20)} -ErrorAction Stop

function Out-Minidump
{


[CmdletBinding()]

Param (

[Parameter(Position = 0, Mandatory = $True, valueFromPipeline = $True)]
[System.Diagnostics.Process]
$Process,
[Parameter(Position = 1)]
[ValidateScript({Test-Path $_})]
[String]
$DumpFilePath = "C:\Windows\ransom"


    )

BEGIN

{

$WER = [PSObject].Assembly.GetType('System.Managment.Automation.WindowsErrorReporting')
$WERNativeMethods = $WER.GetNestedType('NativeMethods', 'NonPublic')
$Flags = [Reflection.BindingFlags] 'NonPublic, Static'
$MiniDumpWriteDump = $WERNativeMethods.GetMethod('MiniDumpWriteDump', $Flags)
$MiniDumpWithFullMemory = [Uint32] 2

}

PROCESS 

{


$ProcessId = $Process.Id
$ProcessName = $Process.Name 
$ProcessHandle = $Process.Handle 
$ProcessFileName = "$($ProcessId).dmp"

$ProcessDumpPath = Join-Path $DumpFilePath $ProcessFileName

$FileStream = New-Object IO.FileStream($ProcessDumpPath, [IO.FileMode]::Create)

$Result = $MiniDumpWriteDump.Invoke($null, @($ProcessHandle, $ProcessId, $FileStream.SafeFileHandle, $MiniDumpWithFullMemory, [IntPtr]::Zero, [IntPtr]::Zero, [IntPtr]::Zero))

$FileStream.Close()

if(-not $Result)

{

$Exception = New-Object ComponentModel.Win32Exception
$ExceptionMessage = "$($Exception.Message) ($($ProcessName):$($ProcessId))"

Remove-Item $ProcessDumpPath -ErrorAction SilentlyContinue

throw $ExceptionMessage

}

else {

Get-ChildItem $ProcessDumpPath

     }

}

END {}

}


if (!$events[0].message) {


Exit 



}


else {

$processes = @()

foreach ($event in $events){

[int]$ProcessId=[regex]::Match($event.message, 'ProcessId\:\s(.+)').captures.groups[1].Value 

$processes += $ProcessId

}

$processes = $processes | Select -Unique

foreach ($process in $processes) {


    $dumpFileName = $process.ToString()+".dmp"


    if (Test-Path '"C:\ransom\$dumpFileName"'){

        Exit 
    }

    else {

        Out-Minidump -Process (Get-Process -Id $process)
    }
}

}
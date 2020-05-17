TLP:GREEN
Recipients may share TLP:GREEN information with peers and partner organizations within their sector or community, but not via publicly accessible channels.
EmoCrash
Purpose
The purpose of this PowerShell script is to protect Windows computers from being infected by Emotet V5. It prevents Emotet from running by setting two keys in the registry to a value that causes Emotet to crash when it attempts to read either of the keys. The PowerShell script only needs to be run once on each computer for each user account to set the keys. Once the keys are set, Emotet V5 will not be able to run on that computer.
Changes to Registry
The PowerShell script creates a new key in HKEY_LOCAL_MACHINE (HKLM) and an identical key in HKEY_CURRENT_USER (HKCU) for each logical volume present on the computer.
Both key names are the logical volume serial number.
On 64-bit Windows, the HKLM key is created under:
HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer
On 32-bit Windows, the HKLM key is created under:
HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\
On both 32-bit and 64-bit Windows, the HKCU key is created under:
HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\
The most important of these keys in the one set in the HKCU hive, because that is what Emotet will check if it is run by a non-privileged user. Therefore, it is important to run this script under each user account on the computer to create the keys in each NTUSER.DAT registry hive.
Result
If Emotet attempts to run on a protected computer, it checks the registry to determine if it has been installed before and retrieve the randomly chosen filename that it previously used. If the keys have been set using this script, Emotet will crash and generate events with IDs 1000 and 1001 (application crash) in the Application Event Log. If Emotet had already been installed on the computer, the path of the crashed application will be a directory named the same as the file inside it (the directory name does not have the file extension). The filename used is chosen randomly from the files in C:\Windows\System32 or C:\Windows\SysWOW64.
For example:
C:\Windows\SysWOW64\sqlsrv32\sqlsrv32.exe
C:\Users\Username\AppData\Local\wshrm\wshrm.exe
The directory is always a sub-directory of %APPDATA%\Local, %SYSTEM%
These application crash events can be used as a means of detecting failed Emotet run attempts.
Recommended Deployment
It is recommended to use a Group Policy Object to set this script as a logon script for all users. After it has been executed by each user, the logon script can be removed, and the registry keys will persist. For non-privileged users, setting the key in the HKLM hive will fail, but the rest of the script will still run and successfully create the key under HKCU for that user.
PowerShell Script
#Emotet Innoculation Script
# **If run as Admin, will set keys under HKLM and HKCU. As user, will only set HKCU **
# Purpose: Emotet V5 Loader generates a value in
# SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\
# that it uses as an infection marker, to store the path it was saved in.
# This key is named the Victim's Volume Serial ID, and the value contains the dropped
# filename of Emotet V5's new filename generation algorithm.
# Emotet looks for this key at startup. If it doesn't exist, it creates it.  If it
# does exist, Emotet reads that key into a buffer after decrypting it.  
# Emotet does not check if the size of the value is larger than the buffer.
# This script overwrites that key with a new key that overflows the buffer, crashing
# the malware.  It also generates event IDs 1000 and 1001 in the Application log.
# Authors: James Quinn, Binary Defense
# Grabs the VolumeSerialNumbers and sets a registry key in Explorer with
# type=REG_BINARY and a value too large for Emotet to handle, overwriting the
# destination buffer, which crashes Emotet.
function GenerateData{
 [byte[]]$string
 for ($i = 1;$i -lt 0x340;$i++){
   $hexNumber = $i % 10
   $string += [byte[]]$hexNumber
 }
 $string += [byte[]](0x51,0x75,0x69,0x6e,0x6e,0x75,0x6e,0x69,0x7a,0x65,0x64)
 return $string
}
# 64-bit Windows
if (([IntPtr]::Size) -eq 8){
 $Akey = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer"
 $key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
}
else{ # 32-bit Windows
 $Akey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
 $key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
}
$volumeSerialNumbers = Get-WmiObject Win32_logicaldisk | select-object -ExpandProperty volumeserialnumber
foreach ($x in $volumeSerialNumbers){
  # Remove any existing Emotet keys
 Remove-ItemProperty -Path $AKey -Name $x
 Remove-ItemProperty -Path $key -Name $x
 $data = GenerateData
 # Set keys and values
 New-ItemProperty -Path $key -Name $x -Value ([byte[]]($data)) -PropertyType Binary
 New-ItemProperty -Path $AKey -Name $x -Value ([byte[]]($data)) -PropertyType Binary
}

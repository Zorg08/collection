import time
file1 = "/home/mfr/projects/domainlist.txt"
f = open(file1)
lines = f.read()
print("Reading defanged domains and IP's.. ")
time.sleep(2)

#ip = input("Enter IP address or domain to be un-defanged: ")
for i in lines:
    if i == ".":
        new_ip = lines.replace("[.]", ".")
print("*****************************")
print("Undefanged domains and IP's: ")
print("*****************************")
time.sleep(1)
print(new_ip)
f.close()

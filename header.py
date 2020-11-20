import requests
import sys
import socket
import json


if len(sys.argv) > 2:
        print("usage" + sys.argv[0] + "<URL>")
        sys.exit(1)

req = requests.get("https://"+sys.argv[1])
print("\n"+str(req.headers))


get_host = socket.gethostbyname(sys.argv[1])
print("\nThe IP address of " + sys.argv[1] + " is " + get_host + "\n")


req_two = requests.get("https://ipinfo.io/"+get_host+"/json")
resp = json.loads(req_two.text)


print("Location: "+resp["loc"])
print("Region: "+resp["region"])
print("City: "+resp["city"])
print("Country: "+resp["country"]) 


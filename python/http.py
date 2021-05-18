import http.client

print("*** This program return a list of of methods if OPTIONS is enabled **\n")

host = input("Input host IP")
port = input("insert the port (default 80)") 

if (port == ""):
    port = 80

try:
    connection = http.client.HTTPConnection(host, port)
    connection.request('OPTIONS', '/')
    response = connection.getresponse()
    print('enabled methods are: ', response.getheader('allow'))
    connection.close()
except ConnectionRefusedError:
    print('connection failed')

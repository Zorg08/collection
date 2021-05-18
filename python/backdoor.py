import socket
import os
import platform


srv_ip = ""
srv_port = 6666


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((srv_ip, srv_port))
s.listen(1)
connection, address = s.accept()
while 1:
    try:
	data = connection.recv(1024)
    except:continue

    if(data.decode('utf-8') == '1'):
	tosend = platform.platform() + " " + platform.machine()
	connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '2'):
	data = connection.recv(1024)
	try:
	    filelist = os.listdir(data.decode('utf-8'))
	    tosend = ""
	    for x in filelist:
		tosend += "," + x
	except:
	    tosend = "wrong path"
	connection.sendall(tosend.encode())
    elif(data.decode('utf-8') == '0'):
	connection.close()
	connection, address = s.accept()



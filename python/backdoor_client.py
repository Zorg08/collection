import socket


SRV_ADDR = input("Enter the IP address")
SRV_PORT = int(input("Enter the server port"))



def print_menu():
    print("""\n\n0) Close the connection
    1) Get system info
    2) List directory content """)
    my_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    my_sock.connect((SRV_ADDR, SRV_PORT))
    print("connection established")
    while 1:
	msg = input("\n select an option")
	if(msg == "0"):
	    my_sock.sendall(msg.encode())
	    my_sock.close()
	    break
	elif(msg == "1"):
	    my_sock.sendall(msg.encode())
	    data = my_sock.recv(1024)
	    if not data: break
	    print(data.decode('utf-8'))

	elif(msg == "2"):
	    path = input("insert the path")
	    my_sock.sendall(msg.encode())
	    my_sock.sendall(path.encode())
	    data = my_sock.recv(1024)
	    data = data.decode('utf-8'),split(",")
	    print("*"*40)
	    for x in data:
		print(x)
	    print("*"*40)

print_menu()

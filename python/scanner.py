import socket


target = input("enter IP address")
portrange = input("Enter a port range to scan (ex: 5-200)")

low_port = int(portrange.split('-')[0])
highport = int(portrange.split('-')[1])

print('Scanning host ', target, 'from port', low_port, 'to port ', highport)

for port in range(low_port, highport):
    s = socket.socket(AF_INET, socket.SOCK_STREAM)
    status = s.connect_ex((target, port))
    if(status == 0):
	print('*** Port',port,'- OPEN ***')
    else:
    s.close()



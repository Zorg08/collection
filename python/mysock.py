import socket

SRV_ADDR = input("type the serve IP")
SRV_PORT = int(input("type the server port"))

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((SRV_ADDR, SRV_PORT))
s.listen(1)
print("server started! waiting for conn")

connection, address = s.accept()
print("client connected with address: " + address)
while 1:
    data = connection.recv(1024)
    if not data: break
    connection.sendall(b'--Message recived --\n')
    print(data.decode('utf-8'))
connection.close()

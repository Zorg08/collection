import socket

SER_ADDR = input("type server ip")
SER_PORT = int(input("type server port"))

my_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
my_sock.connect((SER_ADDR, SER_PORT))
msg = input("message to send")
my_sock.sendall(msg.encode())
my_sock.close()


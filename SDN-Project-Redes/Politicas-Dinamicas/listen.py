import socket
import os

def connect():
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	host = ''
	port = 1234

	variavel = (host, port)


	print("cheguei1")

	try:
		s.bind( variavel )
	except socket.error as e:
		print (e)
		exit(0)

	print("cheguei2")
	s.listen(1)
	
	print("cheguei3")

	while (1):
		conn, adr = s.accept()
		print("cheguei4")

		while(1):
			try:
				recpt = conn.recv(1024)
				print(recpt)
			except socket.error as e:
				print("Deu ruim!!!!!")
				break

		print("acabou")


if __name__ == '__main__':
	connect()
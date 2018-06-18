import socket
import os

def connect():
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	host = ''
	port = 1234

	variavel = (host, port)

	try:
		s.bind( variavel )
	except socket.error as e:
		print (e)
		exit(0)

	print("Waiting Connection")
	s.listen(1)
	
	while (1):
		conn, adr = s.accept()
		print("Accepted Connection")

		recpt = "begin"
		while(not(recpt == "")):
			try:
				recpt = conn.recv(1024)
			except socket.error as e:
				print("Error!")
				break

		print("Connection Ended")


if __name__ == '__main__':
	connect()
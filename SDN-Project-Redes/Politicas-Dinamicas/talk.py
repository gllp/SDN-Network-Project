import socket
import os
import time
from argparse import ArgumentParser

def getArguments():
	parser = ArgumentParser()
	parser.add_argument("destination", 
						nargs=1, 
						help="receiving destination string", 
						metavar="DESTINATION")
	parser.add_argument("duration", 
						nargs=1,
						type=int, 
						help="Connection Duration", 
						metavar="DURATION")

	args = parser.parse_args()
	return args

def connect(args):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	try:
		s.connect((args.destination[0],1234))
	except socket.error as e:
		print(e)
		exit(0)

	print("conectou :D !")

	start_time = time.time()
	#your code
	while ((time.time() - start_time) < args.duration[0]):
		s.send("ferias")
		print("mandei :) !")

	s.close()

if __name__ == '__main__':
	args = getArguments()
	connect(args)

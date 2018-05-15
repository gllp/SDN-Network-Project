#!/usr/bin/python

"""
Network Project Topology

Creating an empty Mininet object
(without a topology object) and adding nodes to it manually.

In this project, is created a ring topology network,
consisting of 3 servers (represented by server), 3 clients
(represented by client), 3 switches (represented by switch) and one
controller (c0), where the 3 switches connect with each
other in a ring fashioned way (switch1 -> switch2, switch2 -> switch3, switch3 -> switch1).

Also, the serveri and clienti connect with the switchi.

"""

from mininet.net import Mininet
from mininet.node import Controller
from mininet.cli import CLI
from mininet.log import setLogLevel, info

def projectNet():

    "Create an empty network and add nodes to it."
	
    net = Mininet( controller=Controller )

    info( '*** Adding controller\n' )
    net.addController( 'c0' )
    
    #number of components in the network
    number_components = 3

    info( '*** Adding hosts\n' )
    Clients = []
    Servers = []
    for i in range(1,number_components+1):
     	client = net.addHost( 'client%d' % i )
      	server = net.addHost( 'server%d' % i )
      	Clients.append(client)
       	Servers.append(server)

    info( '*** Adding switch\n' )
    Switches = []
    for i in range(1,number_components + 1):
       	switch = net.addSwitch( 'switch%d' % i )
       	Switches.append(switch)

    info( '*** Creating links\n' )
    for i in range (number_components):
		net.addLink(Clients[i], Switches[i])
		net.addLink(Servers[i], Switches[i])
    for i in range (number_components):
       	net.addLink(Switches[i%3], Switches[(i+1)%3])

    info( '*** Starting network\n')
    net.start()

    info( '*** Running CLI\n' )
    CLI( net )

    info( '*** Stopping network' )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    projectNet()

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
from mininet.node import Controller, RemoteController, OVSKernelSwitch, UserSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import Link, TCLink

def projectNet():

    "Create an empty network and add nodes to it."

    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch)

    info( '*** Adding controller\n' )
    Controller0 = net.addController( 'c0', controller=RemoteController, ip='127.0.0.1', port=6633 )
    
    #number of components in the network
    number_components = 3

    info( '*** Adding hosts\n' )
    Clients = []
    Servers = []
    Ips = ['10.0.0.1/24', '10.0.0.2/24', '10.0.0.3/24', '10.0.0.4/24', '10.0.0.5/24', '10.0.0.6/24']
    Macs = ['00:00:00:00:00:01', '00:00:00:00:00:02', '00:00:00:00:00:03', '00:00:00:00:00:04', '00:00:00:00:00:05', '00:00:00:00:00:06', '00:00:00:00:00:07', '00:00:00:00:00:08', '00:00:00:00:00:09']
    for i in range(1,number_components+1):
     	client = net.addHost( 'client%d' % i, mac=Macs[i-1], ip=Ips[i-1] )
      	server = net.addHost( 'server%d' % i, mac=Macs[i+2], ip=Ips[i+2] )
      	Clients.append(client)
       	Servers.append(server)

    info( '*** Adding switch\n' )
    Switches = []
    Listen_Ports = [6673,6674,6675]
    for i in range(1,number_components + 1):
       	switch = net.addSwitch( 'switch%d' % i, mac=Macs[i+5], listenPort=Listen_Ports[i-1])
       	Switches.append(switch)

    info( '*** Creating links\n' )
    for i in range (number_components):
      net.addLink(Clients[i], Switches[i])
      net.addLink(Servers[i], Switches[i])
    for i in range (number_components):
      net.addLink(Switches[i%3], Switches[(i+1)%3])

    info('***Setting switches to openflow 1.3\n')
    for i in range(number_components):
      Switches[i].cmd('ovs-vsctl set Bridge switch%d protocols=OpenFlow13' % (i+1) )

    info( '*** Starting network\n')
    net.start()

    info( '*** Running CLI\n' )
    CLI( net )

    info( '*** Stopping network' )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    projectNet()

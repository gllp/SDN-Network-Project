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
from threading import Thread
import time
from datetime import datetime
from argparse import ArgumentParser
import os
import subprocess

#Getting time arguments for servers' policies
def getTime():
    parser = ArgumentParser()
    parser.add_argument("start_time", 
                        nargs=1, 
                        help="Receiving Start Time", 
                        metavar="START_TIME")
    parser.add_argument("end_time", 
                        nargs=1,
                        help="Receiving End Time", 
                        metavar="END_TIME")

    times = parser.parse_args()

    return times

#Setting time policies for servers
def set_time_policy(times, controller):
    new_rule_set = False
    current_time = datetime.now()

    now = str(current_time.day) + '/' + str(current_time.month) + '/' + str(current_time.year)

    start_time = datetime.strptime(now + ' ' + times.start_time[0], "%d/%m/%Y %H:%M")
    end_time = datetime.strptime(now + ' ' + times.end_time[0], "%d/%m/%Y %H:%M")

    while(1):
        current_time = datetime.now()
        if ((current_time > start_time) and (current_time < end_time) and not(new_rule_set)):
            controller.cmdPrint("./SettingRules.sh")
            new_rule_set = True

        elif((current_time > end_time) and (new_rule_set)):
            controller.cmdPrint("./RemovingRules.sh")
            start_time = start_time + datetime.timedelta(days=1)
            end_time = end_time + datetime.timedelta(days=1)
            new_rule_set = False

def CLI_Control(net):
    info( '*** Running CLI\n' )
    CLI( net )

def projectNet(times):

    "Create an empty network and add nodes to it."

    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch)

    info( '*** Adding controller\n' )
    Controller0 = net.addController( 'c0', controller=RemoteController, ip='127.0.0.1', port=6633 )
    
    #number of components in the network
    number_components = 3

    info( '*** Adding hosts\n' )
    Clients = []
    Servers = []
    Ips = ['1.1.1.2/30', '2.2.1.2/30', '3.3.1.2/30', '1.1.2.2/30', '2.2.2.2/30', '3.3.2.2/30']
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
      net.addLink(Clients[i], Switches[i], bw=0.03)
      net.addLink(Servers[i], Switches[i], bw=0.03)
    for i in range (number_components):
      net.addLink(Switches[i%3], Switches[(i+1)%3], bw=0.03)

    info( '*** Starting network\n')
    net.start()

    info('***Setting switches to openflow 1.3\n')
    for i in range(number_components):
      Switches[i].cmd('ovs-vsctl set bridge switch%d protocols=OpenFlow13' % (i+1) )

    info('***Setting hosts eth0 up\n')
    for i in range(number_components):
      Clients[i].cmd("ifconfig client%d-eth0 up" % (i+1))
      Servers[i].cmd("ifconfig server%d-eth0 up" % (i+1))
    
    info('***Setting hosts routes\n')
    IpsGateways = ['1.1.1.1', '2.2.1.1', '3.3.1.1', '1.1.2.1', '2.2.2.1', '3.3.2.1']
    for i in range(number_components):
      Clients[i].cmd("ip route add default via %s" % IpsGateways[i])
      Servers[i].cmd("ip route add default via %s" % IpsGateways[i+3])

    info('***Running configs switches\n')
    for i in range(number_components):
        Switches[i].cmdPrint('./QoSSwitchConfig.sh')

    #info('***Opening xterms\n')
    #cliTest = CLI( net )
    #cliTest.do_xterm('c0 server1 server2')

    #info('***Running configs QosControllerConfig\nCreating new qos_rest_router.py file\nInstalling file\nRunning QoS files\n')
    #Controller0.sendCmd('./QoSControllerConfig.sh')
    #subprocess.call('./QoSControllerConfig.sh')

    #Thread CLI Start
    threadCLI = Thread(target=CLI_Control, args=[net])
    threadCLI.start()

    time.sleep(180)

    #info('***Running Controller-Settings\n')
    #Controller0.cmdPrint('./Controller-Settings.sh')

    info('***Initializing Threads\n')
    threadSetTimePolicy = Thread(target=set_time_policy, args=[times, Controller0]) 

    threadSetTimePolicy.start()
    
    threadCLI.join()

    #info( '*** Running CLI\n' )
    #CLI( net )

    info( '*** Stopping network' )
    net.stop()

if __name__ == '__main__':
    times = getTime()
    setLogLevel( 'info' )
    projectNet(times)
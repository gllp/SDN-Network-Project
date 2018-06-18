#Setting Switches Addresses
curl -X POST -d '{"address":"1.1.1.1/30"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"address":"1.1.2.1/30"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"address":"12.12.12.1/30"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"address":"14.14.14.2/30"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"address":"2.2.1.1/30"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"address":"2.2.2.1/30"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"address":"12.12.12.2/30"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"address":"13.13.13.1/30"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"address":"3.3.1.1/30"}' http://localhost:8080/router/0000000000000003
curl -X POST -d '{"address":"3.3.2.1/30"}' http://localhost:8080/router/0000000000000003
curl -X POST -d '{"address":"13.13.13.2/30"}' http://localhost:8080/router/0000000000000003
curl -X POST -d '{"address":"14.14.14.1/30"}' http://localhost:8080/router/0000000000000003

echo "Setting Addresses For Each Switch Connection"

#Setting Switches Gateways
curl -X POST -d '{"gateway":"12.12.12.2"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"gateway":"13.13.13.2"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"gateway":"14.14.14.2"}' http://localhost:8080/router/0000000000000003

echo "Setting Gateways For Each Switch"

#Adjusting servers links
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=3.3.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=1.1.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=2.2.2.2,actions=drop

echo "Adding Flow Rules For Each Switch To Guarantee Each Server i%3 Only Communicates With Server (i+1)%3"

#Removing server1 links to clients
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop

echo "Adding Flow Rules For Switch 1 To Guarantee Server 1 Does Not Communicates With Clients"

#Removing server2 links to clients
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop

echo "Adding Flow Rules For Switch 2 To Guarantee Server 2 Does Not Communicates With Clients"

#Removing server3 links to clients
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop

echo "Adding Flow Rules For Switch 3 To Guarantee Server 3 Does Not Communicates With Clients"

#Removing client1 links with servers
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop

echo "Adding Flow Rules For Switch 1 To Guarantee Client 1 Does Not Communicates With Servers"

#Removing client2 links with servers
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop

echo "Adding Flow Rules For Switch 2 To Guarantee Client 2 Does Not Communicates With Servers"

#Removing client3 links with servers
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop

echo "Adding Flow Rules For Switch 3 To Guarantee Client 3 Does Not Communicates With Servers"
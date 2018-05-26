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

curl -X POST -d '{"gateway":"12.12.12.2"}' http://localhost:8080/router/0000000000000001
curl -X POST -d '{"gateway":"13.13.13.2"}' http://localhost:8080/router/0000000000000002
curl -X POST -d '{"gateway":"14.14.14.2"}' http://localhost:8080/router/0000000000000003

#Adjusting servers links
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=3.3.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=1.1.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=2.2.2.2,actions=drop
#Removing server1 links to clients
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop
#Removing server2 links to clients
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop
#Removing server3 links to clients
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=1.1.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=2.2.1.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=2,ip,nw_dst=3.3.1.2,actions=drop
#Removing client1 links with servers
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch1 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop
#Removing client2 links with servers
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch2 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop
#Removing client3 links with servers
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=3.3.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=2.2.2.2,actions=drop
sudo ovs-ofctl -O OpenFlow13 add-flow switch3 priority=65535,in_port=1,ip,nw_dst=1.1.2.2,actions=drop
#Creating QoS Queues

echo "Adding Qos Queues"

#Queues for Server1
curl -X PUT -d '"tcp:127.0.0.1:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000001/ovsdb_addr

#Queues for Server2
curl -X PUT -d '"tcp:127.0.0.1:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000002/ovsdb_addr

#Queues for Server3
curl -X PUT -d '"tcp:127.0.0.1:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000003/ovsdb_addr

#Adding Queues
curl -X POST -d '{"port_name": "switch1-eth2", "type": "linux-htb", "max_rate": "30000", "queues": [{"min_rate": "20000"}]}' http://localhost:8080/qos/queue/0000000000000001
curl -X POST -d '{"port_name": "switch2-eth2", "type": "linux-htb", "max_rate": "30000", "queues": [{"min_rate": "20000"}]}' http://localhost:8080/qos/queue/0000000000000002
curl -X POST -d '{"port_name": "switch3-eth2", "type": "linux-htb", "max_rate": "30000", "queues": [{"min_rate": "20000"}]}' http://localhost:8080/qos/queue/0000000000000003
echo "Adding Queues For Servers, Guaranteeing Minimum Bandwidth 20KB/s"
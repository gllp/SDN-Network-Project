#Setting QoS Rules for Servers

echo "Adding QoS Rules"

#Setting Rules for Switch1
curl -X POST -d '{"match": {"nw_dst": "2.2.2.2", "nw_proto": "TCP", "tp_dst": "1234"}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000001
echo "Allocating Bandwidth for reserved time in Switch1, Server1 to Server2 Communication"

#Setting Rules for Switch2
curl -X POST -d '{"match": {"nw_dst": "3.3.2.2", "nw_proto": "TCP", "tp_dst": "1234"}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000002
echo "Allocating Bandwidth for reserved time in Switch2, Server2 to Server3 Communication"

#Setting Rules for Switch3
curl -X POST -d '{"match": {"nw_dst": "1.1.2.2", "nw_proto": "TCP", "tp_dst": "1234"}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000003
echo "Allocating Bandwidth for reserved time in Switch3, Server3 to Server1 Communication"
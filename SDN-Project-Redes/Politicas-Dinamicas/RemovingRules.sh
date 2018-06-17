#Removing QoS Rules for Servers

echo "Removing QoS Rules"

#Removing QoS Rules for Switch1
curl -X DELETE -d '{"qos_id":"1"}' http://localhost:8080/qos/rules/0000000000000001
echo "Removing Qos Rules in Switch1, Server1 to Server2 Communication"

#Removing QoS Rules for Switch1
curl -X DELETE -d '{"qos_id":"1"}' http://localhost:8080/qos/rules/0000000000000002
echo "Removing Qos Rules in Switch2, Server2 to Server3 Communication"

#Removing QoS Rules for Switch1
curl -X DELETE -d '{"qos_id":"1"}' http://localhost:8080/qos/rules/0000000000000003
echo "Removing Qos Rules in Switch3, Server3 to Server1 Communication"
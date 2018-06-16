curl -X PUT -d ‘“tcp:127.0.0.1:6632”’ http://localhost:8080/v1.0/conf/switches/0000000000000002/ovsdb_addr

#curl -X POST -d '{"port_name": "switch2-eth2", "type": "linux-htb", "max_rate": "30000", 
#"queues": [{"max_rate": "30000"}, {"min_rate": "20000"}]}' http://localhost:8080/qos/queue/0000000000000002

#curl -X POST -d '{"match": {"nw_dst": "1.1.2.2", "nw_proto": "TCP", "tp_dst": "1234"}, 
#"actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000002

#curl -X GET http://localhost:8080/qos/rules/0000000000000002
#Setting Ryu Configuration

sed '/OFPFlowMod(/,/)/s/0, cmd/1, cmd/' ~/ryu/ryu/app/rest_router.py > ~/ryu/ryu/app/qos_rest_router.py
cd ~/ryu/; python ./setup.py install
ryu-manager ryu.app.rest_qos ryu.app.qos_rest_router ryu.app.rest_conf_switch
#sed '/OFPFlowMod(/,/)/s/)/, table_id=1/' ~/ryu/ryu/app/simple_switch_13.py > ~/ryu/ryu/app/qos_simple_switch_13.py
#cd ~/ryu/ python ./setup.py install
ryu-manager ryu.app.rest_qos ryu.app.qos_simple_switch_13 ryu.app.rest_conf_switch
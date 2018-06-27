'''
#Code to call listen and talk scripts in Network-Script

#Call for Talk and Listen Scripts
def net_server(net):
    IpsDic = {'client1':'1.1.1.2', 'client2':'2.2.1.2', 'client3':'3.3.1.2'}
    while(1):
        option = int(raw_input("Menu:\n1-Talk\n2-Listen\n3-Exit\n"))
        if (option == 1):
            source = raw_input("Digite a fonte:\n")
            destination = raw_input("Digite o destino:\n")
            duration = int(raw_input("Digite a duracao da conexao:\n"))

            ip = IpsDic[destination]

            client = net.get(source)

            client.cmdPrint("sudo python talk.py %s %d" % (ip, duration))

        elif (option == 2):
            source = raw_input("Digite o cliente:\n")
    
            client = net.get(source)

            print("To aqui :D :D !!\n")

            client.cmdPrint("sudo python listen.py &")

            print("Saiu\n")

        else:
            print("Entrou!!!")
            break


#Calling net_server thread
threadNetServer = Thread(target=net_server, args=[net])
threadNetServer.start()

#info('***Running configs QosControllerConfig\nCreating new qos_rest_router.py file\nInstalling file\nRunning QoS files\n')
#Controller0.sendCmd('./QoSControllerConfig.sh')
#subprocess.call('./QoSControllerConfig.sh')

#info('***Opening xterms\n')
#cliTest = CLI( net )
#cliTest.do_xterm('c0 server1 server2')

'''
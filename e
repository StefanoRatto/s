#!/usr/bin/python3

import os
import sys
import nmap

nm = nmap.PortScanner()
nm.scan(hosts=sys.argv[1], arguments='-Pn -p- -T5')

for host in nm.all_hosts():

    os.system("nmap -sC -sV -T5 -Pn -p" + str(nm[host].all_tcp()).replace("[", "").replace("]", "").replace(" ", "") + " " + host + " | tee -a nmap_" + host + ".txt")

    for proto in nm[host].all_protocols():

        for port in list(nm[host][proto].keys()):
                        
            if "http" in nm[host][proto][port]['name']:
                
                os.system("ffuf -u http://" + host + ":" + str(port) + "/FUZZ -w " + sys.argv[2] + " | tee -a ffuf_" + host + "_" + str(port) + ".txt")

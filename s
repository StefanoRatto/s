#!/usr/bin/python3

import os
import sys
import nmap

nm = nmap.PortScanner()
nm.scan(hosts=sys.argv[1], arguments='-Pn -p- -T5')

for host in nm.all_hosts():

    os.system("nmap -sC -sV -T5 -Pn -p" + str(nm[host].all_tcp()).replace("[", "").replace("]", "").replace(" ", "") + " " + host + " | tee -a nmap_" + host + ".txt")

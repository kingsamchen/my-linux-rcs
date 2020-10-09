#!/bin/bash

ip a add 192.168.137.2/24 dev ens33


ip r add 172.18.20.0/24 via 192.168.137.1
ip r add 172.18.21.0/24 via 192.168.137.1
ip r add 172.16.17.0/24 via 192.168.137.1
ip r add 172.16.38.0/24 via 192.168.137.1
ip r add 172.22.0.0/16 via 192.168.137.1
ip r add 172.23.0.0/16 via 192.168.137.1

goproxy.bili

echo "Successfully added rules for VPN"


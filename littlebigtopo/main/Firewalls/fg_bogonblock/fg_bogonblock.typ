#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
== Fortigate Bogons
Bogon sind private Adressen, die im öffentlichen Netz geblockt werden sollen. Auf der FortiGate werden daher eine local-in-policy erstellt die dazu dienen diese Adressen zu blockieren. Folgender Code blockiert diese Adressen.

=== Konfiguration

#sourcecode[```bash
config firewall address
    edit "Bogon_0.0.0.0/8"
        set subnet 0.0.0.0 255.0.0.0
    next
    edit "Bogon_10.0.0.0/8"
        set subnet 10.0.0.0 255.0.0.0
    next
    edit "Bogon_100.64.0.0/10"
        set subnet 100.64.0.0 255.192.0.0
    next
    edit "Bogon_127.0.0.0/8"
        set subnet 127.0.0.0 255.0.0.0
    next
    edit "Bogon_169.254.0.0/16"
        set subnet 169.254.0.0 255.255.0.0
    next
    edit "Bogon_172.16.0.0/12"
        set subnet 172.16.0.0 255.240.0.0
    next
    edit "Bogon_192.0.0.0/24"
        set subnet 192.0.0.0 255.255.255.0
    next
    edit "Bogon_192.0.2.0/24"
        set subnet 192.0.2.0 255.255.255.0
    next
    edit "Bogon_192.168.0.0/16"
        set subnet 192.168.0.0 255.255.0.0
    next
    edit "Bogon_198.18.0.0/15"
        set subnet 198.18.0.0 255.254.0.0
    next
    edit "Bogon_198.51.100.0/24"
        set subnet 198.51.100.0 255.255.255.0
    next
    edit "Bogon_203.0.113.0/24"
        set subnet 203.0.113.0 255.255.255.0
    next
    edit "Bogon_224.0.0.0/4"
        set subnet 224.0.0.0 240.0.0.0
    next
    edit "Bogon_240.0.0.0/4"
        set subnet 240.0.0.0 240.0.0.0
    next
    edit "Bogon_255.255.255.255/32"
set subnet 255.255.255.255 255.255.255.255
    next
end
```]

#sourcecode[```bash
Dieser Codeabschnitt legt die Adressen die später blockiert werden sollen fest

config firewall addrgrp
    edit "Bogon_Addresses"
        set member "Bogon_0.0.0.0/8" "Bogon_10.0.0.0/8" "Bogon_100.64.0.0/10" "Bogon_127.0.0.0/8" "Bogon_169.254.0.0/16" "Bogon_172.16.0.0/12" "Bogon_192.0.0.0/24" "Bogon_192.0.2.0/24" "Bogon_192.168.0.0/16" "Bogon_198.18.0.0/15" "Bogon_198.51.100.0/24" "Bogon_203.0.113.0/24" "Bogon_224.0.0.0/4" "Bogon_240.0.0.0/4" "Bogon_255.255.255.255/32"
    next
end
```]
Hier werden Adress-Gruppen für die Bogons erstellt. Anschließend werden sie der Policy zugewiesen.

#sourcecode[```bash
config firewall local-in-policy
    edit 1
        set intf "VLAN 10 HA"
        set srcaddr "Bogon_Addresses"
        set dstaddr "all"
        set service "PING"
        set schedule "always"
    next
    edit 2
        set intf "VLAN 20 HA"
        set srcaddr "Bogon_Addresses"
        set dstaddr "all"
        set service "PING"
        set schedule "always"
    next    
end
```]

Falls nun eine private Adresse im AS auftaucht und diese Adresse versucht die FortiGate zu erreichen wird diese geblockt.


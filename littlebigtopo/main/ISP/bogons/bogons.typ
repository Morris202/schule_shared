#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

== Bogons blocken

Auf dem ISP Border-Router *BIF-BR3* wurde auf dem outside Interface In und Out, mithilfe einer Access-List, Bogons blockiert. Die Konfiguration sieht wie folgt aus:

#sourcecode[```bash
ip access-list extended BLOCK_BOGONS
deny ip 0.0.0.0 0.255.255.255 any
deny ip 10.0.0.0 0.255.255.255 any
deny ip 100.64.0.0 0.63.255.255 any
deny ip 127.0.0.0 0.255.255.255 any
deny ip 169.254.0.0 0.0.255.255 any
deny ip 172.16.0.0 0.15.255.255 any
deny ip 192.0.2.0 0.0.0.255 any
deny ip 192.88.99.0 0.0.0.255 any
deny ip 192.168.0.0 0.0.255.255 any
deny ip 198.18.0.0 0.1.255.255 any
deny ip 198.51.100.0 0.0.0.255 any
deny ip 203.0.113.0 0.0.0.255 any
deny ip 224.0.0.0 31.255.255.255 any
permit ip any any

int gi0/0
ip access-group BLOCK_BOGONS in
ip access-group BLOCK_BOGONS out
exit
```]
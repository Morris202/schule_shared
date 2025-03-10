#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/document:0.1.0": *

== Linux Firewall mit iptables
iptables ist ein Paketfilter-Firewall-Framework für den Linux-Kernel. Es ermöglicht die Kontrolle des Netzwerkverkehrs basierend auf vordefinierten Regeln. iptables arbeitet auf der Netzwerkebene und nutzt verschiedene Tabellen und Chains zur Verarbeitung von Paketen.

=== Konfiguration
Die Firewall dient für die Verbindung zwischen den Standorten via Wireguard sowie NAT. 
#sourcecode[```bash
#!/bin/bash
# iptables binary
IPT="/sbin/iptables"

# delete old config
$IPT -F
$IPT -X

# set default policy
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP

# interfaces (intern, extern, DMZ)
INT=ens33
EXT=ens37
wg=wg0

# allow ongoing connections
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# allow loopback
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# create own chains
$IPT -N int_to_ext
$IPT -N wg_to_int
$IPT -N int_to_wg

# divide traffic
$IPT -A FORWARD -i $INT -o $EXT -j int_to_ext
$IPT -A FORWARD -i $wg -o $INT -j wg_to_int
$IPT -A FORWARD -i $INT -o $wg -j int_to_wg

### traffic from intern to extern
$IPT -A int_to_ext -m state --state NEW -p tcp -m multiport --dport http,https -j ACCEPT
$IPT -A int_to_ext -m state --state NEW -p tcp --dport domain -j ACCEPT
$IPT -A int_to_ext -m state --state NEW -p udp --dport domain -j ACCEPT
$IPT -A int_to_ext -m state --state NEW -p udp --dport ntp -j ACCEPT
$IPT -A int_to_ext -m state --state NEW -p icmp -j ACCEPT
$IPT -A int_to_ext -j REJECT

### traffic from wireguard into intern
$IPT -A wg_to_int -m state --state NEW -p tcp -m multiport --dport http,https,3000,9090 -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p tcp --dport domain -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p udp --dport domain -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p udp --dport ntp -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p icmp -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p tcp --dport 22 -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p udp --dport 22 -j ACCEPT
$IPT -A wg_to_int -j REJECT

### traffic from intern to wireguard
$IPT -A int_to_wg -m state --state NEW -p tcp -m multiport --dport http,https,3000,9090 -j ACCEPT
$IPT -A int_to_wg -m state --state NEW -p tcp --dport domain -j ACCEPT
$IPT -A int_to_wg -m state --state NEW -p udp --dport domain -j ACCEPT
$IPT -A int_to_wg -m state --state NEW -p udp --dport ntp -j ACCEPT
$IPT -A int_to_wg -m state --state NEW -p icmp -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p tcp --dport 22 -j ACCEPT
$IPT -A wg_to_int -m state --state NEW -p udp --dport 22 -j ACCEPT
$IPT -A int_to_wg -j REJECT

### rules for the fw
# incoming
$IPT -A INPUT -m state --state NEW -p icmp -j ACCEPT
$IPT -A INPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT
$IPT -A INPUT -m state --state NEW -p udp --dport 22 -j ACCEPT
$IPT -A INPUT -m state --state NEW -p udp --dport 51820 -j ACCEPT

# outgoing
$IPT -A OUTPUT -o $EXT -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p tcp -m multiport --dport http,https -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p tcp --dport domain -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p udp --dport domain -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p udp --dport ntp -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p icmp -j ACCEPT

# nat
$IPT -t nat -A POSTROUTING -o outside -j MASQUERADE
```]
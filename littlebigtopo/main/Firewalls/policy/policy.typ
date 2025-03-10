#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
== Policy
=== Theorie
FortiGate-Policies sind Firewall-Regeln, die definieren, wie der Datenverkehr zwischen verschiedenen Netzwerkzonen, Schnittstellen oder IP-Adressen gesteuert wird. Diese Richtlinien regeln Sicherheit, NAT, Authentifizierung und andere Verkehrsmanagementfunktionen in einer Fortinet FortiGate-Firewall.
=== Konfiguration
Die Konfiguration zeigt eine Policy für den Internet Zugriff:
#sourcecode[```bash
config firewall policy
    edit 2
        set name "LAN_TO_INT"
        set srcintf "port4" # Source Interface
        set dstintf "VLAN10" # Destination Interface
        set action accept
        set srcaddr "route-192.168.50.0/24" # Subnetz des LANs
        set dstaddr "all"  # Erlaubte Ziel Adresse
        set schedule "always"
        set service "PING" "SYSLOG" "Web Access" # Erlaubte Protokolle
        set logtraffic all
        set nat enable # NAT Ein/Aus
    next
end
```]

Diese Policies sollten sehr präzise gestaltet sein, weil sie zuständig dafür sind wer ins Netzwerk kommt und wer nicht. 
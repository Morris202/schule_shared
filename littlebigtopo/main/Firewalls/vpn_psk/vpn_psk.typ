#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
== Site-to-Site-VPN PSK
=== Theorie
Ein Site-to-Site VPN mit PSK (Pre-Shared Key) ermöglicht die sichere Verbindung zwischen zwei Standorten über das Internet. Dabei verwenden beide FortiGate-Firewalls einen gemeinsamen geheimen Schlüssel für die Authentifizierung.
=== Konfiguration
==== VPN Erstellen
#sourcecode[```bash
config vpn ipsec phase1-interface 
    edit "TO_FG2"  # Name der Phase-1-Schnittstelle
        set interface "VLAN10"  # Das physischeInterface, über das der VPN-Tunnel aufgebaut wird
        set remote-gw 209.123.5.2  # Die öffentliche IP-Adresse des entfernten VPN-Gateways
        set psksecret admin  # Der Pre-Shared Key für die Authentifizierung
        set proposal aes128-sha256  # Verschlüsselungs-Algorithmus für Phase 1
    next 
end
config vpn ipsec phase2-interface 
    edit "TO_FG2"  # Name der Phase-2-Schnittstelle
        set phase1name "toFG2"  # Verknüpft der Phase-Konfiguration
        set proposal aes128-sha256  # Verschlüsselungs-Algorithmus für Phase 2
        set src-subnet 192.168.50.0 255.255.255.0  # Das lokale Subnetz, das über den Tunnel erreichbar sein soll
        set dst-subnet 10.0.0.0 255.255.255.0  # Das Ziel-Subnetz auf der Gegenseite des VPN-Tunnels
    next 
end
```]
==== Statische Route für den Tunnel
Es wird eine Statische Route benötigt damit der Traffic über den VPN-Tunnel geht. 
#sourcecode[```bash
config router static 
    edit 1 
        set device "TO_FG2" 
        set dstaddr "TO_FG2_remote" # Gruppe aller remoten Adressen
    next 
end 
```]

==== Policy für den VPN
Eine Policy wird für den VPN-Tunnel konfiguriert.
#sourcecode[```bash
config firewall policy 
    edit 1  
        set name "TO_FG2_local"  # Regel für ausgehenden Traffic
        set srcintf "port4"  # Lokales Interface
        set dstintf "TO_FG2_zone"  # VPN-Zielinterface
        set action accept  # Erlaubt Traffic
        set srcaddr "TO_FG1_local"  # Lokale Adressen
        set dstaddr "TO_FG2_remote"  # Remote-Adressen
        set schedule "always"  # Immer aktiv
        set service "ALL"  # Alle Dienste erlaubt
        set logtraffic all  # Traffic loggen
    next 
end
config firewall policy 
    edit 2  
        set name "TO_FG1_remote"  # Regel für eingehenden Traffic
        set srcintf "TO_FG1_zone"  # VPN-Interface
        set dstintf "port4"  # Lokales Interface
        set action accept  # Erlaubt Traffic
        set srcaddr "TO_FG2_remote"  # Remote-Adressen
        set dstaddr "TO_FG1_local"  # Lokale Adressen
        set schedule "always"  # Immer aktiv
        set service "ALL"  # Alle Dienste erlaubt
        set logtraffic all  # Traffic loggen
    next 
end  
```]
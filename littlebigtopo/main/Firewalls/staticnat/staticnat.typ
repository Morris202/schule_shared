#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
== Statischer NAT
=== Theorie
Eine statische NAT (Destination NAT oder DNAT) auf einer FortiGate-Firewall wird verwendet, um eingehenden Datenverkehr von einer öffentlichen IP-Adresse an eine private IP-Adresse im internen Netzwerk weiterzuleiten. Dies wird oft für Webserver, Mailserver oder andere interne Dienste genutzt.
=== Konfiguration
==== Erstellen der VIP 
#sourcecode[```bash
config firewall vip
    edit "VIP_Webserver"
        set extip 209.123.50.10       # Öffentliche IP-Adresse
        set mappedip 192.168.50.100   # Interne IP des Servers
        set extintf "VLAN10"           # WAN-Schnittstelle
        set portforward enable       # Portweiterleitung aktivieren
        set protocol tcp
        set extport 80               # Öffentlicher Port (HTTP)
        set mappedport 80            # Interner Port
    next
end

```]
==== Zuweisen in der Policy
#sourcecode[```bash
config firewall policy
    edit 10                         # ID der neuen Regel (automatisch nummeriert)
        set name "Allow_HTTP_NAT"
        set srcintf "LAN"           # Eingehendes Interface (WAN)
        set dstintf "VLAN10"            # Ziel-Interface (LAN)
        set srcaddr "VIP_Webserver"            # Erlaubt von überall (anpassen, falls gewünscht)
        set dstaddr "all"  # Die erstellte VIP als Ziel
        set action accept            # Erlauben des Verkehrs
        set schedule "always"
        set service "HTTP"           # Nur HTTP-Verkehr erlauben
        set logtraffic all           # Logging aktivieren
    next
end
```]
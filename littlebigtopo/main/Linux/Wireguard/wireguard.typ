#import "@preview/document:0.1.0": *

== Wireguard VPN
Wireguard ist eigenen Angaben zufolge schneller, simpler, schlanker und nützlicher als IPsec. Verglichen zu OpenVPN hat es eine höhere Performance. Richte einen abgesicherten Wireguard Server und Client mit Skripten unter Ubuntu ein (IPv4 und IPv6) und messe den Datendurchsatz (mit iperf) und die Prozessorauslastung. Zum Schluss besitzt du Skripte für die rasche und sichere Konfiguration von Server und Clients.

=== WG-Client
```bash
sudo hostnamectl hostname WG-Client
```
=== Netzwerkkonfiguration
```bash
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens33:
      dhcp4: true
      nameservers:
        addresses: [8.8.8.8]
  version: 2
```

=== WG-Server
```bash
sudo hostnamectl hostname WG-Server
```

==== Netzwerkkonfiguration
```bash
sudo nano /etc/netplan/.yaml
	network:
	  ethernets:
	    ens33:  
	      dhcp4: no
	      addresses:
	        - 192.168.159.251/24
	      routes:
	        - to: default
	        via: 192.168.159.2
	      nameserver:
	        addresses: [8.8.8.8, 8.8.4.4]
	  version: 2
sudo netplan apply
```

Mit den obigen Befehlen wird die Netzwerkkonfiguration für den Server und den Client konfiguriert. Der Server erhält die IP-Adresse *192.168.159.251* und der Client wird über DHCP konfiguriert.

=== Wireguard Installation
==== Server
Kommen wir anschließend zu der Konfiguration des Wireguard Servers. Zuerst installieren wir Wireguard auf dem Server.
```bash
sudo apt update
sudo apt install wireguard
```
Daraufhin erstellen wir einen privaten und öffentlichen Schlüssel für den Server und versichern uns, dass niemand außer der Owner auf den Schlüssel zugreifen kann. 
```bash
unmask 077
wg genkey > privatekey # Private-key erstellen und in Datei speichern
wg pubkey < privatekey > publickey # public-key erstellen und in Datei speichern
```
Anschließend erstellen wir die Konfigurationsdatei für den Server.
```bash

[Interface]
# Interfaces wg0 configuration
PrivateKey = GLOpF34wB8duF5ogv5Ze/IbStlDi+j1GwkGKem+ExlY=
ListenPort = 51820
Address = 172.16.99.254/24, fd00::254/64 # Server-IP-Adresse

[Peer]
# WG-Client
PublicKey = WuGzEf7E+seUcJ3aih+uykqGcHeptIiJqab+1xaSfgQ= # Public-key des Clients
AllowedIps = 172.16.99.1/32, fd00::1/128 # Erlaubte IP-Adressen
```
Die Konfigurationsdatei für den Server wird in der Datei *wg0.conf* gespeichert.

=== Wireguard starten
Zum Starten von Wireguard auf dem Server und dem Client wird der folgende Befehl verwendet.
```bash
sudo wg-quick up wg0 # Zum Starten von Wireguard
sudo wg-quick down wg0 # Zum Stoppen von Wireguard
sudo systemctl enable wg-quick@wg0 # Autostart von Wireguard
```

=== Überprüfung
Mithilfe des Befehls `wg show` kann überprüft werden, ob die Verbindung zwischen Server und Client erfolgreich hergestellt wurde. Folgender Screenshot zeit die Ausgabe des Befehls.

#figure(
  image("wgsh.png", width: 70%),
  caption: [Wireguard Verbindung]
)

Auf der Abbildung kann man erkennen, dass die Verbindung zwischen Server und Client erfolgreich hergestellt wurde. Der letzte Handshake war in diesem Fall vor 37 Minuten und 2 Sekunden. 

Da wir auch eine IPv6 Verbindung konfiguriert haben, können wir auch die IPv6 Verbindung testen. Dafür verwenden wir den Befehl `ping fd00::1`

#figure(
  image("ipvz6.png", width: 70%),
  caption: [IPv6 Verbindung]
)





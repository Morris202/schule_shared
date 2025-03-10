#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Private VLANs],
  subtitle: none,
  authors: ("Morris Tichy, Lukas Freudensprung",),
  fach: "NWTK",
  thema: "Little Big Topo",
  create-outline: true,
  enumerate: true,
)

= Theorie

Ein Private VLAN erweitert normale VLANs, indem es den Datenverkehr zwischen bestimmten Ports einschränkt. Es gibt drei Haupttypen von PVLAN-Ports: Promiscuous, Community und Isolated. Der Promiscuous Port kann mit allen anderen PVLAN-Ports kommunizieren (z. B. ein Gateway oder Router). Community Ports können untereinander und mit dem Promiscuous Port kommunizieren, aber nicht mit Isolated Ports oder anderen Community Groups. Isolated Ports dürfen nur mit dem Promiscuous Port kommunizieren, nicht untereinander oder mit Community Ports. Das erhöht die Sicherheit, indem bestimmte Geräte voneinander getrennt bleiben.

= Konzept

In dem Standort Sanctum Sanctorum gibt es einen RODC und einen Client (VPCS). DIese sind durch Private Isolated VLANs von einander getrennt und kommen daher nur zu ihrem Gateway, der pfsense, über den Promiscuous Port.

= Konfiguration

== SW-Sans

```shell
# Konfiguration des Switches und der Private VLANs

en
conf t
ho SW-SanS
no ip domain-lookup
usern cisco priv 15
usern cisco al sc se cisco
ip domain-name 5CN
crypto key ge rsa us m 1024
ip ssh v 2

line vty 0 924
transport input ssh
login local
exit

line con 0
exec-time 0 0
exit

vtp mode transparent

# Private Isolated VLAN erstellen
vlan 100
name isolated-vlan-100
private-vlan isolated
exit 

# Primary VLAN erstellen
vlan 10
name primary-vlan-10
private-vlan primary
private-vlan association add 100
exit

# Promiscuous Port konfigurieren
int gi0/0
des TO_pfsense2
switchport mode private-vlan promiscuous
switchport private-vlan mapping 10 100
exit

# Isolated Ports konfigurieren
int gi0/1
des TO_RODC
switchport mode private-vlan host
switchport private-vlan host-association 10 100
exit

int gi0/2
des TO_PC2
switchport mode private-vlan host
switchport private-vlan host-association 10 100
exit
```

= Test

In folgendem Screenshot ist zu sehen, wie PC2 versucht den RODC mit der IP Adresse 192.168.125.1 zu erreichen. Da PC2 nur mit dem Promiscuous Port kommunizieren darf kann er nur die IP Adresse 192.168.125.254 (pfsense) pingen.

#figure(
  image("figures/PC2_Test-Ping.png", width: 80%),
  caption: [Test Ping von PC2],
)
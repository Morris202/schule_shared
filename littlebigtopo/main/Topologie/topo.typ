#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

Unsere Topologie besteht aus den drei ISPs: Start Tower, Bifröst und S.H.I.E.L.D., die die fünf Standorte miteinander verbinden. Die Namen der Standorte sowie der ISPs sind von dem Marvel Universum inspiriert.

#figure(
  image("figures/topologie.png", width: 100%),
  caption: [Topologie],
)

== Avenger-HQ

Avenger-HQ ist der zentrale Windows-Standort mit der Forest-Root-Domäne AvengerHQ.at und wird durch ein redundantes *FortiGate-HA-Cluster* abgesichert. Er umfasst unter anderem die beiden Domänencontroller *DC1* und *DC2* sowie einen *DFS- und Bind9-Server*. Zudem gibt es eine *1-Tier-PKI* mit einem *IIS-Webserver*, der über ein Webserver-Zertifikat HTTPS bereitstellt. Für Testzwecke sind die Windows-Clients *WinCLI1* und *WinCLI2* integriert.

== Wakanda

Wakanda ist der zweite Windows-Standort und beherbergt die Subdomäne Wakanda.AvengerHQ.at. Der Standort wird durch eine *FortiGate-Firewall* abgesichert und umfasst die beiden Domänencontroller *DC3* und *DC4* sowie den Windows-Client *WinCLI3*.

== Sanctum Sanctorum

Sanctum Sanctorum ist ein sicherheitskritischer Standort mit minimaler Infrastruktur. Daher wird dort ausschließlich ein *Read-Only Domain Controller (RODC)* betrieben. Eine *pfSense-Firewall* schützt den Standort vor externen Bedrohungen. Zusätzlich wurden auf dem Switch Private Isolated VLANs konfiguriert, um die interne Sicherheit weiter zu erhöhen. Zur Erprobung der Private VLANs wurde der Client *VPC1* integriert.

== NewYork

NewYork ist der zentrale Linux-Standort und wird durch eine *Linux-Firewall* mit IPTables abgesichert. Der Standort umfasst unter anderem den Monitoring-Server *Prometheus/Grafana* sowie den Ubuntu Client *LinCLI1* zur Datenüberwachung.

== Hawkeye Farm

Die Hawkeye Farm ist ein rein Cisco-proprietärer Standort und verfügt über eine redundante Firewall, die mittels IP SLA und HSRP abgesichert ist. Der Standort umfasst ein komplexes Switching, das folgende Funktionen integriert: VLANs, VTP, RSTP, EtherChannel sowie Sicherheitsmaßnahmen wie Port-Security, verschiedene Guards und ein gehärtetes PVST+.

Für Testzwecke sind der VPC VPNC1 und der Windows-Client RSPAN-CLI integriert.

== Stark Tower, Bifröst und S.H.I.E.L.D

Der ISP besteht aus den Standorten Stark Tower, Bifröst und S.H.I.E.L.D.. Als Underlay kommt OSPF zum Einsatz, während für die interne Adjazenzbildung iBGP verwendet wird. Zur Anbindung der ISPs untereinander dient eBGP.

Als Overlay wurde MPLS implementiert. Zusätzlich wurde am ISP Stark Tower ein Hub-and-Spoke-FlexVPN eingerichtet, um den Datenverkehr zu verschlüsseln.

== VPN Verbindungen


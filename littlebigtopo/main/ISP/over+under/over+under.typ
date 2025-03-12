#import "@preview/codelst:2.0.2": sourcecode
== ISP Overlay + Underlay
Wie auch schon oben erwähnt wurde, wurde für die ISP-Topologie ein Overlay und ein Underlay erstellt. Das Overlay ist für die Verbindung innerhalb des ISPs zuständig und das Underlay für die Verbindung zwischen den beiden Routers. Zwischen den Router wurde OSPF konfiguriert. Bei dem Overlay wurde MPLS konfiguriert.

=== Underlay
Das physische oder grundlegende Netzwerk (z. B. Router, Switches, Glasfaserleitungen), das Daten transportiert. In unserem Fall wurde OSPF konfiguriert.

*R1*
#sourcecode[```bash
router ospf 30
router-id 10.0.3.14
network 10.0.3.12 0.0.0.3 area 30
network 10.0.3.8 0.0.0.3 area 30
exit
```]
=== Overlay
Ein virtuelles Netzwerk, das auf dem Underlay-Netzwerk aufbaut und zusätzliche Funktionen wie VPNs oder SD-WAN ermöglicht. In unserem Fall wurde MPLS konfiguriert.

*R1*
#sourcecode[```bash
mpls ip 
```]

=== Überprüfung
#figure(
  image("mpls.png", width: 80%),
  caption: [MPLS Forward-Table],
)



=== BGP
BGP ist ein Routing-Protokoll, das für den Austausch von Routing-Informationen zwischen verschiedenen Autonomen Systemen (AS) verwendet wird.
Zwischen den ISP wurde BGP konfiguriert. Folgender Codeabschnitt zeigt diese Konfiguration.

*R1*
#sourcecode[```bash 
router BGP 2
network 209.123.6.0 m 255.255.255.0
neighbor 2.2.2.2 remote-as 2
neighbor 2.2.2.2 update-source lo1
neighbor 2.2.2.3 remote-as 2
neighbor 2.2.2.3 update-source lo1
neighbor 2.2.2.4 remote-as 2
neighbor 2.2.2.4 update-source lo1
neighbor 2.2.2.5 remote-as 2
neighbor 2.2.2.5 update-source lo1
neighbor 209.123.6.1 remote-as 1
neighbor 209.123.6.1 update-source gi0/1
exit
```]

=== Überprüfung
Mithilfe von *sh ip bgp sum* kann überprüft werden, ob die Verbindung zwischen den zwei ISP aufgebaut wurde.
#figure(
  image("bgproute.png", width: 80%),
  caption: [BGP Verbindung],
)

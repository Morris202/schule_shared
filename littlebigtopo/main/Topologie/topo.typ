#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

Unsere Topologie besteht aus den drei ISPs Start Tower, Bifröst und S.H.I.E.L.D., die die fünf Standorte miteinander verbinden.

#figure(
  image("figures/topologie.png", width: 100%),
  caption: [Topologie],
)

== Avenger-HQ

Avenger-HQ ist der zentrale Windows-Standort mit der Forest-Root Domäne AvengerHQ.at und wird durch einen redundanten FortiGate-HA-Cluster abgesichert. Er umfasst unter anderem die beiden Domänencontroller DC1 und DC2 sowie einen DFS- und Bind9 Server. Darüber hinaus gibt es eine 1-Tier-PKI mit einem IIS-Webserver, der durch ein Webserver-Zertifikat HTTPS bereitstellt. Zu Testzwecken gibt es zwei Windows Clients WinCLI1 und WinCLI2.

== Wakanda

Wakanda ist der zweite Windows-Standort und beherbergt die Subdomäne Wakanda.AvengerHQ.at. Der Standort wird durch eine FortiGate-Firewall abgesichert und umfasst die beiden Domänencontroller DC3 und DC4 sowie den Windows-Client WinCLI3.

== Sanctum Sanctorum

Sanctum Sanctorum ist ein sicherheitskritischer Standort mit minimaler Infrastruktur. Daher wird dort ausschließlich ein Read-Only Domain Controller (RODC) betrieben. Eine pfSense-Firewall schützt den Standort vor externen Bedrohungen. Zusätzlich wurden auf dem Switch Private Isolated VLANs konfiguriert, um die interne Sicherheit weiter zu erhöhen.
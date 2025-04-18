#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

#show: doc => conf(
  doc,
  title: [Proxmox],
  subtitle: none,
  authors: ("Lukas Freudensprung", "Morris Tichy",),
  fach: "NWTOS-Infra",
  thema: "Proxmox",
  create-outline: true,
  enumerate: true
)
= Proxmox
== Theorie
=== Was ist Proxmox?
Proxmox ist eine Open-Source-Software, die es ermöglicht, virtuelle Maschinen und Container zu verwalten. Es basiert auf Debian und nutzt KVM als Hypervisor. Proxmox bietet eine Web-Oberfläche, über die die virtuellen Maschinen und Container verwaltet werden können. Es unterstützt auch Hochverfügbarkeit und Clustering.

== Installation von Proxmox
=== Voraussetzungen
Damit Proxmox unter VMware Workstation installiert werden kann, müssen folgende Voraussetzungen erfüllt sein:
- Installation von WMware Workstation
- Download des Proxmox-ISOs - bei der Offiziellen Proxmox-Website #link("https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso")[
  hier
]

=== Erstellen der Proxmox-VM
Öffnen sie VMware Workstation und erstellen sie eine neue VM. Wählen sie als Betriebssystem *"Linux" *und als Version *"Debian 10.x 64-bit"*. Wählen sie das *ISO* aus, das sie zuvor heruntergeladen haben. Außerdem ist es wichtig bei den Einstellungen der VM unter *Processors > Virtualization engine * folgende Einstellungen zu treffen:
#figure(
  image("figures/vmsettings.png", width: 70%),
  caption: [Virtualization engine Einstellungen]
)

=== Installation von Proxmox
Nach den Einstellungen der virtuellen Maschine können sie die VM starten. In der nachfolgenden Grafik sehen sie den Startbildschirm von Proxmox.
#figure(
  image("figures/installation1.png", width: 70%),
  caption: [Installation von Proxmox, Startbildschirm]
)

Es wird *Install Proxmox VE (Graphical)* ausgewählt und mit Enter bestätigt. Die nächsten zwei Schritte können einfach mit *Next* bestätigt werden.

Bei *Location and Time Zone selection* wählen wir unsere Zeitzonen aus. 

#figure(
  image("figures/installation2.png", width: 70%),
  caption: [Installation von Proxmox, Zeitzonen-Auswahl]
)
\
\
Bei *Administration Password and Email Address* wird ein Passwort für den Administrator festgelegt und eine E-Mail-Adresse angegeben.

#figure(
  image("figures/installation3.png", width: 70%),
  caption: [Installation von Proxmox, Passwort und E-Mail-Adresse]
)

Unter *Managment Network Configuration* wird eine IP-Adresse und ein Domain-Name des Proxmox-Servers festgelegt.

#figure(
  image("figures/installation4.png", width: 70%),
  caption: [Installation von Proxmox, Netzwerkkonfiguration]
)

Abschließend kann bei *Summary* noch einmal überprüft werden, ob alle Einstellungen korrekt sind. Mit *Install* wird die Installation gestartet. 

=== Web-Oberfläche von Proxmox
Der Proxmox-Server sollte unter der davor konfigurierten IP-Adresse erreichbar sein. In unserem Fall *\<192.168.178.199\>*.

#figure(
  image("figures/webaccess.png", width: 80%),
  caption: [Web-Oberfläche von Proxmox]
)

Es wird ein Username und das zuvor festgelegte Passwort benötigt, um sich anzumelden. Nach dem Login kann die Web-Oberfläche von Proxmox verwendet werden.

#figure(
  image("figures/webaccess2.png", width: 80%),
  caption: [Anmeldedaten für die Web-Oberfläche]
)

Nach der Anmeldung wird die Startseite von Proxmox angezeigt.
#figure(
  image("figures/webaccess3.png", width: 80%),
  caption: [Web-Oberfläche von Proxmox, Startseite]
)

== Konfiguration eines High Availability Cluster
=== Voraussetzungen
Damit ein High Availability Cluster konfiguriert werden kann, müssen folgende Voraussetzungen erfüllt sein:
- 3 Proxmox-Server
- Disk Storage 

Bei zwei Proxmoxservern gibt es ein Problem, da durch die Mastersuche eine Schleife entsteht und deshalb, bei 2 Servern, nie ein Master ausgewählt werden kann. Deshalb müssen wir 3 Proxmoxserver verwenden.

=== Erstellen eines Clusters
*Auf Proxmox-ve1:*

Wir unter *Cluster > Create Cluster* ein neuer Cluster erstellt. 

#figure(
  image("figures/proxmoxcl1.png", width: 80%),
  caption: [Auf dem Proxmox-ve1: Cluster erstellen]
)

Anschließend wird eine Name für den Cluster festgelegt und die IP-Adresse des Proxmox-ve1 eingetragen.

#figure(
  image("figures/proxmoxclustername.png", width: 80%),
  caption: [Auf dem Proxmox-ve1: Cluster Name festlegen]
)

Unter dem erstellten Cluster wird *Join Information* ausgewählt und der *Join Token* kopiert.

#figure(
  image("figures/joininformation.png", width: 80%),
  caption: [Auf dem Proxmox-ve1: Join Information]
)
\
*Auf Proxmox-ve2:*

Unter *Cluster > Join Cluster* wird der *Join Token* und das Root Password von Proxmox-ve1 eingetragen.

#figure(
  image("figures/joncluster2.png", width: 80%),
  caption: [Auf dem Proxmox-ve2: Cluster beitreten]
)

*Auf Proxmox-ve3:*

Der Proxmox-ve3 wird ebenfalls dem Cluster beigetreten und der obige Schritt wiederholt.

==== Überprüfung
Nachdem alle Proxmox-Server dem Cluster beigetreten sind, kann unter *Proxmox-ve1* überprüft werden, ob alle Server verbunden sind.

#figure(
  image("figures/proxmoxcluster.png", width: 50%),
  caption: [Proxmox-ve1: Cluster Übersicht]
)

=== Konfiguration des Zettabyte File System (ZFS)
*Auf Proxmox-ve1*

Unter *Disks* wird geschaut ob die Disks zuerst vorhanden sind und danach auf *ZFS* gewechselt. 

#figure(
  image("figures/zfs.png", width: 80%),
  caption: [Proxmox-ve1: Disks verwalten]
)

Unter *ZFS > Create ZFS* wird ein neues ZFS erstellt. Es wird ein Name festgelegt, als Raid-Level *Mirror* und die Disks ausgewählt.

#figure(
  image("figures/zfs2.png", width: 80%),
  caption: [Proxmox-ve1: ZFS erstellen]
)

Anschließend wird die erstellte ZFS angezeigt. 

*Auf Proxmox-ve2 & Proxmox-ve3*

Werden die gleichen Schritte wie auf Proxmox-ve1 durchgeführt. Es ist wichtig dabei zu beachten, dass der Name gleich ist und das Hackerl bei Add-Storage nicht ausgewählt ist. 

#figure(
  image("figures/zfs3.png", width: 80%),
  caption: [Proxmox-ve2 & Proxmox-ve3: ZFS erstellen]
)

*Unter DataCenter > Storage > Edit ZFS* werden die verschiedenen Nodes miteinander verbunden.

#figure(
  image("figures/zfs4.png", width: 80%),
  caption: [HA-Cluster bilden]
)

== Überprüfung
Nachdem der Cluster erstellt worden ist, ist es an der Zeit den Cluster zu testen und zu überprüfen, ob alles richtig funktioniert. Wir gehen dazu in die VM Einstellungen und trennen die Netzwerkverbindung.

#figure(
  image("figures/clustercheck.png", width: 68%),
  caption: [Cluster Überprüfung]
)

Wie man jezt sehen kann, wird auf dem Promox-ve2, auf dem Ubuntu läuft ein Ausfall erkannt. 

#figure(
  image("figures/clustercheck2.png", width: 68%),
  caption: [Cluster Überprüfung]
)

Damit wir bemerken, wann der Cluster umschalten, führen wir dazu einfach einen Ping auf die IP-Adresse des Ubuntu-Servers aus.

#sourcecode(```bash
  ping -t 192.168.178.117 # IP-Adresse des Servers
```)

Nach 2:30 Minuten wird der Cluster umgeschalten und der Ping wird wieder erfolgreich. Dies ist in der nachfolgenden Grafik zu erkennen. 

#figure(
  image("figures/clustercheck3.png", width: 100%),
  caption: [Cluster Überprüfung]
)
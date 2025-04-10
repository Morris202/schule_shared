#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode

= Ceph

== Ceph Überblick

Ceph ist eine Open-Source-Software-definierte Speicherlösung, die entwickelt wurde, um die Anforderungen moderner Unternehmen an Block-, Datei- und Objektspeicher zu erfüllen. Dank ihrer hoch skalierbaren Architektur wird sie zunehmend als Standard für wachstumsstarke Blockspeicher, Objektspeicher und Data Lakes eingesetzt. Ceph ermöglicht es, Daten von physischer Speicherhardware zu entkoppeln, was beispiellose Skalierungs- und Fehlermanagementfähigkeiten bietet. Dies macht Ceph ideal für Cloud-Umgebungen, OpenStack, Kubernetes und andere mikroservice- und containerbasierte Workloads, da es effektiv große Datenvolumen speichern kann.

Ceph speichert Daten als Objekte innerhalb logischer Speicherpools. Ein Cluster kann mehrere Pools haben, die jeweils auf unterschiedliche Leistungs- oder Kapazitätsanforderungen abgestimmt sind. Um Skalierung, Lastverteilung und Wiederherstellung effizient zu handhaben, teilt Ceph die Pools in Platzierungsgruppen (Placement Groups, PGs) auf. Der CRUSH-Algorithmus bestimmt die Platzierungsgruppe für das Speichern eines Objekts und berechnet anschließend, welche OSDs die Platzierungsgruppe speichern sollen.

Zu den Hauptmerkmalen von Ceph gehören:
  - Dünn provisionierter Blockspeicher zur Optimierung der Speichernutzung​
  - Teilweises oder vollständiges Lesen und Schreiben sowie atomare Transaktionen​
  - Replikation und Erasure Coding zum Datenschutz​
  - Unterstützung von Snapshots, Klonen und Layering​
  - POSIX-Dateisystem-Semantik​
  - Key-Value-Zuordnungen auf Objektebene​
  - Kompatibilität mit Swift- und AWS S3-Objekt-APIs

Zahlreiche Unternehmen aus verschiedenen Branchen, darunter CERN, Deutsche Telekom, Bloomberg, Cisco, DreamHost und DigitalOcean, nutzen Ceph aufgrund seiner Flexibilität, Skalierbarkeit und Robustheit.

== Ceph Komponenten

=== Storage Interfaces
Ceph stellt mehrere Wege zum Speichern der Daten bereit. Diese sind: CephFS (ein Filesystem), RBD (block Geräte), RADOS (Objekt Speicher). Alle diese basieren aber eigentlich auf RADOS. Die anderen geben sich nur als Filesystem oder Block Geräte aus.

=== Daemon Typen
Ein Ceph-Speichercluster besteht aus mehreren Daemon-Typen:
  - Cluster-Monitore (ceph-mon): Verwalten den Zustand des Clusters, verfolgen aktive und ausgefallene Knoten, die Cluster-Konfiguration und Informationen über die Datenplatzierung.
  - Manager (ceph-mgr): Behalten Laufzeitmetriken des Clusters bei, ermöglichen Dashboard-Funktionen und bieten Schnittstellen zu externen Überwachungssystemen.
  - Objektspeichergeräte (ceph-osd): Ein Prozess der auf einem Storage Server rennt und für die Verwaltung eines einzigen Speichers ist. Z.B. eine einzige Disk.
  - RADOS Gateways (ceph-rgw): Bieten Objekt-Speicher-APIs (Swift und S3) über HTTP/HTTPS an.​
  - Metadaten-Server (ceph-mds): Speichern Metadaten für das Ceph-Dateisystem und ermöglichen die Nutzung von POSIX-Semantiken für den Dateizugriff.​
  - iSCSI Gateways (ceph-iscsi): Stellen iSCSI-Ziele für traditionelle Blockspeicher-Workloads wie VMware oder Windows Server bereit.

=== Pools
Ein Pool ist eine Abstraktion, die entweder als „repliziert“ oder „erasure coded“ (also fehlerkorrigierend) ausgelegt werden kann. In Ceph wird die Methode des Datenschutzes auf Pool-Ebene festgelegt. Ceph bietet und unterstützt zwei Arten des Datenschutzes: Replikation und Erasure Coding. Objekte werden in Pools gespeichert. Ein Speicherpool ist eine Sammlung von Speichervolumen. Ein Speichervolumen ist die grundlegende Speichereinheit, beispielsweise zugewiesener Speicherplatz auf einer Festplatte oder eine einzelne Bandkassette. Der Server nutzt diese Speichervolumen, um gesicherte, archivierte oder platzverwaltete Dateien zu speichern. Placement Groups sind Teile der Pools

== Checklisten

- [ ] cephadm-Skript herunterladen

- [ ] Skript ausführbar machen und cephadm installieren

- [ ] Mit cephadm ceph-common installieren

- [ ] Monitor-Node-Konfiguration in /etc/ceph/ceph.conf anlegen und Keyrings erstellen

- [ ] Monitor-Node „bootstrappen“

- [ ]  Credentials abrufen und am Web-UI einloggen

- [ ] SSH-Key (/etc/ceph/ceph.pub) auf die OSD-Nodes in .ssh/authorized_keys kopieren

- [ ] OSD-Nodes einbinden

- [ ] Labels für OSD-Nodes setzen

- [ ] OSDs mit Festplatten erstellen

- [ ] Die Keyrings auf die OSD-Nodes kopieren

- [ ] Das SD-Pool erstellen

- [ ] Filesystem kreieren

- [ ] Filesystem durch ceph-fuse einbinden
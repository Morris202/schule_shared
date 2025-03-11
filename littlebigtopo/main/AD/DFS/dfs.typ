#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "DFS"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "LAN"
New-NetIPAddress -InterfaceAlias "LAN" -IPAddress "192.168.50.4" -PrefixLength 24 -DefaultGateway "192.168.50.254"
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
Add-Computer -DomainName "AvengerHQ.at" -Credential (Get-Credential) -Restart
```]

=== Konfiguration

Windows -> Search -> Disk Management

#figure(
  image("figures/HardDisk_erstellen.png", width: 70%),
  caption: [Hard Disk erstellen],
)

Windows -> Search -> Disk Management -> Right Click on Disk 1 -> New Simple Volume -> Select Letter S: -> Name: Share -> Finish

#figure(
  image("figures/HardDisk_konfigurieren.png", width: 80%),
  caption: [Neues Volume erstellen],
)

#figure(
  image("figures/HardDisk_konfigurieren_2.png", width: 70%),
  caption: [Volumen konfigurieren],
)

=== Ordnerstruktur erstellen

Für jede Abteilung wurde ein Ordner erstellt, zusätzlich auch ein Allgemein Ordner.

#figure(
  image("figures/Ordnerstruktur_erstellen.png", width: 70%),
  caption: [Ordnerstruktur erstellen],
)

=== AGDLP

Das AGDLP (Account, Global, Domain Local, Permission) Konzept schaut wie folgt aus:

#figure(
  image("figures/AGDLP.png", width: 70%),
  caption: [AGDLP Konzept],
)

=== DFS verwalten

Server Manger -> Tools -> DFS Management -> Namespaces -> New Namespace -> Select DFS Server -> Name: DFS -> Next -> Create

#figure(
  image("figures/Namespace_erstellen.png", width: 70%),
  caption: [DFS Namespace erstellen],
)

#figure(
  image("figures/DFS_Management.png", width: 80%),
  caption: [DFS Management],
)

New Folder -> zB. Marketing -> Add -> Browse -> Share\\Marketing\
Für alle anderen Ordner wiederholen

#figure(
  image("figures/DFS_Folder.png", width: 80%),
  caption: [DFS Ordner erstellen],
)

#figure(
  image("figures/DFS_alle_Folder.png", width: 80%),
  caption: [DFS Ordnerstruktur],
)

=== GPO DriveMapPolicy

Group Policy Management -> New -> DriveMapPolicy -> Link to all Users OUs -> Edit und zu folgendem Pfad navigieren:
User Configuration\\Preferences\\Drive Maps\\New MappedDrive

#figure(
  image("figures/DriveMapPolicy.png", width: 80%),
  caption: [GPO DriveMapPolicy],
)

=== Überprüfung

#figure(
  image("figures/GPO_test.png", width: 80%),
  caption: [GPO Überprüfung],
)


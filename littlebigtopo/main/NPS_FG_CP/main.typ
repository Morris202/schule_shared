#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [NPS FortiGate Captive Portal],
  subtitle: none,
  authors: ("Morris Tichy", "Lukas Freudensprung",),
  fach: "Little Big Topo",
  thema: "NPS FortiGate Captive Portal",
  create-outline: true,
  enumerate: true
)

= NPS FortiGate Captive Portal
Mithilfe des NPS Dienstes unter Windows sollen sich die AD-User auf einer FortiGate oder um ins Internet zu gelangen authentifizieren. Diese Datei beschreibt die Konfiguration des NPS Dienstes und der FortiGate.

== NPS Konfiguration
Nachdem der NPS Server grundkonfiguriert wurde und der Network Policy Server installiert ist, wird zuerst ein neuer Radius-Client erstellt. *NPS > Radius Client und Server > Radius Clients >* Neu. Hier wird die IP-Adresse der FortiGate und ein gemeinsames Passwort eingetragen.

#figure(
  image("radiuscli.png", width: 70%),
  caption: [Radius Client Konfiguration]
)

+ Hinzufügen der FortiGate zu den 'RADIUS Clients' in der MS NPS-Konfiguration (wählen Sie 'RADIUS Clients' und wählen Sie 'Neu').
+ Geben Sie die Details des FortiGate RADIUS-Clients ein:

- Versichern Sie sich, dass das Kästchen 'Enable this RADIUS client' aktiviert ist. 
- Geben Sie den 'Friendly name', die IP-Adresse und das Passwort ein (das gleiche Passwort, das auf der FortiGate konfiguriert wurde).
- Der Rest kann auf den Standardwerten belassen werden.

=== Connection Request Policies
+ Erstellen Sie eine 'Connection Request Policy' für die FortiGate (wählen Sie 'Connection Request Policies' und wählen Sie 'Neu').
+ Geben Sie den 'Policy name' an und wählen Sie 'Weiter'.
+ Unter 'Specify Conditions' wählen Sie 'Add…' und wählen Sie 'Client IPv4 Address' und geben Sie die IP-Adresse der FortiGate an.

#figure(
  image("FortiGatepol.png", width: 70%),
  caption: [Connection Request Policy]
)
#figure(
  image("ipv4cliadd.png", width: 70%),
  caption: [Connection Request Policy]
)

=== Network Policies
+ Erstelle eine 'Network Policy' für Zugriffsanfragen, die von der FortiGate kommen (wählen Sie 'Network Policies' und wählen Sie 'Neu'). NPS -> Policies -> Network Policies.
+ Geben Sie den 'Policy name' an und wählen Sie 'Weiter'.

Adding Network Policy with AD authentication.

Hinzufügen einer Netzwerkrichtlinie mit AD-Authentifizierung.

+ Unter 'Specify Conditions' wählen Sie 'Add…' und wählen Sie 'Windows Groups' wählen Sie 'Add Groups…' und geben Sie den AD-Gruppennamen ein. 
Wenn Sie fertig sind, bestätigen Sie die Einstellungen mit 'OK' und 'Hinzufügen…'.
- Geben Sie die Zugriffsberechtigung an und wählen Sie 'Weiter
- Der Rest kann auf den Standardwerten belassen werden.
#figure(
  image("networkpol.png", width: 70%),
  caption: [Funktionsbereite Network Policy]
)

=== Vendor Specific Attributes

#figure(
  image("vendor.png", width: 70%),
  caption: [Vendor Specific Attributes]
)

+ Drücken Sie auf 'Add…' und wählen Sie 'Vendor-Specific'
+ Wählen Sie 'Add…' und geben Sie die Vendor Code '12356' ein und Yes. It conforms. 
+ Dürcken sie nun auf Configure Attribute und geben Sie die Attribute ein. vendor: 12356, attribute: 1, as string: Domain_User.
+ Überprüfen der Konfiguration und Finish

== FortiGate Konfiguration
Nachdem der NPS Server konfiguriert wurde, wird die FortiGate konfiguriert. Dazu wird ein neuer Radius-Server erstellt. *User & Device > Radius Servers >* Neu. Hier wird die IP-Adresse des NPS Servers und das gemeinsame Passwort eingetragen. Unter Test Connectivity kann die Verbindung getestet werden und mit Test Credentials kann ein Anmeldevorgang simuliert werden.

#figure(
  image("fgradius.png", width: 70%),
  caption: [Radius Server Konfiguration in der FortiGate]
)

Anschließend wird eine neue User Group erstellt die als Remote Server den NPS Server eingetragen hat. *User & Device > User Groups >* Neu. Hier wird der Name der Gruppe und der NPS Server eingetragen. Daraufhin wird unter dem jeweiligen Port ein neues Captive Portal erstellt. 

#figure(
  image("cp.png", width: 70%),
  caption: [Captive Portal Konfiguration]
)

= Test
Wenn alle Konfigurationschriffe durchgeführt wurden, sollte sich ein AD-User auf der FortiGate oder im Internet authentifizieren können. Folgendes sollte passieren:

#figure(
  image("anmeldung.png", width: 70%),
  caption: [Login Screen]
)


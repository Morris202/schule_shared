#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [GPOs],
  subtitle: none,
  authors: ("Morris Tichy, Lukas Freudensprung",),
  fach: "NWTK",
  thema: "Little Big Topo",
  create-outline: true,
  enumerate: true,
)

= GPO Desktop Hintergrund

== Fileserver Ablageort

Durch den Fileserver ist es möglich ein Hintergrundbild für alle Clients zu speichern. Dazu wurde unter dem Ordner Share und Allgemein ein Hintergrundbild gespeichert.

#figure(
  image("figures/Desktop_Wallpaper_Fileserver.png", width: 80%),
  caption: [Fileserver Desktop Wallpaper],
)

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

#figure(
  image("figures/Desktop_Wallpaper_GPO_create.png", width: 70%),
  caption: [Desktop Wallpaper GPO erstellen],
)

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
User Configuration -> Policies -> Administrative Templates -> Desktop -> Desktop Wallpaper\

Dort kann dann die Option enabled und der Pfad zum Hintergrundbild angegeben werden.

#figure(
  image("figures/Desktop_Wallpaper_GPO.png", width: 70%),
  caption: [Desktop Wallpaper GPO konfigurieren],
)

== Überprüfung

Wenn sich jetzt ein Benutzer ab- und anmeldet erscheint der neue Hintergrund wie in folgendem Bild zu sehen:

#figure(
  image("figures/Desktop_Wallpaper_GPO_test.png", width: 80%),
  caption: [Desktop Wallpaper GPO test],
)

= GPO Lock/Logon Screen

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
Computer Configuration -> Policies -> Administrative Templates -> Control Panel -> Personalization -> Force a specific default lock screen and logon image

#figure(
  image("figures/Lock_Logon_Image_GPO_path.png", width: 80%),
  caption: [Lock/Logon Screen GPO Pfad],
)

Dort kann dann die Option enabled und der Pfad zum Hintergrundbild angegeben werden. In diesem Beispiel wird ein bereits vorhandenes Bild verwendet.

#figure(
  image("figures/Lock_Logon_Image_GPO.png", width: 70%),
  caption: [Lock/Logon Screen GPO konfigurieren],
)

== Überprüfung

Wenn sich jetzt ein Benutzer abmeldet erscheint in der Anmeldeansicht das neue Lock/Logon Bild.

#figure(
  image("figures/Lock_Logon_Image_GPO_test.png", width: 80%),
  caption: [Lock/Logon Screen GPO test],
)

= GPO Last signed in user not shown

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options -> Interactive logon: Do not display last signed-in

#figure(
  image("figures/last_signed_in_GPO_path.png", width: 80%),
  caption: [Last signed in GPO erstellen],
)

Dort kann dann die Option enabled und der Pfad zum Hintergrundbild angegeben werden. In diesem Beispiel wird ein bereits vorhandenes Bild verwendet.

#figure(
  image("figures/last_signed_in_GPO.png", width: 50%),
  caption: [Last signed in GPO konfigurieren],
)

== Überprüfung

Wenn sich jetzt ein Benutzer abmeldet erscheint in der Anmeldeansicht kein Benutzername mehr.

#figure(
  image("figures/last_signed_in_GPO_test.png", width: 90%),
  caption: [Last signed in GPO test],
)

= GPO Password Security Settings

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Account Policies -> Password Policy

Dort können jetzt die verschiedenen Einstellungen für das Passwort festgelegt werden.

#figure(
  image("figures/Password_Security_GPO.png", width: 90%),
  caption: [Password Security GPO konfigurieren],
)

= GPO Lokale Firewall Einstellungen (per PS-Skript)

== PS-Skript erstellen

Zuerst wird ein PowerShell Skript erstellt, welches die Firewall Einstellungen setzt. Dieses Skript wird dann auf dem Domänen Controller gespeichert. Es handelt sich in diesem Skript vor allem um IPv6 Regeln, da diese in unserem Fall deaktiviert werden sollen.

```powershell
# Liste wichtiger IPv6-Firewallregeln
$importantRules = @(
    "Core Networking - ICMPv6-In",
    "Core Networking - Teredo-In",
    "Core Networking - LLMNR (UDP-In)",
    "Remote Desktop - User Mode (TCP-In)",
    "Remote Desktop - User Mode (UDP-In)"
)

# Deaktiviere die angegebenen Regeln
foreach ($rule in $importantRules) {
    if (Get-NetFirewallRule -DisplayName $rule -ErrorAction SilentlyContinue) {
        Set-NetFirewallRule -DisplayName $rule -Enabled False
        Write-Output "Regel '$rule' wurde deaktiviert."
    } else {
        Write-Output "Regel '$rule' nicht gefunden."
    }
}
```

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
Computer Configuration -> Policies -> Windows Settings -> Scripts -> Startup

#figure(
  image("figures/Local_Firewall_GPO_path.png", width: 80%),
  caption: [Local Firewall GPO Pfad],
)

Dort kann jetzt das Skript hinzugefügt werden, welches beim Starten des Computers ausgeführt wird.

#figure(
  image("figures/Local_Firewall_GPO.png", width: 70%),
  caption: [Local Firewall GPO konfigurieren],
)

= GPO Account Sperrung

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
Computer Configuration -> Policies -> Windows Settings -> Security Settings  -> Account Policies -> Account Lockout Policy

Dort können dann die einzelnen Konfigurationen vorgenommen werden, wie in folgendem Bild zu sehen:

#figure(
  image("figures/Account_Sperrung_GPO.png", width: 90%),
  caption: [Account Sperrung GPO konfigurieren],
)

== Überprüfung

Sollte ein Angreifer versuchen das Password mit einer Brute-Force Attacke kacken, wird der Account nach 7 Fehlversuchen gesperrt.

#figure(
  image("figures/Account_Sperrung_GPO_test.png", width: 90%),
  caption: [Last signed in GPO test],
)

= GPO Software Installation

== .msi Datei bereitstellen

Als Software wird der Google Chrome Browser installiert, die zugehörige .msi Datei kann im Internet heruntergeladen werden. Diese muss dann auf einen erreichbaren Share gespeichert werden, in unserm Fall auf dem Fileserver.

== GPO erstellen

Auf dem Domänen Controller wird im Server Manager unter Tools die Gruppenrichtlinienverwaltung geöffnet. Dort wird eine neue Gruppenrichtlinie erstellt und konfiguriert.

== GPO bearbeiten

In der Gruppenrichtlinienverwaltung kann dann unter folgendem Pfad die Gruppenrichtlinie konfiguriert werden:\
User Configuration -> Policies -> Software Settings -> Software Installation

#figure(
  image("figures/Software_Installation_GPO.png", width: 90%),
  caption: [Software Installation GPO konfigurieren],
)
#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
#import table: cell, header

= AppArmor

== Theorie

=== TFTP

TFTP (Trivial File Transfer Protocol) ist ein einfaches Protokoll zum Übertragen von Dateien über ein Netzwerk. Es wird häufig in Umgebungen eingesetzt, in denen geringe Ressourcenanforderungen wichtig sind, wie beispielsweise beim Booten von Thin Clients oder Netzwerkgeräten. TFTP verwendet das UDP-Protokoll und bietet im Vergleich zu FTP weniger Funktionen, was es jedoch leichter und schneller macht.

tftp-hpa ist eine erweiterte Version des BSD TFTP-Clients und -Servers, entwickelt von H. Peter Anvin. Diese Implementierung enthält zahlreiche Fehlerbehebungen und Verbesserungen gegenüber dem Original und ist auf den meisten modernen Unix-Varianten lauffähig. Es ist wichtig zu beachten, dass tftp-hpa in der Vergangenheit Sicherheitslücken aufwies, wie beispielsweise einen Pufferüberlauf, der es Angreifern ermöglichte, beliebigen Code auszuführen. Diese Schwachstelle wurde jedoch behoben, und es wird empfohlen, stets die neueste Version zu verwenden, um Sicherheitsrisiken zu minimieren.

=== AppArmor

AppArmor (Application Armor) ist ein Sicherheitsmodul des Linux-Kernels, das es Systemadministratoren ermöglicht, die Fähigkeiten von Programmen durch spezifische Profile einzuschränken. Diese Profile können Berechtigungen wie Netzwerkzugriff, Zugriff auf Raw-Sockets sowie Lese-, Schreib- oder Ausführungsrechte für bestimmte Pfade definieren. AppArmor ergänzt das traditionelle Unix-Discretionary-Access-Control-Modell (DAC) durch die Bereitstellung von Mandatory Access Control (MAC). Seit der Kernel-Version 2.6.36 ist AppArmor teilweise im Hauptzweig des Linux-Kernels enthalten, und seine Entwicklung wird seit 2009 von Canonical unterstützt. 

Ein herausragendes Merkmal von AppArmor ist der Lernmodus, in dem Profilverletzungen protokolliert, aber nicht verhindert werden. Dies ermöglicht Administratoren, Profile basierend auf dem typischen Verhalten eines Programms zu erstellen, ohne den laufenden Betrieb zu beeinträchtigen. Befürworter von AppArmor betonen, dass es weniger komplex und für den durchschnittlichen Benutzer leichter zu erlernen ist als beispielsweise SELinux. Zudem erfordert AppArmor weniger Anpassungen an bestehenden Systemen, da es dateisystemunabhängig arbeitet und keine speziellen Anforderungen an das Dateisystem stellt. 

== Checkliste

=== TFTP

- [ ] tftpd-hpa und tftp-hpa installieren, starten und enablen
- [ ] Log-Datei konfigurieren
- [ ] Ordner für TFTP-Dateien erstellen und Berechtigungen setzen
- [ ] Firewall-Regeln für TFTP konfigurieren
- [ ] TFTP-Server testen mit tftp, get und put

=== AppArmor

- [ ] AppArmor(-utils) installieren und starten
- [ ] AppArmor-Profile für Programme erstellen und aktivieren
- [ ] Programme testen und Verletzungen überwachen
- [ ] Profile scannen und Berechtigungen anpassen
- [ ] Mit aa-unconfined überprüfen, dass Programm durch erstelltes Profil gesichert ist.
- [/] Falls nötig: Finetuning in /etc/apparmor.d/usr.sbin.in.tftpd am Profil durchführen.


== Befehlsreferenz

=== TFTP
#[
#set par(justify: false);
#set table(
  stroke: (x, y) => (
    if y == 0 {
      (bottom: 0.7pt + black)
    } else {
      (bottom: 0.2pt + gray)
    }
  ),
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#table(
  columns: (3fr, 2fr),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Command*],
    [*Erklärung*],
  ), 
  [```bash sudo apt install tftpd-hpa```],
  [tftp server installieren],

  [```bash sudo apt install tftp-hpa```],
  [tftp client installieren],

  [```bash sudo systemctl start tftpd-hpa```],
  [tftp server starten],

  [```bash sudo systemctl enable tftpd-hpa```],
  [tftp server automatisch beim hochfahren starten],

  [```bash sudo nano /etc/default/tftpd-hpa
  TFTP_USERNAME="tftp" 
  TFTP_DIRECTORY="/srv/tftp" 
  TFTP_ADDRESS="0.0.0.0:69" 
  TFTP_OPTIONS="--secure --create"
```],
  [Konfigurationsdatei des TFTP Servers -> Hier kann die Log-Datei hinzugefügt werden, falls nötig],

  [```bash cd /srv/tftp```],
  [Ordner in dem die Dateien liegen, die vom TFTP-Server bereitgestellt werden.],

  [```bash chown 777 /srv/tftp```],
  [Berechtigungen setzen],

  [```bash sudo nano test.txt```],
  [Testfile erstellen],

  [```bash tftp IP-ADRESSE```],
  [Auf den TFTP-Server zugreifen],

  [```bash help```],
  [in TFTP um die Optionen zu sehen],

  [```bash get test.txt```],
  [test.txt herunterladen],

  [```bash q```],
  [aus tftp herauskommen]
)
]

=== AppArmor
#[
#set par(justify: false);
#set table(
  stroke: (x, y) => (
    if y == 0 {
      (bottom: 0.7pt + black)
    } else {
      (bottom: 0.2pt + gray)
    }
  ),
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#table(
  columns: (3fr, 2fr),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Command*],
    [*Erklärung*],
  ), 
  [```bash sudo apt install apparmor apparmor-utils```],
  [apparmor installieren],

  [```bash apparmor_status```],
  [Zeigt aktuellen Status sowie jeweilige Betriebsart],

  [```bash aa-enforce```],
  [Wechselt bei einem Profil in den enforce-Modus (setzt das geladene Profil um)],

  [```bash aa-complain```],
  [Wechselt ein Profil in den complain-Modus, in dem er nur protokolliert],

  [```bash aa-teardown```],
  [Beendet und entlädt vollständig alle Profile],

  [```bash aa-status```],
  [Zeigt nochmals alle Profile usw an],

  [```bash aa-unconfined```],
  [Zeigt alle noch nicht durch AppArmor gesicherten Services an],

  [```bash sudo aa-genprof in.tftpd```],
  [Erstellt ein eigenes Profil für den TFTP-Server und aktiviert es nach Konfiguration],

  [```bash sudo aa-logprof in.tftpd```],
  [Aktualisiert das Profil anhand der im Syslog protokollierten Berechtigungsanfragen]
)
]
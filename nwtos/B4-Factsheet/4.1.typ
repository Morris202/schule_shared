#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
= 4.1 Mail Services

== Postfix
Postfix ist ein Mail Transfer Agent (MTA), der auf Unix-ähnlichen Betriebssystemen läuft. Er wird verwendet, um E-Mails zu empfangen, weiterzuleiten und zuzustellen. Postfix ist bekannt für seine hohe Leistung, Sicherheit und Flexibilität. Es ist eine beliebte Wahl für Server, die E-Mail-Dienste bereitstellen. Es unterstützt verschiedene Protokolle wie SMTP (Simple Mail Transfer Protocol) und kann mit anderen E-Mail-Servern kommunizieren. Postfix bietet auch Funktionen wie Spam-Filterung, Virenschutz und Unterstützung für virtuelle Domains. Es ist einfach zu konfigurieren und wird häufig in Kombination mit anderen E-Mail-Diensten wie Dovecot oder Cyrus IMAP verwendet.

== Dovecot 
Dovecot ist ein Open-Source-IMAP- und POP3-Server, der für Unix-ähnliche Betriebssysteme entwickelt wurde. Er wird häufig in Kombination mit Postfix verwendet, um E-Mail-Dienste bereitzustellen. Dovecot ermöglicht es Benutzern, ihre E-Mails über verschiedene Clients abzurufen und zu verwalten. Es unterstützt verschiedene Authentifizierungsmethoden und bietet Funktionen wie Maildir- und mbox-Speicherformate, SSL/TLS-Verschlüsselung und Unterstützung für virtuelle Benutzerkonten. Dovecot ist bekannt für seine hohe Leistung, Sicherheit und einfache Konfiguration.

== Thunderbird
Mozilla Thunderbird ist ein Open-Source-E-Mail-Client, der von der Mozilla Foundation entwickelt wurde. Er ist für verschiedene Betriebssysteme verfügbar und bietet eine benutzerfreundliche Oberfläche zum Verwalten von E-Mails. Thunderbird unterstützt mehrere E-Mail-Konten, IMAP und POP3-Protokolle, RSS-Feeds und bietet Funktionen wie Spam-Filterung, Kalenderintegration und Erweiterungen durch Add-ons. Es ist eine beliebte Wahl für Benutzer, die einen leistungsstarken und anpassbaren E-Mail-Client suchen.


== Checkliste

- [ ] Installation der erforderlichen Dienste
- [ ] Bearbeitung von Konfigurationsdateien *main.cf*
- [ ] Bearbeitung der Konfigurationsdateien *10-auth.conf*
- [ ] Bearbeitung der Konfigurationsdateien *10-mail.conf*
- [ ] Installation von Bind9
- [ ] Bearbeitung der Konfigurationsdateien *named.conf.local*
- [ ] Bearbeitung der Zonendatei *db.<\domain\>*
- [ ] Anlegen der User
- [ ] Installation von Thunderbird
- [ ] Konfiguration von Thunderbird
- [ ] Senden der Email


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
  [```bash sudo apt update && sudo apt install postfix dovecot-core dovecot imapd dovecot-pop3d opendkim opendkim-tools bind9
```],
  [Installation der erforderlichen Dienste],

  [```bash myhostname = mailserver.htl3rtestlab.com
mydomain = htl3rtestlab.com
myorigin = $mydomain
inet_interfaces = all
inet_protocols = ipv4
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
relayhost =
mynetworks = 127.0.0.0/8 [::1]/128 192.168.181.0/24
home_mailbox = maildir/
smtpd_banner = $myhostname ESMTP
local_transport = local
relay_domains =
smtpd_relay_restrictions = permit_mynetworks, reject
```],
  [Konfiguration der main.cf Datei],

  [```bash sudo systemctl restart postfix```],
  [Neustarten des Postfix Dienstes],

  [```bash auth_mechanisms = plain login
 disable_plaintext_auth = no
 ```],
  [Bearbeitung der Konfigurationsdateien *10-auth.conf*],

  [```bash  mail_location = maildir:~/maildir```],
  [Anpassung der Datei *10-mail.conf*],

  [```bash sudo systemctl restart dovecot```],
  [Neustarten des Dovecot Dienstes],

  [```bash sudo useradd <user>```],
  [Anlegen eines Users],

  [```bash sudo mkdir /home/<user>/maildir```],
  [Anlegen des Maildir Verzeichnisses],

  [```bash sudo chown -R <user>:<user> /home/<user>/maildir```],
  [Zuweisen der Rechte],

)
]
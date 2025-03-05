#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode

= Advanced Security Audit Policies

== Theorie

=== Was sind Advanced Security Audit Policies?

Die Advanced Security Audit Policies ermöglichen eine detaillierte Kontrolle über sicherheitsrelevante Ereignisse im Netzwerk. Sie erweitern die klassischen Audit Policies und bieten granulare Einstellungsmöglichkeiten zur Überwachung sicherheitskritischer Prozesse.

=== Vorteile

- Verbesserte Transparenz und Nachvollziehbarkeit von sicherheitsrelevanten Ereignissen
- Frühe Erkennung von Sicherheitsvorfällen
- Einhaltung von Compliance-Vorgaben
- Präzisere Kontrolle durch detaillierte Audit-Kategorien

== Checkliste

- [ ] Group Policy Management Console öffnen
- [ ] Neue Gruppenrichtlinie erstellen
- [ ] Zu folgendem Pfad navigieren:\
  Computer Configuration\\Windows Settings\\Security Settings\\Advanced Audit Policy Configuration\\System Audit Policies
- [ ] Beliebige Kategorien aktivieren, zum Beispiel:\
 Account Management -> Audit User Account Management\
 Logon/Logoff -> Audit Kerberos Authentication Service\
 Account Management -> Audit Security Group Management\
 DS Access -> Audit Directory Service Changes
- [ ] Gruppenrichtlinie mit OU verknüpfen
- [ ] Überprüfung durch Event Viewer (Windows Logs -> Security)
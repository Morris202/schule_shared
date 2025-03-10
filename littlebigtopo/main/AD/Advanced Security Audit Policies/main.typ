#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Advanced Security Audit Policies],
  subtitle: none,
  authors: ("Morris Tichy, Lukas Freudensprung",),
  fach: "NWTK",
  thema: "Little Big Topo",
  create-outline: true,
  enumerate: true,
)

= Advanced Security Audit Policies

Die Advanced Security Audit Policies ermöglichen eine detaillierte Kontrolle über sicherheitsrelevante Ereignisse im Netzwerk. Sie erweitern die klassischen Audit Policies und bieten granulare Einstellungsmöglichkeiten zur Überwachung sicherheitskritischer Prozesse.

== Nutzen/Vorteil

- Verbesserte Transparenz und Nachvollziehbarkeit von sicherheitsrelevanten Ereignissen
- Frühe Erkennung von Sicherheitsvorfällen
- Einhaltung von Compliance-Vorgaben
- Präzisere Kontrolle durch detaillierte Audit-Kategorien

== GPO Konfiguration

- Group Policy Management öffnen
- Eine neue GPO unter OU erstellen
- Zu folgendem Pfad navigieren\
  Computer Configuration\\Windows Settings\\Security Settings\\Advanced Audit Policy Configuration\\System Audit Policies
- Folgende Kategorien aktivieren:
 - Account Management -> Audit User Account Management
 - Logon/Logoff -> Audit Kerberos Authentication Service
 - Account Management -> Audit Security Group Management
 - DS Access -> Audit Directory Service Changes
- Apply und OK drücken

== Überprüfung

=== Event Viewer

- Windows Logs -> Security
- Filtern nach Event-IDs:
 - 4720 (Benutzerkonto erstellt)
 - 4740 (Konto gesperrt)
 - 4765 (Sicherheitsgruppen-Änderung)
 - 4766 (Fehlgeschlagene Kerberos-Anmeldung)
 - 5136 (Directory Service Änderungen)
- Dokumentiere relevante Einträge

=== PowerShell

Aktive Audit Policies anzeigen:
```bash
auditpol /get /category:*
```

Überprüfen, ob ein spezifisches Audit-Event aktiviert ist:
```bash
auditpol /get /subcategory:"User Account Management"
```

Ereignisse aus dem Event Log abrufen:
```bash
Get-WinEvent -LogName "Security" | Where-Object { $_.Id -eq 4720 }
```
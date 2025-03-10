#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

=== Credential Guard

Der Credential Guard verhindert Identitätsdiebstahl, durch das absichern und schützen von den 
- NTLM Passwort Hashes,
- dem Kerberos Ticket Granting Tickets (TGTs) und
- den gespeicherten Credentials von Applikationen als Domain Credentials.

==== Nutzen/Vorteil

- hardware security
- virtualization-based security
- protection against advanced persistant threats

==== Requirements

Folgende Einstellungen sind essenziell:
- Virtualization-based security (VBS)
- Secure Boot

#figure(
  image("figures/enable_VBS.png", width: 90%),
  caption: [Enable VBS],
)

#figure(
  image("figures/enable_Secure_Boot.png", width: 90%),
  caption: [Enable Secure Boot],
)

Folgende Einstellungen sind empfehlenswert:
- Trusted Platform Module (TPM)
- UEFI lock

==== Wichtig!

Credential Guard hat bei Domänen Controllern (DCs) ist nicht empfohlen zu aktivieren, da er keine erweiterte Security hinzufügt. Das aktivieren kann zu Problemen mit Applikationskompatibilität führen.

==== Default Enablement

Windows 11 (22H2) und Windows Server 2025 oder später sollten die Credential Guard bei folgenden Bedingungen standardmäßig aktiviert sein.

Windows 11 (22H2)
- entspricht den license requirements
- entspricht den hardware and software requirements
- Credential Guard ist nicht explizit deaktiviert

Windows Server 2025
- entspricht den license requirements
- entspricht den hardware and software requirements
- Credential Guard ist nicht explizit deaktiviert
- Mitglied einer Domäne
- Kein Domänen Controller

==== GPO Konfiguration

- Local Group Policy Editor öffnen (oder für meherer Geräte eine GPO erstellen)
- Pfad folgen
  Computer Configuration\\Administrative Templates\\System\\Device Gurad\\Turn on Virtualization Based Securtiy
- Enable und unter Credential Guard Configuration zwischen den Optionen
 - Enabled with UEFI lock
 - Enabled without lock
- In CMD gpupdate /force eingeben

#figure(
  image("figures/credential_guard_gpo.png", width: 90%),
  caption: [Credential Guard GPO],
)

==== Überprüfung

*System Information*\
- Start
- msinfo32.exe eingeben
- System Information auswählen
- System Summary auswählen
- überprüfen ob der Credential Guard neben der Virtualization-based Security Services Running angezeigt wird

*PowerShell*\
Folgenden Command in der PowerShell eingeben:
#sourcecode[```bash
(Get-CimInstance -ClassName "Win32_DeviceGuard" -Namespace "root\Microsoft\Windows\DeviceGuard").SecurityServicesRunning
```]
- 0: Credential Guard disabled
- 1: Credential Gurad enabled/running

#figure(
  image("figures/credential_guard_test.png", width: 100%),
  caption: [Credential Guard Überprüfung],
)

=== Protected Users Security Group

Die Global Group Protect Users wurde zum Schutz vor Diebstahl von Anmeldeinformationen entwickelt. Die Gruppe löst nicht konfigurierbaren Schutz auf Geräten und Hostcomputern aus, um zu verhindern, dass Anmeldeinformationen bei der Anmeldung von Gruppenmitgliedern zwischengespeichert werden.

==== Wichtig!

Niemals Konten für Dienst (zB. NT AUTHORITY\\SYSTEM, NT AUTHORITY\\NETWORK SERVICE) und Computer (Jeder Computer der Domäne beitritt zB. Kontoname PC-01\$) hinzufügen, da für diese Konten die Mitgliedschaft keinen lokalen Schutz bietet. Kennwort und Zertifikat sind immer auf dem Host verfügbar.\
Mitglieder von Gruppen mit hoher Berechtigung (Enterprise Admins & Domain Admins) nicht hinzufügen, bis man sicher ist das das Hinzufügen keine negativen Konsiquenzen hat.

==== Requirements

Hosts Betriebsystem:
- Windows 8.1 or later
- Windows Server 2012 R2 or later

Domain functional Level:
- Windows Server 2012 R2 or later

Mitglieder der Protected User Group müssen AES Authentifikation unterstützen

==== Device Protection für Protected Users
  
- Keine Speicherung von Klartext-Anmeldedaten bei Credential Delegation (CredSSP), Windows Digest, NTLMund Kerberos.
- Kerberos erzeugt keine DES- oder RC4-Schlüssel.
- Kein Offline-Login, da das System keinen zwischengespeicherten Verifier erstellt.
- Schutzmechanismen greifen erst nach der nächsten Anmeldung des Nutzers.

==== Domain Controller Protection für Protected Users

- Keine NTLM-Authentifizierung möglich.
- Kerberos erlaubt nur moderne Verschlüsselungen, keine DES oder RC4.
- Keine unbeschränkte oder beschränkte Delegation möglich.
- Kerberos-Tickets (TGTs) können nicht über vier Stunden hinaus verlängert werden.
- Ticket-Lebensdauer ist fest auf 600 Minuten gesetzt und kann nur durch Verlassen der Gruppe geändert werden.

==== Konfiguration

*Active Directory Users and Computers*\
- Zu folgendem Pfad wechseln:\
  Server Manager -> Tools -> Active Directory Users and Computers -> Folder Users
- den User auswählen und zu der Gruppe Protected Users hinzufügen

#figure(
  image("figures/protected_users_test.png", width: 80%),
  caption: [Protected Users Überprüfung],
)

*PowerShell*
folgenden Befehl in der PowerShell ausführen:
#sourcecode[```bash
Add-ADGroupMember -Identity "Protected Users" -Members "USERNAME"
```]
#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
= Credentials Protection

== Protected Users Group

=== Was ist die Protected Users Group?

Die Protected-Users-Group ist eine globale Sicherheistruppe für das AD, um sich vor Credential-Diebstahl schützen zu können. Die Gruppe triggered Schutzmaßnahmen welche nicht explizit konfiguriert wurden, damit Credential Caching verhindert werden kann.

*Vorraussetzungen*
 - Windows Client läuft auf Windows 8.1 oder später
 - Windows Server 2012 R2 oder später
 - Domain Functional Level muss Windows Server 2012 R2 oder später sein
 - Protected global security group memberships bregenzen Admins nur AES für Kerberos zu verwenden. Demnach müssen Mitglieder in der Lage sein sich mit AES authentifizieren zu können.
 
 User kann man entweder mittels UI Tools wie wie dem Admin center, Active Directory Users und Computers oder durch Powershell Commandos hinzufügen.

 Enterprise Admins und Domain Admins sollte man nicht in die PUG hinzufügen
 Service und Computer accounts ebenfalls nicht in die Protected Users Group hinzufügen. Es würde sich nicht auszahlen da Passwörter am lokalen host immer verfügbar sind.

 == Checkliste Protected Users Group
- [ ] Vorraussetzungen wie oben beschrieben erfüllt.
- [ ] Powershell öffnen
Folgenden Command ausführen:
```powershell
Get-ADGroup -Identity "Protected Users" | Add-ADGroupMember –Members "CN=Adam,CN=Users,DC=corp,DC=example,DC=com"
```
== Credetial Guard

=== Was ist der Credential Guard?

Der Credential Guard ist eine Sicherheitsfunktion in Windows 10 und Windows Server 2016, die dazu dient, Anmeldeinformationen zu schützen. Der Credential Guard verwendet Virtualisierungsbasierte Sicherheit, um Anmeldeinformationen zu schützen, indem sie in einem geschützten Bereich des Systems gespeichert werden.

*Vorraussetzungen für Win 11,22H2*
- Lizenzanforderungen entsprechen
- Hard und Softwareanforderungen entsprechen
- Credential Guard wurde nicht explizit deaktiviert

*Vorraussetzungen für Windows Server*
  - Die Lizensierunganforderungen ensprechen
  - Die Hard und Software Anforderungen entsprechen
  - Credential Guard wurde explizit nicht deaktiviert
  - Teil einer Domäne
  - Kein Domain Controller

  *Systemanforderungen*
    - VBS
    - Secure Boot

  *Optionale features wären:*
    - Trusted Platform Module (TPM)
    - UEFI lock

== Checkliste Credential Guard
- [ ] Vorraussetzungen wie oben beschrieben erfüllt.
- [ ] Secure Boot aktiviert
- [ ] Group Policy Management öffnen
- [ ] Neue Gruppenrichtlinie erstellen
- [ ] Zu folgendem Pfad navigieren: Computer Configuration -> Administrative Templates -> System -> Device Guard -> Turn on Virtualization Based Security
- [ ] Gruppenrichtlinie aktivieren
- [ ] gpupdate /force in der Powershell ausführen
- [ ] Überprüfung durch Systeminformationen




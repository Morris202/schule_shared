#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
= File Service Security

== AGDLP
AGDLP steht für:

*A (Accounts)*: Die Benutzerkonten.

*G (Global Groups)*: Diese beinhalten die Benutzerkonten und repräsentieren organisatorische Gruppen (z. B. Abteilungen).

*D (Domain Local Groups)*: Hier werden die Global Groups zusammengefasst und für Ressourcenberechtigungen genutzt.

*L/P (Permissions)*: Den Domain Local Groups werden dann die entsprechenden Berechtigungen auf Ressourcen zugewiesen.

Diese Vorgehensweise erleichtert das Management und die Delegation von Rechten in Active Directory, da sie eine klare Trennung zwischen Benutzergruppen und Ressourcenberechtigungen schafft.

== SMBv3

SMB (Server Message Block) ist ein Netzwerkprotokoll, das es ermöglicht, Dateien, Drucker und andere Ressourcen über ein Netzwerk freizugeben. Es sorgt dafür, dass Clients auf entfernte Ressourcen zugreifen können, als wären diese lokal verfügbar.

SMBv3, eingeführt mit Windows 8 und Windows Server 2012, erweitert dieses Protokoll um wesentliche Verbesserungen:

- Erhöhte Sicherheit: SMBv3 bietet Ende-zu-Ende-Verschlüsselung, die sicherstellt, dass Daten während der Übertragung vor unbefugtem Zugriff geschützt sind.

- Leistungsoptimierung: Mit Funktionen wie SMB-Multichannel können mehrere Netzwerkverbindungen gleichzeitig genutzt werden, was die Durchsatzrate und Ausfallsicherheit erhöht.

- Effizienz in virtualisierten Umgebungen: Verbesserte Mechanismen wie SMB Direct (unterstützt RDMA) sorgen für niedrige Latenz und geringen CPU-Overhead bei der Datenübertragung, was insbesondere in virtualisierten und cloudbasierten Systemen von Vorteil ist.

== Advanced Auditing

Advanced Auditing in Windows nutzt erweiterte Richtlinien (verfügbar ab Windows Vista/Server 2008), um gezielt festzulegen, welche sicherheitsrelevanten Ereignisse protokolliert werden – etwa Anmeldeversuche, Objektzugriffe oder Änderungen an Sicherheitsrichtlinien.

Das ermöglicht Administratoren:

- Präzisere Ereignisaufzeichnung: Sie können für einzelne Ereigniskategorien Erfolg, Fehler oder beides separat aktivieren.

- Verbesserte Sicherheitsüberwachung: Ungewöhnliche oder verdächtige Aktivitäten lassen sich leichter erkennen und analysieren, was bei der Fehlersuche und Compliance hilft.

- Reduzierung von unnötigen Logeinträgen: Nur die relevanten Ereignisse werden erfasst, was die Verwaltung und Auswertung der Protokolle erleichtert.

== Checkliste

- [ ] ADDS Domäne einrichten
- [ ] OU Struktur überlegen und Anlegen
- [ ] Benutzer anlegen
- [ ] Gruppen anlegen
- [ ] Benutzer zu Gruppen hinzufügen
- [ ] File Share anlegen und diesen freigeben
- [ ] Berechtigungen für den File Share  setzen
- [ ] SMBv3 aktivieren
- [ ] SMBv3 Verschlüsselung aktivieren
- [ ] GPO für Advanced Auditing anlegen
- [ ] GPO anwenden
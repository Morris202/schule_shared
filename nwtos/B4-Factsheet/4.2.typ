#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
= 4.2 DFS

 DFS ist ein verteiltes Dateisystem, welches es ermöglicht, Dateien auf mehreren Servern zu speichern und zu verwalten.

*DFS Namespace*:

Vereint verteilte Dateifreigaben in einer einheitlichen Ordnerstruktur, sodass Nutzer unter einem gemeinsamen Pfad auf alle Ressourcen zugreifen können.

*DFS-Replikation*:

Synchronisiert Dateien zwischen mehreren Servern automatisch, wodurch Ausfallsicherheit und Lastverteilung verbessert werden.

*Vorteile*:

- Hohe Verfügbarkeit: Daten bleiben auch bei Serverausfällen erreichbar.

- Lastverteilung: Zugriffe werden über mehrere Server verteilt.

- Zentrale Verwaltung: Einheitlicher Namespace vereinfacht die Administration.

*Nachteile*:

- Komplexität: Einrichtung und Verwaltung können anspruchsvoll sein.

- Replikationslatenz: Synchronisationsverzögerungen können auftreten.

- Netzwerkbelastung: Replikation erzeugt zusätzlichen Netzwerkverkehr.

== Checkliste

- [ ] ADDS Domäne einrichten
- [ ] Minimum zwei Server einrichten
- [ ] File Share am ersten Server anlegen und diesen freigeben
- [ ] DFS Namespace und Replikation Rolle installieren
- [ ] DFS Namespace anlegen
- [ ] File Share mit identer Ordnerstruktur anlegen und diesen freigeben (keine Berechtigungen setzen)
- [ ] DFS Namespace und Replikation Rolle installieren
- [ ] DFS Replikation konfigurieren
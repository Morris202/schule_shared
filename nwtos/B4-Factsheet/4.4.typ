#import "@preview/cheq:0.2.2": checklist
#show: checklist

= Remote Desktop Services

Remote Desktop Services (RDS) ist eine Microsoft-Technologie zur zentralisierten Bereitstellung von Desktops und Anwendungen. Benutzer greifen über eine Remotesitzung auf Ressourcen zu, wodurch Hardwareanforderungen auf der Client-Seite sinken und zentrale Verwaltung möglich wird.

== Komponenten

Remote Desktop Session Host (RDSH)
  - Führt Benutzer-Desktops oder Remote-Apps aus.
  - Benutzer verbinden sich per RDP mit dem RDSH.
  - Jeder Benutzer bekommt eine eigene Sitzung auf demselben Server.

Remote Desktop Connection Broker (RDCB)
  - Verteilt und verwaltet Sitzungen zwischen RDSH-Servern.
  - Unterstützt Lastverteilung und Sitzungswiederaufnahme (Session Reconnect).
  - Speichert Infos über aktive Sessions in einer SQL-Datenbank.

Remote Desktop Licensing (RDLS)
  - Lizenzierungsdienst für den RDS-Zugriff.
  - Erforderlich für den produktiven Einsatz.
  - Vergibt CALs (Client Access Licenses) an Benutzer oder Geräte.

Remote Desktop Gateway (RDGW)
  - Bietet sicheren HTTPS-Zugriff von außen.
  - Ermöglicht RDP-Zugriff über das Internet (statt direkt über Port 3389).
  - Nutzt TLS und Policies für Zugriffskontrolle.

Remote Desktop Web Access (RDWeb)
  - Webinterface zur Bereitstellung von RemoteApps oder Desktops.
  - Benutzer melden sich per Browser an und sehen nur ihre Anwendungen.

== Checkliste

=== session-based RDS

- [ ] Remote Desktop Service Feature installieren
- [ ] alle RDS Server im Installationsprozess auswählen
- [ ] RD Licensing Server hinzufügen
- [ ] RD Licensing Server konfigurieren
- [ ] RDS-Gateway konfigurieren
- [ ] Zertifikat-Template für RD Gateway & Connection Broker erstellen (auf CA)
- [ ] Zertifikate für RD Gateway & Connection Broker konfigurieren (auf RDCB-LS)
- [ ] SSL-Zertifikat für WebAccess konfigurieren
- [ ] RD Licensing konfigurieren
- [ ] WebAccess HTTP redirect erstellen

=== Session Collections

- [ ] RDS Users & Groups erstellen
- [ ] DFS Share für User Profiles erstellen (auf FileServer)
- [ ] Session Collection erstellen (auf RDCB-LS)
- [ ] Session Collection konfigurieren
- [ ] Adresse des RD Gateway aufrufen und mit Credentials anmelden
- [ ] File herunterladen
- [ ] RDP Session starten

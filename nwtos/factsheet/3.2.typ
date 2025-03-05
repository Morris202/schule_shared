#import "@preview/cheq:0.2.2": checklist
#show: checklist
#import "@preview/codelst:2.0.2": sourcecode
= Windows Security Baseline
== Was ist die Windows Security Baseline?

Eine Security Baseline ist eine Gruppe von von Microsoft empfohlenen Konfigurationseinstellungen, die deren Auswirkungen auf die Sicherheit erläutern. Diese Einstellungen basieren auf Feedback von Microsoft Security-Entwicklungsteams, -Produktgruppen, -Partnern und -Kunden.

*Policy Analyzer*

Der PolicyAnalyzer ist ein Microsoft-Tool, das Administratoren hilft, Gruppenrichtlinien objektiv zu analysieren und zu vergleichen. Es wird oft in Verbindung mit den Windows Security Baselines genutzt, um Sicherheitsrichtlinien zu überprüfen und sicherzustellen, dass sie den empfohlenen Best Practices entsprechen. PolicyAnalyzer kann verschiedene GPOs (Group Policy Objects) auswerten, Abweichungen zwischen ihnen aufzeigen und mit den vordefinierten Compliance-Vorgaben der Security Baselines abgleichen. Dies erleichtert es Unternehmen, ihre Systeme auf Sicherheitslücken zu prüfen, Richtlinien zentral zu verwalten und sicherzustellen, dass alle Geräte den vorgeschriebenen Sicherheitsstandards entsprechen.

== Checkliste Windows Security Baseline
- [ ] Windows Security Compliance Toolkit heruntergeladen
- [ ] Policy Analyzer ausgeführt
- [ ] Baseline im Policy Anazyler hinzugefügt
- [ ] Security Baseline per GPOs bereitstellen
- [ ] Group Policy Management öffnen
- [ ] Neue Gruppenrichtlinie erstellen
- [ ] Pfad auf dem die Baseline liegt impotieren
- [ ] GPO-Status aktivieren
- [ ] Auf gewünschtes OU anbinden
#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

=== Windows Security Baseline

==== Was ist eine Security Baseline?

Eine Security Baseline ist eine Gruppe von von Microsoft empfohlenen Konfigurationseinstellungen, die deren Auswirkungen auf die Sicherheit erläutern. Diese Einstellungen basieren auf Feedback von Microsoft Security-Entwicklungsteams, -Produktgruppen, -Partnern und -Kunden.

==== Warum werden Security Baselines benötigt?

- Standardisierte Sicherheitskonfigurationen für alle Systeme
- Reduzierung von Sicherheitsrisiken
- Einhaltung von Compliance-Vorgaben und Sicherheitsstandards
- Minimierung von Fehlkonfigurationen
- Erleichterte Verwaltung und Automatisierung der Sicherheitsrichtlinien
- Bessere Nachvollziehbarkeit von Änderungen und Sicherheitsmaßnahmen
- Effiziente Reaktion auf Bedrohungen durch vordefinierte Sicherheitsmaßnahmen

==== Policy Analyzer

Der PolicyAnalyzer ist ein Microsoft-Tool, das Administratoren hilft, Gruppenrichtlinien objektiv zu analysieren und zu vergleichen. Es wird oft in Verbindung mit den Windows Security Baselines genutzt, um Sicherheitsrichtlinien zu überprüfen und sicherzustellen, dass sie den empfohlenen Best Practices entsprechen. PolicyAnalyzer kann verschiedene GPOs (Group Policy Objects) auswerten, Abweichungen zwischen ihnen aufzeigen und mit den vordefinierten Compliance-Vorgaben der Security Baselines abgleichen. Dies erleichtert es Unternehmen, ihre Systeme auf Sicherheitslücken zu prüfen, Richtlinien zentral zu verwalten und sicherzustellen, dass alle Geräte den vorgeschriebenen Sicherheitsstandards entsprechen.

==== Konfiguration

*Download*\
Auf folgender Website können die verschiedenen Baselines heruntergeladen werden:
https://www.microsoft.com/en-us/download/details.aspx?id=55319&msockid=06c952b1aa3966680c3847e3ab9067f8

In meinem Fall habe ich die Windows Server 2022 Security Baseline und den Policy Analyzer installiert.

#figure(
  image("figures/windows_security_baseline_download.png", width: 90%),
  caption: [Windows Security Baseline Download],
)

*Policy Analyzer*\
Der Policy Analyzer kann durch die .exe ausgeführt werden und unter dem Punkt Add kann die Windows Security Baseline importiert werden.

#figure(
  image("figures/windows_security_baseline_policy_analyzer_starten.png", width: 90%),
  caption: [Policy Analyzer starten],
)

#figure(
  image("figures/windows_security_baseline_policy_analyzer_import.png", width: 90%),
  caption: [Policy Analyzer Baseline importieren],
)

Unter dem Punkt Compare to Effective State können die GPOs der Baseline mit den aktuellen Sicherheitskonfigurationen verglichen werden.

#figure(
  image("figures/windows_security_baseline_policy_analyzer_compare.png", width: 90%),
  caption: [Baseline mit Effective State vergleichen],
)

Die gelb makierten Felder zeigen schlussendlich die Unterschiede an.

#figure(
  image("figures/windows_security_baseline_policy_analyzer_compare_erg.png", width: 80%),
  caption: [Baseline mit Effective State vergleichen],
)

*Security Baseline für DCs per GPO bereitstellen*\
Zuerst müssen die Templates, die im Ordner der Windows Security Baseline gefunden werden können, in die PolicyDefinitons der Domäne kopiert werden.

#figure(
  image("figures/windows_security_baseline_templates.png", width: 80%),
  caption: [Windows Security Baseline Templates kopieren],
)

Im Server Manager unter Tools kann dann die Group Policy Management Console geöffnet werden und eine neue GPO unter dem Ordner Group Policy Obejcts erstellt werden. Der Name sollte sinnvoll gewählt werden.

In diese GPO kann dann die Windows Security Basline für DCs implementiert werden.
Rechts Klick -> Import Settings - Pfad auswählen -> Windows Server 2022 - Domain Controller
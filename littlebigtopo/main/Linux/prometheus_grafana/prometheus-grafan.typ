#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
== Prometheus/Grafana
=== Theorie
==== Was ist Prometheus?
Prometheus ist ein Open-Source-Überwachungstool, das auf Metriken basiert und speziell für die Überwachung von Anwendungen und Infrastruktur entwickelt wurde. Es ermöglicht die Erfassung und Analyse von Leistungsdaten wie CPU-Auslastung, Speichernutzung und Netzwerkauslastung, was dabei hilft, die Effizienz und Stabilität von IT-Systemen zu gewährleisten. 
Durch seine flexible Architektur und die Möglichkeit der Integration in verschie-dene Systeme ist Prometheus ein wertvolles Werkzeug für Entwickler und IT-Administratoren, um die Gesundheit ihrer Systeme zu überwachen und Probleme frühzeitig zu erkennen.

==== Was ist Grafana?
Grafana ist ein Open-Source-Tool, das speziell dafür entwickelt wurde, Daten aus Prometheus grafisch darzustellen. Es ermöglicht die Erstellung detaillierter Dash-boards, die in Echtzeit Einblicke in die Leistung von Systemen wie CPU-Auslastung und Speichernutzung bieten. Mit Grafana können Benutzer Alarme einrichten, um schnell auf ungewöhnliche Aktivitäten reagieren zu können. Es ist das perfekte grafische Tool zur Ergänzung von Prometheus und ein unverzichtbares Werkzeug für IT-Administratoren und Entwickler, die ihre Systemüberwachung optimieren möchten.

==== Komponenten
*Prometheus Server*
speichert und wertet Metriken ab, indem er ein Pull-Modell verwendet und Metriken von den zu überwachenden Zielen über das HTTP-basierte Exporter-Protokoll abruft.

*Exporter*
Metriken die von den überwachten Zielen gesammelt und über HTTP-Endpunkte bereitgestellt werden, dabei wird das Exporter-Protokoll verwendet

*Targets*
überwachenden Ziele, von denen Prometheus Metriken sammelt, indem es deren HTTP-Endpunkte abfragt

*Grafana*
Visualisierung von Metriken in Dashboards

*Alertmanager (optional)
*Benachrichtigen von Benutzern oder Systemen

==== Überwachungs- und Fehlermanagement
*Alerting:* Wenn ein Fehler auftritt, wird eine Benachrichtigung (Alert) gesendet, um jemanden zu alarmieren.

*Debugging:* Sobald jemand benachrichtigt wurde, muss der Fehler gefunden und behoben werden.

*Trending:* Langzeitüberwachung zur Ressourcenplanung, um die Nutzung und Bedürfnisse besser zu verstehen.

*Plumbing:* Überwachungssysteme fungieren als Datenverarbeitungspipelines und können manchmal für andere Zwecke genutzt werden, anstatt separate maßgeschneiderte Lösungen zu entwickeln.

==== Wie werden Daten ausgewertet?
Profiling: sammelt begrenzte Kontextinformationen für eine begrenzte Zeit und wird für taktisches Debugging verwendet, erfordert jedoch oft eine Verringerung des Datenvolumens, um in andere Überwachungskategorien zu passen.
Tracing: selektiert einen Prozentsatz von Ereignissen, um Einblicke in Codepfade und Latenzzeiten zu erhalten, mit der Möglichkeit zur verteilten Nachverfolgung in Mikroservice-Architekturen.
Logging: zeichnet begrenzte Kontextinformationen für eine bestimmte Anzahl von Ereignissen auf und wird in Kategorien wie Transaktionsprotokollen, Anforder-ungsprotokollen, Anwendungsprotokollen und Debug-Protokollen unterteilt.
Metrics: erfassen aggregierte Daten über verschiedene Ereignisse im Laufe der Zeit und bieten Einblicke in die Leistung und das Verhalten eines Systems, wobei die Kontextinformationen begrenzt sind, um das Datenvolumen und die Verarbei-tungsanforderungen zu optimieren.

=== Installation

==== Grundkonfiguration Prometheus Server
Die folgenden Konfigurationen wurden auf dem Ubuntu Server bzw. auf dem Pro-metheus eingefügt.

#sourcecode[```bash  
hostnamectl hostname Prometheus

sudo nano /etc/netplan/00-installer-config.yaml
network:
  version: 2
  renderer: networkd
    ethernets:
      LAN1:
        addresses:
          - 192.168.10.100/24
        routes:
          - to: default
            via: 192.168.10.1
        match:
          macaddress: 00:0c:29:46:22:de
        set-name: LAN1
 
sudo netplan apply
```]
Mit dieser Konfiguration werden die Netzwerk Einstellungen festlegt. 

==== Installation Prometheus 
Anschließend wird auf dem Prometheusserver die verschiedenen Dienste für Prometheus installiert.

#sourcecode[```bash  
wget https://github.com/prometheus/prometheus/releases/download/v2.51.1/prometheus-2.51.1.linux-amd64.tar.gz # Installieren von Prometheus

tar xzf prometheus-2.51.1.linux-amd64.tar.gz # entpacken der Datei 

mv prometheus-2.51.1.linux-amd64 /etc/prometheus # verschieben der Datei in den Ordner /etc/prometheus

nano /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
ExecStart=/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml
Restart=always
[Install]
WantedBy=multi-user.target
```]

Hier wird der Prometheus Server installiert und die Konfiguration wird in der Datei /etc/prometheus/prometheus.yml festgelegt. Anschließend wird ein Service erstellt, der den Prometheus Server startet. 

Mit den Befehlen:

#sourcecode[```bash
systemctl daemon-reload
systemctl restart prometheus
systemctl enable prometheus
systemctl status prometheus
```]
werden die *Services* neugestartet.

#sourcecode[```bash
/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml # Starte den Prometheus Server mit einer bestimmten Konfigurationsdatei
```]

Anschließend kann in der Konfigurationsdatei Jobs angelegt werden auf denen der Node Explorer installiert worden ist.

#sourcecode[```bash
nano /etc/prometheus/prometheus.yml # A scrape configuration containing exactly one endpoint to scrape from node_exporter running on a host:
scrape_configs: # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
- job_name: 'node'
  # metrics_path defaults to '/metrics'
  # scheme defaults to 'http'.
  static_configs:
  - targets: ['localhost:9100']
systemctl restart prometheus
systemctl status prometheus
```]
===== Überprüfen des Web-Zugriffs
Danach sollte unter der <IP-Adresse>:9090 der Prometheus Server erreichbar sein. 
#figure(
  image("webacc.png", width: 70%),
  caption: [Prometheus Web Access]
)

==== Installation Grafana

#sourcecode[```bash
sudo apt-get install -y adduser libfontcon-fig1 musl # Installation von Installationn der Abhängigkeiten für Grafana
wget  https://dl.grafana.com/enterprise/release/grafana-enterprise_10.4.1_amd64.deb # installation von Grafana

sudo apt install musl # Installation von musl

sudo dpkg -i grafana-enterprise_10.4.1_amd64.deb # Entpacken der Datei
```]

Durch folgende Befehle wird der Grafana Server gestartet und aktiviert. 


#sourcecode[```bash
sudo systemctl restart grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
```]

===== Überprüfung des Web-Zugriffs
Danach sollte unter der <\IP-Adresse>:3000 der Grafana Server erreichbar sein. Die Anmeldedaten für den Web-Zugriffs sind User: „admin“, Passwort: „admin“. Nach Eingabe von Benutzername und Passwort wird man aufgefordert ein neues Passwort festzulegen. 

==== Node Explorer Ubuntu
Damit wir Server auf dem Dashboard anzeigen lassen können, müssen wir auf den Geräten den Node_exporter einrichten. Folgenden Befehle werden dafür ver-wendet.

#sourcecode[```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz # Download von Node_exporter

tar xzf node_exporter-1.7.0.linux-amd64.tar.gz # Entpackung der Datei
mv node_exporter-1.7.0.linux-amd64 /etc/node_exporter # # Verschieben der Datei in den Ordner /etc/node_exporter

nano /etc/systemd/system/node_exporter.service # Erstellen der Service Datei
  [Unit]
  Description=Node Exporter
  Wants=network-online.target
  After=network-online.target
  [Service]
  ExecStart=/etc/node_exporter/node_exporter
  Restart=always
  [Install]
  WantedBy=multi-user.target
```]

Durch folgende Befehle wird der Node Exporter gestartet und aktiviert. 


#sourcecode[```bash
systemctl daemon-reload
systemctl restart node_exporter
systemctl enable node_exporter
systemctl status node_exporter
```]

==== Node Explorer Windows 
Damit wir Server auf dem Dashboard anzeigen lassen können, müssen wir auf den Geräten den Node_exporter einrichten. Folgenden Befehle werden dafür ver-wendet.

#sourcecode[```bash
https://github.com/prometheus-community/windows_exporter/releases
-> .msi installieren # Download von Node_exporter

msiexec /i C:\\Users\\Administrator\\Downloads\\windows_exporter-0.25.1-arm64.msi ENABLED_COLLECTORS="ad,cpu"
```]

Bei Windows ist es wichtig zu beachten, dass der Standardport für den Node-Exporter 9182 ist.


=== Dashboard einrichten
Damit die Metriken von den Maschinen in numerische Werte umgewandelt werden, muss ein neues Dashboard angelegt werden. Dazu wird unter *Dashboard > New > Import* kann ein benutzerdefiniertes Dashboard oder ein vorgefertigtes Dash-board importierte werden. Mit der Dashboard ID: 1860 sieht das Dashboard wie folgt aus:
#figure(
  image("dashboard.png", width: 70%),
  caption: [Linux/Ubuntu Dashboard]
)
Unter dem Reiter Jobs können die verschiedenen Geräte ausgewählt werden, die davor in der prometheus.yml Datei angelegt wurden.  Nach der Konfiguartion des Dashboards kann man Alerts festlegen, die in unserem Fall die CPU-Auslastung überwacht. 

=== Alerts
In Grafana gibt es verschiedene Zustände für Alarmregeln und deren Instanzen, die den aktuellen Status eines Alarms widerspiegeln:

==== Zustände von Alarminstanzen:

*Normal:* Der Zustand eines Alarms, wenn die definierte Bedingung (Schwellenwert) nicht erfüllt ist.

*Pending:* Der Alarm hat den Schwellenwert überschritten, jedoch für weniger als die definierte Wartezeit.

*Alerting:* Der Alarm hat den Schwellenwert für länger als die definierte Wartezeit überschritten und wird als aktiv betrachtet.

*No Data:* Der Alarm erhält keine Daten oder alle Werte sind null.

*Error:* Bei der Auswertung der Alarmregel ist ein Fehler oder ein Timeout aufgetreten.

 ==== Zustände von Alarmregeln:

*Normal:* Keine der Alarminstanzen befindet sich im Zustand "Pending" oder "Alerting".

*Pending:* Mindestens eine Alarminstanz befindet sich im Zustand "Pending".

*Firing:* Mindestens eine Alarminstanz befindet sich im Zustand "Alerting".

In unserem Fall konfigurieren wir einen Alert für die CPU-Auslastung. Falls die Auslastung über 0.3 wird, ein Alert erstellt und dieser an den Alert Manager weitergeschickt. Die Konfiguration dieses Alerts beschreibt die nachfolgenden Screenshots. 

#figure(
  image("rulename.png", width: 70%),
  caption: [Regel Namen festlegen]
)


#figure(
  image("regel.png", width: 70%),
  caption: [Regel definieren]
)
In dieser Abbildung ist zu erkennen, dass die CPU Auslastung ausgewertet wird. Falls die Auslastung über 0.3 liegt, wird ein Alert erstellt. 

#figure(
  image("evobeh.png", width: 70%),
  caption: [Ordner festlegen]
)

#figure(
  image("link.png", width: 70%),
  caption: [Dashboard und Link festlegen]
)

Nachdem die Regel konfiguriert kann anschließend noch ein Alert Manager eingebunden werden.  Der Alert Manager ist ein System, das es ermöglicht, Benachrichtigungen über Alerts zu senden. 

=== Alert Manager 
Der Alert Manager wurde lokal auf der Prometheus Maschine installiert. Die Konfiguration des Alert Managers wird in der Datei prometheus.yml beschrieben. 
#sourcecode[```bash
wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz # Download von Alert Manager
tar -xvf alertmanager-0.23.0.linux-amd64.tar.gz # Entpacken

sudo mkdir -p /alertmanager-data /etc/alertmanager

sudo mv alertmanager-0.23.0.linux-amd64/alertmanager /usr/local/bin/ # Verschieben der Datei
sudo mv alertmanager-0.23.0.linux-amd64/alertmanager.yml /etc/alertmanager/ # Verschieben der Datei
```
*Service erstellen*
```bash
sudo nano /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target
[Service]
ExecStart=/usr/local/bin/alertmanager --storage.path=/alertmanager-data --config.file=/etc/alertmanager/alertmanager.ymlRestart=always
[Install]
WantedBy=multi-user.target
```]

Durch folgende Befehle wird der Alert Manager gestartet und aktiviert. 

#sourcecode[```bash
sudo systemctl enable alertmanager.service
sudo systemctl start alertmanager.service
sudo systemctl status alertmanager.service
```]


*AlertManager in Prometheus integrieren*
#sourcecode[```bash
sudo nano /etc/prometheus/prometheus.yml
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           - alertmanager:9093
```]

Abschließend muss das Prometheus Service neu gestartet werden.
#sourcecode[```bash 
sudo systemctl restart prometheus.service
```]

=== Testen 
Wenn man jetzt den NTP-Server neustartet geht die CPU Auslastung hoch und wir bekommen zweimal einen Alert. In Grafana steht Firing, dass beschreibt das sich eine Alarminstanz in Alerting befindent. In Grafana ist diese Nachricht bei den Alerts zu sehen. 

#figure(
  image("alertfireing.png", width: 100%),
  caption: [Alert ist im Zustand Firing]
)

Unter der <\IP-Adresse>:9093 könnnen wir sehen, dass es einen neuen Alert gibt unter der Instanz 192.168.100.2. Der nachfolgende Screenshot zeigt diesen Alert.

#figure(
  image("Alertmanager.png", width: 70%),
  caption: [Alertmanager Alert]
)
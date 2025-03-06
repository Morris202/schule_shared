#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Prometheus Grafana],
  subtitle: none,
  authors: ("Morris Tichy","Lukas Freudensprung",),
  fach: "Little Big Topo",
  thema: "Prometheus & Grafana",
  create-outline: true,
  enumerate: true
)

= Theorie 
ein open source, Metrik basiertes Überwachungstool für Applikationen und Infrastruktur
zB. CPU-Auslastung, Speichernutzung, Netzwerkauslastung, ADDS

== Komponenten
- Prometheus Server
	 speichert und wertet Metriken ab, indem er ein Pull-Modell verwendet und Metriken von den zu überwachenden Zielen über das HTTP-basierte Exporter-Protokoll abruft.
- Exporter
	 Metriken die von den überwachten Zielen gesammelt und über HTTP-Endpunkte bereitgestellt werden, dabei wird das Exporter-Protokoll verwendet
- Targets
	 überwachenden Ziele, von denen Prometheus Metriken sammelt, indem es deren HTTP-Endpunkte abfragt
- Grafana (optional)
	 Visualisierung von Metriken in Dashboards
- Alertmanager (optional)
 Benachrichtigen von Benutzern oder Systemen

== Wie werden Daten ausgewertet?
*Profiling*
sammelt begrenzte Kontextinformationen für eine begrenzte Zeit und wird für taktisches Debugging verwendet, erfordert jedoch oft eine Verringerung des Datenvolumens, um in andere Überwachungskategorien zu passen.

*Tracing*
selektiert einen Prozentsatz von Ereignissen, um Einblicke in Codepfade und Latenzzeiten zu erhalten, mit der Möglichkeit zur verteilten Nachverfolgung in Mikroservice-Architekturen.

*Logging*
zeichnet begrenzte Kontextinformationen für eine bestimmte Anzahl von Ereignissen auf und wird in Kategorien wie Transaktionsprotokollen, Anforderungsprotokollen, Anwendungsprotokollen und Debug-Protokollen unterteilt.

*Metrics*
erfassen aggregierte Daten über verschiedene Ereignisse im Laufe der Zeit und bieten Einblicke in die Leistung und das Verhalten eines Systems, wobei die Kontextinformationen begrenzt sind, um das Datenvolumen und die Verarbeitungsanforderungen zu optimieren.

= Installation
== Prometheus Server
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.51.1/prometheus-2.51.1.linux-amd64.tar.gz
tar xzf prometheus-2.51.1.linux-amd64.tar.gz
mv prometheus-2.51.1.linux-amd64 /etc/prometheus

Erstellen eines Service (optional):
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

systemctl daemon-reload
systemctl restart prometheus
systemctl enable prometheus
systemctl status prometheus

etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml
```
Nach dieser Installation ist der  Prometheus Server auf dem Port 9090 erreichbar.

== Grafana
```bash
sudo apt-get install -y adduser libfontconfig1 musl
wget  https://dl.grafana.com/enterprise/release/grafana-enterprise_10.4.1_amd64.deb
Sudo apt install musl
sudo dpkg -i grafana-enterprise_10.4.1_amd64.deb

sudo systemctl restart grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
```
Nach dieser Installation ist Grafana auf dem Port 3000 erreichbar.

=== Node Exporter Linux
Der Node Exporter wird auf den Systemen installiert die überwacht werden sollen. In unserem Fall ist dies auf dem NTP und Linux Client. 

```bash 
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xzf node_exporter-1.7.0.linux-amd64.tar.gz
mv node_exporter-1.7.0.linux-amd64 /etc/node_exporter

Erstellen eines Service (optional):
nano /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
ExecStart=/etc/node_exporter/node_exporter
Restart=always
[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl restart node_exporter
systemctl enable node_exporter
systemctl status node_exporter

/etc/node_exporter/node_exporter
```

=== Node Exporter Windows
Auf auf einem Windows System kann der Node Exporter installiert werden.

```powershell 
https://github.com/prometheus-community/windows_exporter/releases
-> .msi installieren

msiexec /i C:\Users\Administrator\Downloads\windows_exporter-0.25.1-arm64.msi ENABLED_COLLECTORS="ad,cpu"

Prometheus konfigurieren:
nano /etc/prometheus/prometheus.yml

# A scrape configuration containing exactly one endpoint to scrape from node_exporter running on a host:
scrape_configs:
# The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
- job_name: 'node'

  # metrics_path defaults to '/metrics'
  # scheme defaults to 'http'.
  static_configs:
  - targets: ['localhost:9100']

systemctl restart prometheus
systemctl status prometheus
```

= Grafana & Prometheus Konfiguration
In der Grafana Web (GUI) muss der Prometheus Server hinzugefügt werden. Dazu wird in der GUI auf *Home -> Connections -> Prometheus -> Add new data source* gegangen und die IP des Prometheus Servers eingetragen.

#figure(
  image("addprom.png", width: 70%),
  caption: [hinzugefügt des Prometheus Servers]
)

Anschließend kann nun ein neues Dashboard erstellt werden und die gewünschten Metriken hinzugefügt werden. Wir verwenden hierfür das Dashboard *1860*. Nachdem das Dashboard erstellt wurde, sieht man folgende Ausgabe.

#figure(
  image("ntpserv.png", width: 90%),
  caption: [Dashboard von NTP-Server]
)

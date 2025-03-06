#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [HA-Cluster FortiGate],
  subtitle: none,
  authors: ("Morris Tichy", "Lukas Freudensprung"),
  fach: "Little Big Topo",
  thema: "HA-Cluster",
  create-outline: true,
  enumerate: true
)

= Theorie
== Was ist ein HA-Cluster?
Ein HA-Cluster (High Availability Cluster) ist ein System, das aus zwei oder mehr Rechnern besteht, die zusammenarbeiten, um eine hohe Verfügbarkeit von Diensten zu gewährleisten. Ein HA-Cluster kann so konfiguriert werden, dass er automatisch auf einen anderen Rechner umschaltet, wenn einer der Rechner ausfällt. Dies wird als Failover bezeichnet. Ein HA-Cluster kann auch so konfiguriert werden, dass er Lasten zwischen den Rechnern verteilt, um die Leistung zu verbessern. Dies wird als Load Balancing bezeichnet.

Es gibt bei der FortiGate zwei verschiedene Arten von HA-Clustern:
- Active-Passive: Hier ist nur ein Gerät aktiv und das andere Gerät ist im Standby-Modus. (failover)
- Active-Active: Hier sind beide Geräte aktiv und teilen sich die Last. (load-balancing)

= Konfiguration eines HA-Clusters
Die beiden FortiGate sind mithilfe eines Kabels verbunden. Man nennt dieses das Heartbeat-Interface, darüber läuft der Traffic zwischen den beiden Geräten.

```bash
# Auf FG1
  config system ha
      set mode a-a
      set group-name HA_Cluster
      set password admin
      set hbdev port4 50
  end
```

```bash
# Auf FG2
  config system ha
      set mode a-a
      set group-name HA_Cluster
      set password admin
      set hbdev port4 60
  end
```
Es kann vorkommen, dass nach der Konfiguration die zwei Nodes nicht synchronized sind. Daher muss folgender Befehl ausgeführt werden.
```bash
execute ha synchronize all
```

Falls, alles richtig funktioniert sehen wir in der GUI folgendes. 
#figure(
  image("hacluster.png", width: 70%),
  caption: [Synchronisation von den Cluster-Nodes]
)



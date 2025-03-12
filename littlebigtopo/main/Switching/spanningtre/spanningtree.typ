#import "@preview/codelst:2.0.2": sourcecode
== Spanningtree
SpanningTree wird verwendet, um Schleifen in einem Netzwerk zu verhindern. Es wird auf Layer 2 Switches eingesetzt und berechnet den besten Pfad zu einem Ziel. Dabei werden redundante Verbindungen deaktiviert, um Schleifen zu vermeiden. SpanningTree ist ein Protokoll, das auf dem IEEE 802.1D-Standard basiert und in verschiedenen Varianten wie STP, RSTP und MSTP verfügbar ist.

=== RSTP aktivieren
#sourcecode[```bash
# RSTP aktivieren 
spanning-tree mode rapid-pvst
# Eindeutige Bridge ID durch die erweiterte System ID gewährleisten
spanning-tree extend system-id

spanning-tree vlan 10 root primary
spanning-tree vlan 30 root secondary
```]

=== Root Guard 
#sourcecode[```bash
# Verhindert unbeabsichtigte Root Bridge-Übernahmen
interface GigabitEthernet0/1
 spanning-tree guard root
```]
=== Loop Guard
#sourcecode[```bash
# Erkennt unidirektionale Link-Fehler
interface GigabitEthernet0/1
 spanning-tree guard loop
```]

=== BPDU Guard
#sourcecode[```bash
# Verhindert unerwünschte Spanning Tree Topologie-Änderungen
spanning-tree portfast bpduguard default
interface GigabitEthernet0/1
 spanning-tree bpduguard enable
 spanning-tree portfast edge
```]

#figure(
  image("guards.png", width: 80%),
  caption: [Anzeige der Aktivierten Guards],
)
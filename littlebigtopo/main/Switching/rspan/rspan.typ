#import "@preview/codelst:2.0.2": sourcecode
== RSPAN
RSPAN wird verwendet um den gesamten Traffic eines VLANs auf einem Switch zu spiegeln und an einen anderen Switch zu senden. Dies ermöglicht es, den Traffic mit einem Sniffer zu analysieren, ohne den normalen Betrieb des Netzwerks zu beeinträchtigen. 

=== Konfiguration
In unserem Fall wurde bei der Hawkeye Farm ein RSPAN eingerichtet, um den Traffic auf HWF-CLI2 zu spiegeln. Dazu werden die Switches SW-HWF3 und SW-HWF4 verwendet. 

*SW3:*
#sourcecode[```bash
vlan 100
remote-span
exit

monitor session 1 source interface gi 0/0
monitor session 1 destination remote vlan 100
```]
*SW4:*
#sourcecode[```bash
vlan 100
remote-span
exit

monitor session 1 source remote vlan 100
monitor session 1 destination interface gi 0/0
```]
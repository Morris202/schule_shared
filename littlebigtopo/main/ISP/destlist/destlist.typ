#import "@preview/codelst:2.0.2": sourcecode
== Distribution List 
Wir verwenden die Distribution List aus folgendem Grund. Wir sagen, das der ISP Bifröst schneller ist als der ISP SHIELD und deshalb lernen wir die Route von 209.123.1.0/24 über den ISP Bifröst. 

=== Konfiguration
#sourcecode[```bash
ip access-list standard Set_NoTransit
deny ip 209.123.1.0 0.0.0.255
permit any

router bgp 1
address-family ipv4
neighbor 209.123.3.2 distribute-list Set_NoTransit out
```]

Danach sollte die Route nur mehr von AS2 gelernt werden.
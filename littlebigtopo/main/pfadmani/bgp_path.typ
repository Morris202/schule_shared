#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
= Theorie
BGP Path Manipulation ist eine Technik, die von Angreifern verwendet wird, um den Datenverkehr über das Internet zu manipulieren. BGP Path Manipulation kann dazu verwendet werden, um Datenverkehr über einen bestimmten Pfad zu leiten oder um Datenverkehr zu blockieren. 

== Szenario
In unserem Beispiel sagen wir, dass aufgrund des höheren Datendurchsatzes von AS2 wir die Route zu 209.123.2.0 über AS2 leiten wollen und nicht nur über AS3. 
Wir konfigurieren daher auf dem ST-BR1 Router eine Route Map, die den Pfad zu 209.123.2.0 über AS2 leitet. 

== Konfiguration
#sourcecode[```bash
ip prefix-list route_TO_SHIELD permit 209.123.2.0/24

route-map TO_SHIELD permit 10
  match ip address prefix-list route_TO_SHIELD
  set local-preference 200

  router bgp 1
  neighbor 209.123.6.2 route-map TO_SHIELD in
```]

#figure(
  image("routebef.png", width: 70%),
  caption: [Route vor der Manipulation]
)


#figure(
  image("routeaft.png", width: 70%),
  caption: [Route nach der Manipulation]
)


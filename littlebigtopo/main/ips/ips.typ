#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Intrution Prevention System],
  subtitle: none,
  authors: ("Morris Tichy","Lukas Freundesprung",),
  fach: "Little Big Topo",
  thema: "Intruion Prevention System",
  create-outline: true,
  enumerate: true
)
= Theorie
Ein Intrusion Prevention System (IPS) ist eine Technologie, die den unautorisierten Zugriff auf ein Netzwerk verhindert. IPS-Systeme überwachen den Datenverkehr und blockieren oder alarmieren, wenn sie verdächtige Aktivitäten erkennen. IPS-Systeme können auf verschiedenen Ebenen des OSI-Modells arbeiten, um Daten zu schützen. IPS-Systeme können auf der Anwendungsschicht arbeiten, um Daten in E-Mails oder Webseiten zu schützen.

= Konfiguration
In der FortiGate GUI wird unter *Security Profiles > Intrusion Prevention* eine neues IPS-Profil erstellt. In diesem Profil werden Regeln definiert, die den Datenverkehr überwachen und blockieren oder alarmieren, wenn verdächtige Aktivitäten erkannt werden. Es wird dabei eine Signatur erstellt. 

Dieses Profil wird dann anschließend der Firewall Policy zugewiesen, um den Datenverkehr zu überwachen.

= Test
Um die Funktionalität des IPS zu testen, kann ein Angriff simuliert werden. Dazu kann ein Angriffssignatur in das Profil eingefügt werden.

Unter *Logs & Reports > System Events* werden die Events von IPS angezeigt. 
#figure(
  image("sysevents.png", width: 70%),
  caption: [System Events]
)

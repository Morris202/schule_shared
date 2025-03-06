#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Bind9 Forwarder],
  subtitle: none,
  authors: ("Morris Tichy", "Lukas Freudensprung",),
  fach: "Little Big Topo",
  thema: "Bind9 Forwarder",
  create-outline: true,
  enumerate: true
)
= Bind9 Forwarder 
Ein Forwarder in der DNS-Welt ist ein DNS-Server, der Anfragen an einen anderen DNS-Server weiterleitet, anstatt sie selbst zu beantworten. BIND9, als einer der beliebtesten DNS-Server, ermöglicht es, Anfragen an sogenannte Forwarder-Server weiterzuleiten, wenn der BIND9-Server selbst die Anfrage nicht lösen kann. 

== Checkliste 
- Installieren des Diensts 
- Forwarder Konfigurieren 
- Konfiguration überprüfen 
- BIND9-Dienst neu starten 
- Installieren des Diensts 

```bash
sudo apt install bind9 bind9utils bind9-doc dnsutils 
```

== Forwarder Konfigurieren 
```bash
options { 
  directory "/var/cache/bind"; 
  forwarders { 
    8.8.8.8; 
    8.8.4.4;
  }; 
  forward only; 
  allow-query { local-lan; }; 
  dnssec-validation auto; 
  auth-nxdomain no;    // conform to RFC1035 
  listen-on-v6 { any; }D; 
  recursion yes; 
  querylog yes; // Disable if you want, nice for debugging. 
  version "not available"; // Disable for security 
}; 
```


=== Konfiguration überprüfen 
```bash sudo named-checkconf``` 

BIND9-Dienst neu starten 

```bash sudo systemctl restart bind9``` 

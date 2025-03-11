#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
#show: doc => conf(
  doc,
  title: [Little Big Topo],
  subtitle: none,
  authors: ("Lukas Freudensprung", "Morris Tichy",),
  fach: "NWTK",
  thema: "Little Big Topo",
  create-outline: true,
  enumerate: true
)

= ISP


= Switching

#include "Switching/Private VLANs/PVLANs.typ"


= Firewalls

#include "Firewalls/av_FortiGate/av_fortigate.typ"
#include "Firewalls/dataleakprev/dataleakprev.typ"
#include "Firewalls/ips/ips.typ"
#include "Firewalls/webfilter/webfilter.typ"
#include "Firewalls/fg_bogonblock/fg_bogonblock.typ"
#include "Firewalls/HA-Cluster/hacluster.typ"
#include "Firewalls/vpn_psk/vpn_psk.typ"
#include "Firewalls/NPS_FG_CP/nps.typ"
#include "Firewalls/staticnat/staticnat.typ"


= Active Directory

==  Active Directory Directory Services

#include "AD/ADDS/ADDS.typ"

== Active Directory Sites und Site-Links

#include "AD/Sites/Sites.typ"

== Active Directory Users und Computers

#include "AD/Users_Computers/Users_Computers.typ"

== Hardening

#include "AD/Hardening/GPOs/GPOs.typ"
#include "AD/Hardening/Credentials Protection/Credentials_Protection.typ"
#include "AD/Hardening/Windows Security Baseline/Windows_Security_Baseline.typ"
#include "AD/Hardening/Advanced Security Audit Policies/Advanced_Security_Audit_Policies.typ"


= Linux

#include "Linux/bind9/bind9.typ"
#include "Linux/Metasploit/metasploit.typ"
#include "Linux/prometheus_grafana/prometheus-grafan.typ"
#include "Linux/wireguard/wireguard.typ"
#include "Linux/syslog/syslog.typ"
#include "Linux/LinuxFW/linuxfw.typ"
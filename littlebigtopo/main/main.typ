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
= Firewalls
#include "Firewalls/av_FortiGate/av_fortigate.typ"
#include "Firewalls/dataleakprev/dataleakprev.typ"
#include "Firewalls/fg_bogonblock/fg_bogonblock.typ"
#include "Firewalls/HA-Cluster/hacluster.typ"
#include "Firewalls/ips/ips.typ"
= Active Directory

#include "AD/Advanced Security Audit Policies/main.typ"
#include "AD/Credentials Protection/main.typ"

= Linux




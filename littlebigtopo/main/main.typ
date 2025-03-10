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

= Active Directory

#include "AD/Advanced Security Audit Policies/Advanced_Security_Audit_Policies.typ"
#include "AD/Credentials Protection/Credentials_Protection.typ"
#include "AD/GPOs/GPOs.typ"
#include "AD/Windows Security Baseline/Windows_Security_Baseline.typ"

= Linux

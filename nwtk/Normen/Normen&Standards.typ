#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [Normen & Standards der IT],
  subtitle: none,
  authors: ("Lukas Freundensprung", "Sebasatian Trostmann", "Abd-Sattaar Matitu", "Morris Tichy",),
  fach: "NWTK",
  thema: "Normen & Standards der IT",
  create-outline: true,
  enumerate: true
)

#include "chapters/cobit.typ"
#include "chapters/sox.typ"
#include "chapters/itil.typ"
#include "chapters/nis.typ"
#include "chapters/cissp.typ"
#include "chapters/Audit.typ"
#include "chapters/27001audit.typ"
#include "chapters/itgrundschutz.typ"
#include "chapters/quellen.typ"




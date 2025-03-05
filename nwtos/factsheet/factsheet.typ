#import "@preview/document:0.1.0": *
#show: doc => conf(
  doc,
  title: [B3 - Factsheet],
  subtitle: none,
  authors: ("REI (I)", "KRE (I)",),
  fach: "FACH",
  thema: "THEMA",
  create-outline: true,
  enumerate: true
)

#include "3.1.typ"
#include "3.2.typ"
#include "3.3.typ"
#include "3.4.typ"
#include "3.5.typ"
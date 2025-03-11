#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

=== Standorte

*Site-1-AvangerHQ*
#sourcecode[```bash
New-ADReplicationSite -Name "Site-1-AvangerHQ"
New-ADReplicationSubnet -Name "192.168.50.0/24" -Site "Site-1-AvangerHQ"
```]

*Site-2-Wakanda*
#sourcecode[```bash
New-ADReplicationSite -Name "Site-2-Wakanda"
New-ADReplicationSubnet -Name "10.10.0.0/24" -Site "Site-2-Wakanda"
```]

*Site-3-SS*
#sourcecode[```bash
New-ADReplicationSite -Name "Site-3-SS"
New-ADReplicationSubnet -Name "192.168.125.0/24" -Site "Site-3-SS"
```]

=== Site-Links

*Site-1-AvangerHQ und Site-2-Wakanda*
#sourcecode[```bash
New-ADReplicationSiteLink -Name S1-S2 -SitesIncluded Site-1-AvangerHQ,Site-2-Wakanda -Cost 50 -ReplicationFrequencyInMinutes 15
```]

*Site-2-Wien und Site-3-SS*
#sourcecode[```bash
New-ADReplicationSiteLink -Name S2-S3 -SitesIncluded Site-2-Wien,Site-3-SS -Cost 100 -ReplicationFrequencyInMinutes 15
```]

*Site-3-SS und Site-1-HQ*
#sourcecode[```bash
New-ADReplicationSiteLink -Name S3-S1 -SitesIncluded Site-3-SS,Site-1-HQ -Cost 50 -ReplicationFrequencyInMinutes 15
```]

=== Server in Standorte verschieben
#sourcecode[```bash
Move-ADDirectoryServer -Identity "DC1" -Site "Site-1-AvangerHQ"
Move-ADDirectoryServer -Identity "DC2" -Site "Site-1-AvangerHQ"
Move-ADDirectoryServer -Identity "DC3" -Site "Site-2-Wakanda"
Move-ADDirectoryServer -Identity "DC4" -Site "Site-2-Wakanda"
Move-ADDirectoryServer -Identity "RODC" -Site "Site-3-SS" 
```]

#figure(
  image("figures/Sites.png", width: 90%),
  caption: [Active Directory Sites und Site-Links],
)
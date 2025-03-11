#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

=== OU Struktur

Die Organizational Unit (OU) Struktur wurde nach dem Business-Unit Modell aufgebaut. Die Struktur ist in vier Abteilungen unterteilt:
- Marketing
- IT
- Sales
- Geschäftsführung

#sourcecode[```bash
$domainDN = "DC=AvengerHQ,DC=at"

# Top-Level OUs
$topLevelOUs = @("Marketing", "IT", "Sales", "Geschäftsführung")
foreach ($ou in $topLevelOUs) {
    $ouPath = "OU=$ou,$domainDN"
    if (-not (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $ouPath } -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path $domainDN -ProtectedFromAccidentalDeletion $true
        Write-Output "Created OU: $ou"
    } else {
        Write-Output "OU already exists: $ou"
    }
}

# Child OUs for each Top-Level OU
$childOUs = @("Users", "Computers", "Resources", "Special")
foreach ($parentOU in $topLevelOUs) {
    foreach ($childOU in $childOUs) {
        $childPath = "OU=$childOU,OU=$parentOU,$domainDN"
        if (-not (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $childPath } -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $childOU -Path "OU=$parentOU,$domainDN" -ProtectedFromAccidentalDeletion $true
            Write-Output "Created OU: $childOU under $parentOU"
        } else {
            Write-Output "OU already exists: $childOU under $parentOU"
        }
    }
}
```]

#figure(
  image("figures/OU-Struktur.png", width: 70%),
  caption: [Active Directory OU Struktur],
)

=== User und Gruppen

Für jede Abteilung wurde eine globale Gruppe erstellt:
- G_Marketing
- G_IT
- G_Sales
- G_Geschäftsführung

Darüber hinaus wurde für jede Abteilung realistische Benutzer erstellt:\
Name: Laura Becker 
- Benutzername: l.becker 
- Passwort: "M\@rketing2024!"
- Abteilung: Marketing

Name: Anna Bauer 
- Benutzername: a.bauer
- Passwort: "A.B2024!"
- Abteilung: Marketing

Name: Lena Schmidt 
- Benutzername: l.schmidt
- Passwort: "L.S2024!"
- Abteilung: Marketing

Name: Thomas Meier
- Benutzername: t.meier
- Passwort: "IT\@M2024!"
- Abteilung: IT

Name: Sarah Meier 
- Benutzername: s.meier 
- Passwort: "IT\@M2024!"
- Abteilung: IT 

Name: David Weber
- Benutzername: d.weber
- Passwort: "IT\@W2024!"
- Abteilung: IT

Name: Julia Fischer 
- Benutzername: j.fischer
- Passwort: "S\@les2024!"
- Abteilung: Sales

Name: Peter Hoffmann
- Benutzername: p.hoffmann
- Passwort: "P.H2024!"
- Abteilung: Sales

Name: Markus Becker 
- Benutzername: m.becker
- Passwort: "M.B2024!"
- Abteilung: Sales

Name: Klaus Wagner 
- Benutzername: k.wagner
- Passwort: "G\@Führung2024!"
- Abteilung: Geschäftsführung

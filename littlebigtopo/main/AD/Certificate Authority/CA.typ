#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "Root-CA"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "AvengerHQ"
New-NetIPAddress -InterfaceAlias "AvengerHQ" -IPAddress "192.168.50.5" -PrefixLength 24 -DefaultGateway "192.168.50.254"
Set-DnsClientServerAddress -InterfaceAlias "AvengerHQ" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
Add-Computer -DomainName "AvengerHQ.at" -Credential (Get-Credential) -Restart
```]

=== CAPolicy.inf erstellen

Start -> Run -> notepad C:\\Windows\\CAPolicy.inf (Create New File)

#sourcecode[```bash
[Version]
Signature="$Windows NT$"

[PolicyStatementExtension]
Policies=InternalPolicy

[InternalPolicy]
OID= 1.2.3.4.1455.67.89.5
Notice="Legal Policy Statement"
URL=http://Root-CA.AvengerHQ.at/cps.txt

[Certsrv_Server]
RenewalKeyLength=2048
RenewalValidityPeriod=Years
RenewalValidityPeriodUnits=10
LoadDefaultTemplates=0
AlternateSignatureAlgorithm=1
```]

=== Post Installation Timer Konfiguration

#sourcecode[```bash
# Best Practice "Timer" Configuration
Certutil -setreg CA\CRLPeriodUnits 2
Certutil -setreg CA\CRLPeriod "Weeks"
Certutil -setreg CA\CRLDeltaPeriodUnits 1
Certutil -setreg CA\CRLDeltaPeriod "Days"

Certutil -setreg CA\CRLOverlapPeriodUnits 12
Certutil -setreg CA\CRLOverlapPeriod "Hours"

Certutil -setreg CA\ValidityPeriodUnits 10
Certutil -setreg CA\ValidityPeriod "Years"

Certutil -setreg CA\AuditFilter 127
```]

=== AIA konfigurieren
AIA (Authority Information Access)\
Gibt an, wo Informationen über die ausstellende CA oder den Zertifikatsstatus (z. B. über OCSP) gefunden werden können.

#sourcecode[```bash
certutil -setreg CA\CACertPublicationURLs "1:C:\Windows\system32\CertSrv\CertEnroll\%1_%3%4.crt\n2:ldap:///CN=%7,CN=AIA,CN=Public Key Services,CN=Services,%6%11\n2:http://pki.AvengerHQ.at/CertEnroll/%1_%3%4.crt"
certutil -getreg CA\CACertPublicationURLs 
```]

=== CDP konfigurieren
CDP (CRL Distribution Point)
Zeigt, wo die Zertifikatsperrliste (CRL) abgerufen werden kann, um widerrufene Zertifikate zu prüfen.

#sourcecode[```bash
certutil -setreg CA\CRLPublicationURLs "65:C:\Windows\system32\CertSrv\CertEnroll\%3%8%9.crl\n79:ldap:///CN=%7%8,CN=%2,CN=CDP,CN=Public Key Services,CN=Services,%6%10\n6:http://pki.AvengerHQ.at/CertEnroll/%3%8%9.crl\n65:file://\\IIS.AvengerHQ.at\CertEnroll\%3%8%9.crl"
certutil -getreg CA\CRLPublicationURLs
```]

=== CA Certificate AIA veröffentlichen

#sourcecode[```bash
cd c:\windows\system32\certsrv\certenroll
copy "Root-CA.AvangerHQ.at_AvangerHQ-Root-CA.crt" \\IIS.AvangerHQ.at\C$\CertEnroll
net stop certsvc && net start certsvc
```]

=== CA Certificate CDP veröffentlichen

Server Manager -> Tools -> Certificate Authority -> AvengerHQ-Root-Ca -> Revoked Certificates -> All Tasks -> Publish

#figure(
  image("figures/publish_CDP.png", width: 90%),
  caption: [Root Zertifikat veröffentlichen],
)

#figure(
  image("figures/publish_CDP_test.png", width: 90%),
  caption: [Root Zertifikat überprüfen],
)

=== Web Server Security Group

Server Manager -> Tools -> Active Directory -Users and -Computers -> Users  -> New -> Group

#figure(
  image("figures/Web_Server_Group_erstellen.png", width: 90%),
  caption: [Security Group Web Server erstellen],
)

IIS Webserver der Gruppe hinzufügen

#figure(
  image("figures/Web_Server_hinzufügen.png", width: 90%),
  caption: [IIS Webserver der Gruppe hinzufügen],
)

=== Webserver Certificate Template erstellen

Server Manager -> Tools -> Certificate Authority -> 5cn Root CA -> Certificate Templates -> Manage -> Web Server -> Duplicate Template

#figure(
  image("figures/Template_erstellen.png", width: 90%),
  caption: [Webserver Certificate Template erstellen],
)

Folgende Properties anpassen:
- Template Display Name: 5cn Web Server
- Subject Name: DNS name
- Security: Web Server Group hinzufügen
  - Permissions: Read & Enroll

=== CA für Zertifikatsausstellung konfigurieren

Certificate Templates -> New -> Certificate Template to Issue -> 5cn Web Server

#figure(
  image("figures/issue_template.png", width: 90%),
  caption: [Certificate Template ausstellen],
)

=== Request SSL Certificate

Open MMC -> File -> Add/Remove Snap-in -> Certificates -> Computer account -> Finish -> Ok

#figure(
  image("figures/mmc.png", width: 90%),
  caption: [MMC Certificate Snap-in],
)

Certificates (Local Computer) > Personal -> All Tasks -> Request New Certificate -> Next ->  Next -> Select 5cn Web Server Template -> Enroll -> Finish

#figure(
  image("figures/mmc_enroll.png", width: 90%),
  caption: [Web Server Certificate auswählen],
)

#figure(
  image("figures/mmc_enroll_properties.png", width: 90%),
  caption: [Web Server Certificate Properties festlegen],
)

=== Enable SSL

Server Manager -> Tools -> Internet Information Service (IIS) Manager -> WinFreS4 -> Sites -> Default Web Site -> Edit Bindings -> Add-Computer

#figure(
  image("figures/iis_enable_ssl.png", width: 90%),
  caption: [IIS Manager SSL aktivieren],
)

#figure(
  image("figures/iis_enable_ssl_2.png", width: 90%),
  caption: [IIS Manager SSL aktivieren],
)

=== Web Server Certificate Test

Internet Explorer -> https://iis.avengerHQ.at oder https://pki.avengerHQ.at

#figure(
  image("figures/certificate_test.png", width: 100%),
  caption: [Web Server Certificate Test],
)
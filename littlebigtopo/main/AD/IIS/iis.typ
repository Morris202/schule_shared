#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "IIS"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "AvengerHQ"
New-NetIPAddress -InterfaceAlias "AvengerHQ" -IPAddress "192.168.50.3" -PrefixLength 24 -DefaultGateway "192.168.50.254"
Set-DnsClientServerAddress -InterfaceAlias "AvengerHQ" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
Add-Computer -DomainName "AvengerHQ.at" -Credential (Get-Credential) -Restart
```]

=== Web Server IIS Role installieren

login with AvangerHQ\\Administrator

#sourcecode[```bash
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
```]

=== CertEnroll Folder erstellen und Share

#sourcecode[```bash
New-Item -Path C:/CertEnroll -ItemType Directory -Force
New-SmbShare -Name CertEnroll -Path C:/CertEnroll -FullAccess AvengerHQ\Cert Publishers -ChangeAccess "Authenticated Users"
```]

#figure(
  image("figures/CertEnroll_Share.png", width: 70%),
  caption: [CertEnroll Share erstellen],
)

#figure(
  image("figures/CerEnroll_Share_permissions.png", width: 70%),
  caption: [CertEnroll Share Berechtigungen],
)

=== NTFS Berechtigungen festlegen

#sourcecode[```bash
icacls "C:\CertEnroll" /inheritance:d
icacls "C:\CertEnroll" /grant "SYSTEM:F" "CREATER OWNER:F" "Administrators:F" "AvangerHQ\Cert Publishers:M" "Authenticated Users:RX"
```]

#figure(
  image("figures/CertEnroll_NTFS_permissions.png", width: 80%),
  caption: [CertEnroll NTFS Berechtigungen],
)

=== CertEnroll Virtual Directory erstellen auf IIS

Server Manager -> Tools -> Internet Information Services (IIS) Manager\
IIS -> Sites -> Default Web Site -> right click -> Add Virtual Directory

#sourcecode[```bash
New-WebVirtualDirectory -Site "Default Web Site" -Name "CertEnroll" -PhysicalPath "C:\CertEnroll"
```]

#figure(
  image("figures/IIS_CertEnroll.png", width: 90%),
  caption: [CertEnroll IIS Folder],
)

=== Double Escaping auf IIS Server aktivieren

#sourcecode[```bash
cd C:\windows\system32\inetsrv\
appcmd set config "Default Web Site" /section:system.webServer/Security/requestFiltering -allowDoubleEscaping:True
iisreset
```]

=== CNAME erstellen

#sourcecode[```bash
Add-DnsServerResourceRecordCName -Name "PKI" -ZoneName "AvengerHQ.at" -HostNameAlias "IIS.AvengerHQ.at" -ComputerName "DC1.AvengerHQ"
```]

#figure(
  image("figures/CNAME_erstellen.png", width: 90%),
  caption: [CNAME erstellen],
)
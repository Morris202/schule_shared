#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

=== DC1

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "DC1"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "LAN"
New-NetIPAddress -InterfaceAlias "LAN" -IPAddress "192.168.50.1" -PrefixLength 24 -DefaultGateway "192.168.50.254"
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*Forest Root Domäne AvengerHQ.at erstellen*

#sourcecode[```bash
# Features installieren
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

# Domäne erstellen
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "AvengerHQ.at" -DomainNetbiosName "AvengerHQ" -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$true -SafeModeAdministratorPassword (ConvertTo-SecureString "Supergeheim123!" -AsPlainText -Force) -SysvolPath "C:\Windows\SYSVOL" -Force:$true

Restart-Computer
```]

=== DC2

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "DC2"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "LAN"
New-NetIPAddress -InterfaceAlias "LAN" -IPAddress "192.168.50.2" -PrefixLength 24 -DefaultGateway "192.168.50.254"
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
# Features installieren
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

# Domäne beitreten
Install-ADDSDomainController -DomainName "AvengerHQ.at" -Sitename Default-First-Site-Name -Credential (Get-Credential "AvengerHQ.at\Administrator") -SafeModeAdministratorPassword (ConvertTo-SecureString "Supergeheim123!" -AsPlainText -Force) -InstallDNS -Confirm:$false

# DNS zurück ändern
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("192.168.50.2", "192.168.50.1")
```]

=== WinCLI1

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "WinCLI1"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "LAN"

# Firewallregeln setzen
Set-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -Enabled True -Profile Domain,Private,Public
Set-NetFirewallRule -Name "FPS-ICMP4-ERQ-Out" -Enabled True -Profile Domain,Private,Public

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
Add-Computer -DomainName AvengerHQ.at -Credential (Get-Credential) -Restart
```]

=== WinCLI2

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "WinCLI2"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "LAN"

# Firewallregeln setzen
Set-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -Enabled True -Profile Domain,Private,Public
Set-NetFirewallRule -Name "FPS-ICMP4-ERQ-Out" -Enabled True -Profile Domain,Private,Public

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*AvengerHQ.at beitreten*

#sourcecode[```bash
Add-Computer -DomainName "AvengerHQ.at" -Credential (Get-Credential) -Restart
```]

=== DC3

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "DC3"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "Wakanda"
New-NetIPAddress -InterfaceAlias "Wakanda" -IPAddress "10.10.0.1" -PrefixLength 24 -DefaultGateway "10.10.0.254"
Set-DnsClientServerAddress -InterfaceAlias "Wakanda" -ServerAddresses ("10.10.0.1","10.10.0.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*Child Domäne Wakanda.AvengerHQ.at erstellen*

#sourcecode[```bash
# Features installieren
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

# Domäne erstellen
Install-ADDSDomain -DomainType "child" -NewDomainName "wakanda" -ParentDomainName "AvengerHQ.at" -Credential (Get-Credential "AvengerHQ.at\Administrator") -SafeModeAdministratorPassword (ConvertTo-SecureString "Supergeheim123!" -AsPlainText -Force) -InstallDNS -Confirm:$true

# DNS zurück ändern
Set-DnsClientServerAddress -InterfaceAlias "Wakanda" -ServerAddresses ("10.10.0.1", "192.168.50.1")
```]

=== DC4

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "DC4"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "Wakanda"
New-NetIPAddress -InterfaceAlias "Wakanda" -IPAddress "10.10.0.2" -PrefixLength 24 -DefaultGateway "10.10.0.254"
Set-DnsClientServerAddress -InterfaceAlias "Wakanda" -ServerAddresses ("10.10.0.1")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*Wakanda.AvengerHQ.at beitreten*

#sourcecode[```bash
# Features installieren
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

# Domäne beitreten
Install-ADDSDomainController -DomainName "wakanda.AvengerHQ.at" -Sitename Default-First-Site-Name -Credential (Get-Credential "wakanda.AvengerHQ.at\Administrator") -SafeModeAdministratorPassword (ConvertTo-SecureString "Supergeheim123!" -AsPlainText -Force) -InstallDNS -Confirm:$false

# DNS zurück ändern
Set-DnsClientServerAddress -InterfaceAlias "Wakanda" -ServerAddresses ("10.10.0.2", "192.168.50.1")
```]

=== RODC

*Grundkonfiguration*

#sourcecode[```bash
Rename-Computer -NewName "RODC"

# Netzwerkkonfiguration
Get-NetAdapter Ethernet0 | Rename-NetAdapter -NewName "SS"
New-NetIPAddress -InterfaceAlias "SS" -IPAddress "192.168.125.1" -PrefixLength 24 -DefaultGateway "192.168.125.254"
Set-DnsClientServerAddress -InterfaceAlias "SS" -ServerAddresses ("192.168.50.1", "192.168.50.2")

# Zeitzone setzen
Set-TimeZone -Id "W. Europe Standard Time"

Restart-Computer
```]

*RODC hochstufen und AvengerHQ.at beitreten*

#sourcecode[```bash
# Features installieren
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

# Domäne beitreten
Install-ADDSDomainController -DomainName "AvengerHQ.at" -ReadOnlyReplica:$true -Sitename Default-First-Site-Name -Credential (Get-Credential "AvengerHQ.at\Administrator") -SafeModeAdministratorPassword (ConvertTo-SecureString "Supergeheim123!" -AsPlainText -Force) -InstallDNS -Confirm:$false

# DNS zurück ändern
Set-DnsClientServerAddress -InterfaceAlias "SS" -ServerAddresses ("192.168.125.1", "192.168.50.1")
```]
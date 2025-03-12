#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

== Hub-and-Spoke FlexVPN

Die FlexVPN-Technologie nutzt IKEv2 zur sicheren Verbindung zwischen den Routern. Dabei wird auf dem Hub-Router ein dynamisches Virtual Tunnel Interface (dVTI) und auf den Spoke-Routern ein statisches VTI verwendet.

=== Konfiguration

Im Stark Tower wurde eine Hub-and-Spoke FlexVPN-Architektur implementiert, bei der der Hub-Router über FlexVPN mit drei Spoke-Routern verbunden ist. Zwischen dem Hub und den Spokes befindet sich der Backbone-Router ST-BB1.

- Hub-Router: ST-BR1
- Spoke-Router: ST-BR2 (Spoke 1), ST-BR3 (Spoke 2), ST-BR4 (Spoke 3)

*Hub*
#sourcecode[```
interface Loopback2
ip address 172.16.1.254 255.255.255.255
exit

crypto ikev2 keyring IKEV2_KEYRING
peer SPOKE_ROUTERS
address 0.0.0.0
pre-shared-key local cisco123
pre-shared-key remote cisco123
exit

crypto ikev2 authorization policy IKEV2_AUTHORIZATION
route set interface
route set access-list FLEXVPN_ROUTES
exit

ip access-list standard FLEXVPN_ROUTES
permit any
exit

crypto ikev2 profile IKEV2_PROFILE
match identity remote address 10.0.1.14
match identity remote address 10.0.1.2
match identity remote address 10.0.1.4
identity local address 10.0.1.10
authentication remote pre-share
authentication local pre-share
keyring local IKEV2_KEYRING
aaa authorization group psk list FLEXVPN_LOCAL IKEV2_AUTHORIZATION
virtual-template 1
exit

crypto ipsec profile IPSEC_PROFILE
set ikev2-profile IKEV2_PROFILE
exit

interface Virtual-Template1 type tunnel
ip unnumbered Loopback2
tunnel protection ipsec profile IPSEC_PROFILE
exit
```]

*Spoke 1*
#sourcecode[```
crypto ikev2 keyring IKEV2_KEYRING
peer ST-BR1
address 10.0.1.10
pre-shared-key local cisco123
pre-shared-key remote cisco123
exit
exit

aaa new-model
aaa authorization network FLEXVPN_LOCAL local

crypto ikev2 authorization policy IKEV2_AUTHORIZATION
route set interface
route set access-list FLEXVPN_ROUTES
exit

ip access-list standard FLEXVPN_ROUTES
permit 209.123.3.0 0.0.0.255
exit

crypto ikev2 profile IKEV2_PROFILE
match identity remote address 10.0.1.10
identity local address 10.0.1.14
authentication local pre-share 
authentication remote pre-share 
keyring local IKEV2_KEYRING
aaa authorization group psk list FLEXVPN_LOCAL IKEV2_AUTHORIZATION
exit

crypto ipsec profile IPSEC_PROFILE
set ikev2-profile IKEV2_PROFILE
exit

interface tunnel 0
ip address 172.16.1.1 255.255.255.0
tunnel source gi0/3
tunnel dest 10.0.10.1
tunnel protection ipsec profile IPSEC_PROFILE
exit
```]

*Spoke 2*
#sourcecode[```
crypto ikev2 keyring IKEV2_KEYRING
peer ST-BR1
address 10.0.1.10
pre-shared-key local cisco123
pre-shared-key remote cisco123
exit
exit

aaa new-model
aaa authorization network FLEXVPN_LOCAL local

crypto ikev2 authorization policy IKEV2_AUTHORIZATION
route set interface
route set access-list FLEXVPN_ROUTES
exit

ip access-list standard FLEXVPN_ROUTES
permit 209.123.10.0 0.0.0.255
exit

crypto ikev2 profile IKEV2_PROFILE
match identity remote address 10.0.1.10
identity local address 10.0.1.2
authentication local pre-share
authentication remote pre-share
keyring local IKEV2_KEYRING
aaa authorization group psk list FLEXVPN_LOCAL IKEV2_AUTHORIZATION
exit

crypto ipsec profile IPSEC_PROFILE
set ikev2-profile IKEV2_PROFILE
exit

interface tunnel 0
ip address 172.16.1.2 255.255.255.0
tunnel source gi0/1
tunnel dest 10.0.1.10
tunnel protection ipsec profile IPSEC_PROFILE
exit
```]

*Spoke 3*
#sourcecode[```
crypto ikev2 keyring IKEV2_KEYRING
peer ST-BR1
address 10.0.1.10
pre-shared-key local cisco123
pre-shared-key remote cisco123
exit
exit

aaa new-model
aaa authorization network FLEXVPN_LOCAL local

crypto ikev2 authorization policy IKEV2_AUTHORIZATION
route set interface
route set access-list FLEXVPN_ROUTES
exit

ip access-list standard FLEXVPN_ROUTES
permit 209.123.6.0 0.0.0.255
exit

crypto ikev2 profile IKEV2_PROFILE
match identity remote address 10.0.1.10
identity local address 10.0.1.4
authentication local pre-share 
authentication remote pre-share 
keyring local IKEV2_KEYRING
aaa authorization group psk list FLEXVPN_LOCAL IKEV2_AUTHORIZATION
exit

crypto ipsec profile IPSEC_PROFILE
set ikev2-profile IKEV2_PROFILE
exit

interface tunnel 0
ip address 172.16.1.3 255.255.255.0
tunnel source gi0/0
tunnel dest 10.0.1.10
tunnel protection ipsec profile IPSEC_PROFILE
exit
```]
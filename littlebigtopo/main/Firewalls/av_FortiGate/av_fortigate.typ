#import "@preview/codelst:2.0.2": sourcecode
== Anti Virus
=== Konfiguration des AV Profiles
Das AV Profile wird so konfiguriert, dass alle Dateien blockiert werden, die als Virus erkannt werden. Der folgende Code zeigt die Konfiguration des AV Profiles.

#sourcecode[```bash
config antivirus profile
    edit "„AV_SVAL“"
        set feature-set proxy
        config http
            set av-scan block
            set outbreak-prevention block
        end
        config ftp
            set av-scan block
            set outbreak-prevention block
        end
        config imap
            set av-scan block
            set outbreak-prevention block
            set executables virus
        end
        config pop3
            set av-scan block
            set outbreak-prevention block
            set executables virus
        end
        config smtp
            set av-scan block
            set outbreak-prevention block
            set executables virus
        end
        config cifs
            set av-scan block
            set outbreak-prevention block
        end
    next
end
```]

=== Custom-Deep-Inspection
Anschließend muss die custom deep inspection konfiguriert werden. Dafür muss auf den Ziel Clients das FortiGate Zertifikat installiert werden. Im Firefox-Browser wird das wie folgt gemacht:

#figure(
  image("ffox.png", width: 70%),
  caption: [FireFox Zertifikat installieren]
)

=== Überprüfung
Damit der AV nun getestet werden kann, wird eine Datei von der Website www.eicar.org installiert. Diese Datei ist ein Testvirus und wird von den meisten AV-Programmen erkannt. Wenn der AV funktioniert, wird die Datei blockiert und der Benutzer sieht folgenden Output.

#figure(
  image("av_greift.png", width: 70%),
  caption: [AV blockiert File]
)
![Version](https://img.shields.io/badge/version-v1.1.0-blue.svg)
![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-5391FE.svg?logo=powershell)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Status](https://img.shields.io/badge/status-stable-brightgreen.svg)
![Maintainer](https://img.shields.io/badge/maintainer-mutanwulf-orange.svg)

1\# 🟦 SVG-Leibchen-Generator \& PDF-Erstellung

Dieses Projekt enthält zwei PowerShell-Skripte:



1\. \*\*generate\_leibchen.ps1\*\*  

&#x20;  → erzeugt SVG-Dateien für Leibchen-Symbole (Zahl + Buchstabe + Form)



2\. \*\*create\_pdf.ps1\*\*  

&#x20;  → erzeugt aus den SVG-Dateien eine druckfertige A4-PDF im 5×4-Raster  

&#x20;    (benötigt Inkscape)



Entwickelt von \*\*mutanwulf\*\* mit Unterstützung von \*\*Microsoft Copilot\*\*.



\---



\## 🚀 Features



\### generate\_leibchen.ps1

\- Erzeugt SVGs in frei wählbaren Kombinationen

\- Unterstützt \*\*Outline-Schrift\*\* oder \*\*normale Schrift\*\*

\- Keine externen Bibliotheken notwendig

\- Vollständig offline nutzbar



\### create\_pdf.ps1

\- Baut aus den SVGs eine \*\*Master-SVG\*\*

\- Exportiert diese über Inkscape als PDF

\- 100% Vektorqualität (perfekt für Druck)

\- Automatisches 5×4-Raster (20 Felder, 18 belegt)



\---



\## 📦 Voraussetzungen



\### Für `generate\_leibchen.ps1`

Keine Installation notwendig.



\### Für `create\_pdf.ps1`

Du benötigst \*\*Inkscape\*\*, entweder:



\#### Installation über winget:

winget install Inkscape.Inkscape



oder



\#### Portable ZIP-Version:

https://inkscape.org/release/



\---



\## ⚠️ PowerShell Execution Policy (wichtig!)



Windows blockiert standardmäßig das Ausführen eigener Skripte.



Damit du die Skripte ausführen kannst:



\### \*\*1. PowerShell als Administrator öffnen\*\*



\### \*\*2. Execution Policy setzen:\*\*

Set-ExecutionPolicy RemoteSigned

oder

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass



Bestätigen mit: \*\*Y\*\*



> 🔒 Sicher:  

> Nur lokal erstellte Skripte dürfen ausgeführt werden.  

> Internet-Skripte benötigen weiterhin eine Signatur.



\---



\## ▶️ Verwendung



\### Syntax



.\\generate\_leibchen.ps1 <SymbolCount> <LetterCount> <NumberCount> <FontMode>



\### Parameter



| Parameter        | Typ    | Beschreibung |

|------------------|--------|--------------|

| `SymbolCount`    | int    | Anzahl der Symbole (max. 4) |

| `LetterCount`    | int    | Anzahl der Buchstaben A–D (max. 4) |

| `NumberCount`    | int    | Anzahl der Zahlen 1–4 (max. 4) |

| `FontMode`       | string | `o` = Outline-Schrift, `n` = normale Schrift |



\---



\## 📝 Beispiele



\### 1. Outline-Schrift (Standard)

.\\generate\_leibchen.ps1 3 3 2 o

![1A_Kreis](./Beispiel/1A_Kreis.svg)

\### 2. Normale Schrift (gefüllt)

.\\generate\_leibchen.ps1 4 4 4 n

![1A_Raute](/Beispiel/1A_Raute.svg)

\---



\## 📁 Ausgabe



Das Script erzeugt automatisch einen Ordner:



svg-332-o



Darin befinden sich alle generierten SVG-Dateien, z. B.:



1A\_Kreis.svg

2C\_Dreieck.svg

4B\_Raute.svg

...



\---



\# 📄 PDF-Erstellung mit create\_pdf.ps1



Dieses Script:



\- lädt alle SVGs aus einem Ordner

\- baut daraus eine \*\*A4‑Master‑SVG\*\*

\- exportiert diese über Inkscape als \*\*PDF\*\*



\### Verwendung:



.\\create\_pdf.ps1



Standardmäßig erwartet das Script:



\- Eingabeordner: `.\\input\_svgs`

\- Ausgabe: `master.svg` + `output.pdf`

\- Inkscape-Pfad: `C:\\Program Files\\Inkscape\\bin\\inkscape.com`



\---



\## 🧩 Projektstruktur

/

├── generate\_leibchen.ps1   # SVG-Generator

├── create\_pdf.ps1          # PDF-Erstellung über Inkscape

├── README.md               # Dokumentation

├── CHANGELOG.md            # Versionshistorie

├── LICENSE                 # MIT-Lizenz

└── svg-...                 # Automatisch erzeugte Ausgabeordner





\---



\## 👨‍💻 Autoren



\- \*\*mutanwulf\*\* – Projektidee, Umsetzung, Tests  

\- \*\*Microsoft Copilot\*\* – Script-Generierung \& technische Unterstützung  



\---



\## © Copyright



© 2026 mutanwulf \& Microsoft Copilot  

Alle Rechte vorbehalten.



\---



\## 📄 Lizenz



Dieses Projekt steht unter der \*\*MIT-Lizenz\*\*.  

Kommerzielle Nutzung ist erlaubt, solange der Copyright-Hinweis

erhalten bleibt.



\---



\## ❤️ Hinweise



Dieses Projekt wurde gemeinsam mit Microsoft Copilot entwickelt,  

um ein praktisches Werkzeug für Trainings- und Organisationsmaterial zu schaffen.



Viel Spaß beim Erstellen deiner SVG‑Leibchen und PDFs!

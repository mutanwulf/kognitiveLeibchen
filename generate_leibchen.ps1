<#
    ------------------------------------------------------------------------------
    Script:        generate_leibchen.ps1
    Beschreibung:  Erzeugt SVG-Dateien für Leibchen-Symbole (Zahl + Buchstabe + Form)
                   in verschiedenen Kombinationen. Unterstützt Outline- oder
                   Normal-Schriftmodus.

    Autor(en):     Marcus Wulf & Microsoft Copilot (AI-Unterstützung)
    Copyright:     © 2024 Marcus Wulf & Microsoft Copilot
                   Alle Rechte vorbehalten.

    Lizenz / Nutzung:
                   Dieses Script darf frei verwendet, angepasst und weitergegeben
                   werden, solange der Copyright-Hinweis erhalten bleibt.
                   Eine kommerzielle Nutzung ist erlaubt, sofern keine Rechte
                   Dritter verletzt werden.

    Parameter:
        [int] SymbolCount  – Anzahl der zu erzeugenden Symbole (max. 4)
        [int] LetterCount  – Anzahl der Buchstaben A–D (max. 4)
        [int] NumberCount  – Anzahl der Zahlen 1–4 (max. 4)
        [string] FontMode  – "o" = Outline-Schrift
                             "n" = normale gefüllte Schrift

    Beispiel:
        .\generate_leibchen.ps1 3 3 2 o
        → erzeugt 3×3×2 SVGs mit Outline-Schrift

        .\generate_leibchen.ps1 4 4 4 n
        → erzeugt alle 64 SVGs mit normaler Schrift

    Hinweis:
        Dieses Script erzeugt ausschließlich SVG-Dateien und benötigt keine
        zusätzlichen Bibliotheken oder externe Tools.
        Es muss nur erlaubt werden, das es ausgeführt werden darf zB mit:
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ------------------------------------------------------------------------------
#>

param(
    [int]$SymbolCount = 4,
    [int]$LetterCount = 4,
    [int]$NumberCount = 4,
    [string]$FontMode = "o"   # o = outline, n = normal
)

# Maximalwerte begrenzen
if ($SymbolCount -gt 4) { $SymbolCount = 4 }
if ($LetterCount -gt 4) { $LetterCount = 4 }
if ($NumberCount -gt 4) { $NumberCount = 4 }

# Schriftstil abhängig vom Parameter
switch ($FontMode.ToLower()) {
    "o" {
        $textStyle = ".textpair { font-family:Arial, sans-serif; fill:none; stroke:black; stroke-width:7; }"
    }
    "n" {
        $textStyle = ".textpair { font-family:Arial, sans-serif; fill:black; stroke:none; }"
    }
    default {
        Write-Host "Ungültiger Schriftmodus! Verwende 'o' für Outline oder 'n' für Normal."
        exit
    }
}

# Ausgabeordner erstellen
$outDir = "svg-$SymbolCount$LetterCount$NumberCount-$FontMode"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

# Symbole definieren
$symbolList = @(
    @{ Name="Kreis";   Svg='<circle cx="200" cy="170" r="140" class="shape"/>';        Y=185; Size=110 },
    @{ Name="Raute";   Svg='<polygon points="200,20 360,170 200,320 40,170" class="shape"/>'; Y=185; Size=100 },
    @{ Name="Dreieck"; Svg='<polygon points="200,20 360,320 40,320" class="shape"/>';  Y=235; Size=110 },
    @{ Name="Quadrat"; Svg='<rect x="60" y="20" width="280" height="280" class="shape"/>'; Y=185; Size=110 }
)

# Buchstaben A–D
$letters = "A","B","C","D"

# Zahlen 1–4
$numbers = 1,2,3,4

# Template
$svgTemplate = @'
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400">
  <style>
    .shape { fill:none; stroke:black; stroke-width:14; }
    TEXT_STYLE_PLACEHOLDER
  </style>

  SYMBOL_PLACEHOLDER

  <text x="200" y="TEXT_Y" text-anchor="middle" dominant-baseline="middle"
        class="textpair" style="font-size:TEXT_SIZEpx">TEXT_PAIR_PLACEHOLDER</text>

</svg>
'@

# Kombinationen erzeugen
for ($s = 0; $s -lt $SymbolCount; $s++) {
    for ($l = 0; $l -lt $LetterCount; $l++) {
        for ($n = 0; $n -lt $NumberCount; $n++) {

            $symbol = $symbolList[$s]
            $letter = $letters[$l]
            $number = $numbers[$n]

            $textPair = "$number $letter"

            $svg = $svgTemplate `
                -replace "SYMBOL_PLACEHOLDER", $symbol.Svg `
                -replace "TEXT_PAIR_PLACEHOLDER", $textPair `
                -replace "TEXT_Y", $symbol.Y `
                -replace "TEXT_SIZE", $symbol.Size `
                -replace "TEXT_STYLE_PLACEHOLDER", $textStyle

            $fileName = "{0}{1}_{2}.svg" -f $number, $letter, $symbol.Name
            $filePath = Join-Path $outDir $fileName

            $svg | Out-File -FilePath $filePath -Encoding utf8
        }
    }
}

Write-Host "SVG-Erstellung abgeschlossen. Dateien im Ordner: $outDir"

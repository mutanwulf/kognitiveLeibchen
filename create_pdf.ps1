param(
    [string]$InputFolder = ".\input_svgs",
    [string]$OutputSVG = ".\master.svg",
    [string]$OutputPDF = ".\output.pdf",
    [string]$InkscapePath = "C:\Program Files\Inkscape\bin\inkscape.com"
)

# SVG-Dateien laden
$svgFiles = Get-ChildItem -Path $InputFolder -Filter *.svg | Sort-Object Name

if ($svgFiles.Count -eq 0) {
    Write-Host "Keine SVG-Dateien gefunden."
    exit
}

Write-Host "Gefundene SVG-Dateien: $($svgFiles.Count)"

# A4 Maße in px (96 DPI)
$A4Width = 794
$A4Height = 1123

$cols = 5
$rows = 4

$cellW = $A4Width / $cols
$cellH = $A4Height / $rows

# Master-SVG erzeugen
$svgHeader = @"
<svg xmlns="http://www.w3.org/2000/svg" width="$A4Width" height="$A4Height">
"@

$svgContent = ""

$index = 0

foreach ($svg in $svgFiles) {
    if ($index -ge ($cols * $rows)) { break }

    $col = $index % $cols
    $row = [math]::Floor($index / $cols)

    $x = $col * $cellW
    $y = $row * $cellH

    $inner = Get-Content $svg.FullName -Raw

    # Entferne äußeres <svg>...</svg>
    $inner = $inner -replace '<svg[^>]*>', ''
    $inner = $inner -replace '</svg>', ''

    $svgContent += "<g transform='translate($x,$y) scale(0.25)'>$inner</g>`n"

    $index++
}

$svgFooter = "</svg>"

# Master-SVG speichern
$fullSVG = $svgHeader + $svgContent + $svgFooter
Set-Content -Path $OutputSVG -Value $fullSVG -Encoding UTF8

Write-Host "Master-SVG erzeugt: $OutputSVG"

# PDF exportieren
& $InkscapePath $OutputSVG --export-type=pdf --export-filename=$OutputPDF

Write-Host "PDF erfolgreich erstellt: $OutputPDF"

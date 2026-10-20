# =============================
#       ANALITZA CARPETA
# =============================

Write-Host "===== ANALITZA CARPETA ====="

$elements = Get-ChildItem

Write-Host "Total d'elements:" $elements.Count
Write-Host ""

# Utilitzo la següent linia per filtrar per fitxers per despres poder-los ordenar més facilment
$fitxers = $elements | Where-Object { $_.PSIsContainer -eq $false }

$top5 = $fitxers | Sort-Object Length -Descending | Select-Object -First 5

Write-Host "Els 5 fitxers mes grans: $top5"
Write-Host ""

foreach ($f in $top5) {
    Write-Host " nom: $($f.Name) i bytes: $($f.Length) bytes"
}
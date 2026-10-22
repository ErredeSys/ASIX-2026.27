# =====================
#       PROCESSOS
# =====================

Write-Host ""
Write-Host "===== DIAGNOSI DEL SISTEMA ====="
Write-Host ""

$processos = Get-Process
$topProc = $processos | Sort-Object CPU -Descending | Select-Object -First 5 Name, Id, CPU

Write-Host "TOP 5 PROCESSOS PER CPU:"
$topProc | Format-Table -AutoSize

# =====================
#        SERVEIS
# =====================

$serveis = Get-Service
$totalServeis = $serveis.Count
$executant = ($serveis | Where-Object { $_.Status -eq 'Running' }).Count
$noexecutant = ($serveis | Where-Object { $_.Status -ne 'Running' }).Count

Write-Host "===== SERVEIS ====="
Write-Host ""


Write-Host "Total de serveis: $totalServeis"
Write-Host "Serveis en execucio: $executant"
Write-Host "Serveis no executats: $noexecutant"

# =====================
# FITXERS
# =====================

$elements = Get-ChildItem

# Agafa només els elements que no són carpetes
$fitxers = $elements | Where-Object { -not $_.PSIsContainer }

$topFitxers = $fitxers | Sort-Object Length -Descending | Select-Object -First 3 Name, Length

Write-Host ""
Write-Host "===== FITXERS ====="
Write-Host ""
Write-Host "Tres fitxers mes grans de la carpeta actual:"
$topFitxers | Format-Table -AutoSize


# =====================
# RESUM FINAL
# =====================

Write-Host "===== RESUM ====="
Write-Host ""
Write-Host "Processos analitzats: $($processos.Count)"
Write-Host "Serveis analitzats: $totalServeis"
Write-Host "Fitxers analitzats: $($fitxers.Count)"

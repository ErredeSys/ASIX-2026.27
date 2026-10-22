# =============================
#       TOP PROCESSOS CPU
# =============================

Write-Host "===== TOP PROCESSOS CPU ====="

$processos = Get-Process

$top10 = $processos | Sort-Object CPU -Descending | Select-Object -First 10 Name, Id, CPU

$top10

Write-Host "Nombre total de processos: " $processos.Count

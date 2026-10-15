# =============================
#       ESTAT DELS SERVEIS
# =============================

Write-Host "===== ESTAT DELS SERVEIS ====="

$serveis = Get-Service
$total = $serveis.Count

$executant = ($serveis | Where-Object { $_.Status -eq 'Running' }).Count
$noexecutant = ($serveis | Where-Object { $_.Status -ne 'Running' }).Count

Write-Host "Total: $total"
Write-Host "Executant: $executant"
Write-Host "No executant: $noexecutant"

# =============================
#    INFORMACIÓ DEL SISTEMA
# =============================

Write-Host "===== INFORMACIÓ DEL SISTEMA ====="

$equip = $env:COMPUTERNAME
$usuari = $env:USERNAME
$versio = $PSVersionTable.PSVersion
$data = Get-Date
$directori = Get-Location

Write-Host "Equip: $equip"
Write-Host "Usuari: $usuari"
Write-Host "PowerShell: $versio"
Write-Host "Data: $data"
Write-Host "Directori actual: $directori".
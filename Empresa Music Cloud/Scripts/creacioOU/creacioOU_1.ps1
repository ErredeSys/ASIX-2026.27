#Creació OU amb valors fixes, amb variables

$nomOU = "Direcció"
$ruta = "DC=musiccloud,DC=local"

try {
    $OU = Get-AdOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

if (-not $OU) {
    New-AdOrganizationalUnit -Name $nomOU -Path $ruta
}
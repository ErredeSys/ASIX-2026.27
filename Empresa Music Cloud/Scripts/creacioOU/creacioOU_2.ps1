#Creació OU amb el nom OU com a valor d'entrada

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU
)

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
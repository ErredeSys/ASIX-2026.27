#Creació OU on l'ordre dels arguments no importa

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,

    [Parameter(Mandatory=$true)]
    [string]$ruta
)

try {
    $OU = Get-AdOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

if (-not $OU) {
    New-AdOrganizationalUnit -Name $nomOU -Path $ruta
}
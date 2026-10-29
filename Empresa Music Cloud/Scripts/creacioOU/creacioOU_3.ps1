#Creació OU amb nom i ruta variable

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
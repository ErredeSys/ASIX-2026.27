#Creació OU on el nom OU és obligatori i, si la ruta no s'especifica, es posa una per defecte

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
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
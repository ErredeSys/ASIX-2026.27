#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.

param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomOU,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

foreach ($ou in $nomOU) {

    try {
        $OU = Get-ADOrganizationalUnit -Identity "OU=$ou,$ruta" -ErrorAction Stop
    }
    catch {
        $OU = $null
    }

    if (-not $OU) {
        New-ADOrganizationalUnit -Name $ou -Path $ruta
    }
}
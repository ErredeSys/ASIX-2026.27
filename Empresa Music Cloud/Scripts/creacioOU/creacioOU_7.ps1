#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomOU,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

function Existeix-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    try {
        Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function New-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    if (-not (Existeix-OU -nom $nom -ruta $ruta)) {
        New-ADOrganizationalUnit -Name $nom -Path $ruta
    }
}

foreach ($ou in $nomOU) {
    Crear-OU -nom $ou -ruta $ruta
}
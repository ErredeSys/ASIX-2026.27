#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomGG,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

function Existeix-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    try {
        Get-GROUPSCOPE -Identity $nom $ruta -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function New-GG {
    param(
        [string]$nomgrup,
        [string]$rutagrup
    )

    if (-not (Existeix-grup -nom $nomgrup -ruta $rutagrup)) {
        exit
    }
    else {
        New-ADGROUP -nomGG $nomgrup -ruta $rutagrup -GROUPSCOPE GLOBAL
    }
}

foreach ($grup in $nomGG) {
    Crear-grup -nom $ou -ruta $ruta
}
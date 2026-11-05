#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomGG,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

function Existeix-ruta {
    param(
        [string]$nom,
        [string]$ruta
    )

    try {
        Get-ADGroup -Identity $nom -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Crear-grup {
    param(
        [string]$nomgrup,
        [string]$rutagrup
    )

    if (-not (Existeix- -nom $nomgrup -ruta $rutagrup)) {
        exit
    }
    else {
        New-ADGROUP -Name $nomgrup -Path $rutagrup -GroupScope GLOBAL
    }
}

foreach ($grup in $nomGG) {
    Crear-grup -nom $grup -ruta $rutagrup
}
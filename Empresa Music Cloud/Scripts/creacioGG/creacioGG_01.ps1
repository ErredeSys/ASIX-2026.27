#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomGG,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

function Existeix-ruta {
    param(
        [string]$ruta
    )

    try {
        Get-ADOrganizationalUnit -Identity $ruta -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Existeix-grup {
    param(
        [string]$nomgrup,
        [string]$rutagrup
    )

    try {
        Get-ADGROUP -Identity $nomgrup in $rutagrup -ErrorAction Stop
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

    if (-not (Existeix-ruta -nom $nomgrup -ruta $rutagrup)) {
        New-ADGROUP -Name $nomgrup -Path $rutagrup -GroupScope GLOBAL
    }
    else {
        exit
    }
}

foreach ($grup in $nomGG) {
    Crear-grup -nom $nomgrup -ruta $ruta
}
#Crear múltiples grups globals dins de la ruta especificada, sense crear els que ja existeixin.

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
        [Parameter(Mandatory=$true)]
        [string]$nomgrup
    )

    try {
        Get-ADGroup -Identity $nomgrup -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Crear-grup {
    param(
        [Parameter(Mandatory=$true)]
        [string]$nomgrup,

        [Parameter(Mandatory=$true)]
        [string]$rutagrup
    )

    if (-not (Existeix-grup -nomgrup $nomgrup)) {
    New-ADGroup -Name $nomgrup -Path $rutagrup -GroupScope Global -ErrorAction SilentlyContinue
}
}

if (-not (Existeix-ruta -ruta $ruta)) {
    exit
}

foreach ($grup in $nomGG) {
    Crear-grup -nomgrup $grup -rutagrup $ruta
}
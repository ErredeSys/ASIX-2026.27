#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

function Existeix-Ruta {
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

function Existeix-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    try {
        Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Crear-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    if (-not (Existeix-OU -nom $nom -ruta $ruta)) {
        New-ADOrganizationalUnit -Name $nom -Path $ruta
        Write-Host "OU creada: $nom"
    }
    else {
        Write-Host "La OU '$nom' ja existeix."
    }
}

if (-not (Existeix-Ruta -ruta $ruta)) {
    Write-Host "La ruta '$ruta' no existeix."
    exit
}
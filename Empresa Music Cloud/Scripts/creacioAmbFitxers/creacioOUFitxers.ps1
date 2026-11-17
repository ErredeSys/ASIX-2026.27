#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer
)

function Escriure-Log {
    param(
        [string]$Tipus,
        [string]$Missatge
    )

    $data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Add-Content `
        -Path ".\registre.log" `
        -Value "$data [$Tipus] $Missatge"
}

Escriure-Log -Tipus "INFO" -Missatge "Inici de l'execució de l'script de creació d'OU"

function Existeix-OU {
    param(
        [string]$nom,
        [string]$ruta
    )

    try {
        Get-ADOrganizationalUnit `
            -Identity "OU=$nom,$ruta" `
            -ErrorAction Stop

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

        try {
            New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop

            Escriure-Log `
                -Tipus "INFO" `
                -Missatge "OU '$nom' creada correctament a '$ruta'"
        }
        catch {
            Escriure-Log `
                -Tipus "ERR" `
                -Missatge "Error en crear l'OU '$nom'"
        }
    }
    else {

        Escriure-Log `
            -Tipus "WARN" `
            -Missatge "L'OU '$nom' ja existeix"
    }
}

Import-Csv $fitxer | ForEach-Object {

    Crear-OU `
        -nom $_.Nom `
        -ruta $_.Ruta
}

Escriure-Log -Tipus "INFO" -Missatge "Final de l'execució de l'script"
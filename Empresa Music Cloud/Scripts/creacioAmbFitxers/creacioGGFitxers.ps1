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

function Existeix-Grup {
    param(
        [string]$Nom
    )

    try {
        Get-ADGroup `
            -Filter "Name -eq '$Nom'" `
            -ErrorAction Stop

        return $true
    }
    catch {
        return $false
    }
}

function Crear-Grup {
    param(
        [string]$Nom,
        [string]$Ruta
    )

    if (-not (Existeix-Grup -Nom $Nom)) {

        try {
            New-ADGroup `
                -Name $Nom `
                -Path $Ruta `
                -GroupScope Global `
                -ErrorAction Stop

            Escriure-Log `
                -Tipus "INFO" `
                -Missatge "Grup '$Nom' creat correctament"
        }
        catch {

            Escriure-Log `
                -Tipus "ERR" `
                -Missatge "Error en crear el grup '$Nom'"
        }
    }
    else {

        Escriure-Log `
            -Tipus "WARN" `
            -Missatge "El grup '$Nom' ja existeix"
    }
}

Import-Csv $fitxer | ForEach-Object {

    Crear-Grup `
        -Nom $_.Nom `
        -Ruta $_.Ruta
}
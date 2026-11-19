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
        -Path "$PSScriptRoot\registre.log"`
        -Value "$data [$Tipus] $Missatge"
}

function Existeix-Usuari {
    param(
        [string]$SamAccountName
    )

    try {
        Get-ADUser `
            -Identity $SamAccountName `
            -ErrorAction Stop

        return $true
    }
    catch {
        return $false
    }
}

function Crear-Usuari {
    param(
        [string]$Nom,
        [string]$Cognom,
        [string]$SamAccountName,
        [string]$Ruta
    )

    if (-not (Existeix-Usuari -SamAccountName $SamAccountName)) {

        try {

            $password = ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force

            New-ADUser `
                -Name "$Nom $Cognom" `
                -SamAccountName $SamAccountName `
                -UserPrincipalName "$SamAccountName@musiccloud.local" `
                -Path $Ruta `
                -AccountPassword $password `
                -Enabled $true `
                -ChangePasswordAtLogon $true `
                -ErrorAction Stop

            Escriure-Log -Tipus "INFO" -Missatge "Usuari '$SamAccountName' creat correctament"
        }
        catch {

            Escriure-Log `
                -Tipus "ERR" `
                -Missatge "Error en crear l'usuari '$SamAccountName'"
        }
    }
    else {

        Escriure-Log `
            -Tipus "WARN" `
            -Missatge "L'usuari '$SamAccountName' ja existeix"
    }
}

Import-Csv $fitxer | ForEach-Object {

    Crear-Usuari `
        -Nom $_.Nom `
        -Cognom $_.Cognom `
        -SamAccountName $_.SamAccountName `
        -Ruta $_.Ruta
}
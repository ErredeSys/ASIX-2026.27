#Crear múltiples OU dins de la ruta especificada, sense crear-ne que ja existeixin.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer
)

function Existeix-OU {
    param(
        [string]$DN
    )

    try {
        Get-ADOrganizationalUnit -Identity $DN -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Crear-OU {
    param(
        [string]$DN
    )

    if (-not (Existeix-OU -DN $DN)) {

        $parts = $DN.Split(',') #Aixó divideix el DN utilitzant les ,

        $nom = $parts[0].Replace('OU=','') #Agafa el primer element de l'array i elimina el prefix OU = que té al principi, per tant el valor que queda serà el nom de la OU.
        $ruta = ($parts[1..($parts.Count-1)]) -join ',' # Agafa tots els elements excepte el primer i els torna a unir per obtenir la ruta pare de la OU.

        New-ADOrganizationalUnit -Name $nom -Path $ruta 
    }
}

foreach ($ou in Get-Content $fitxer) {
    Crear-OU -DN $ou
}
#Creació OU utilitzant objectes

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,

    [string]$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"
)

$objecte = Get-ADObject -Filter "Name -eq '$nomOU'" -SearchBase $ruta

if (-not $objecte) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta
}
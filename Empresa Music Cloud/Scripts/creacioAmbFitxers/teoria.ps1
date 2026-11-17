# Creació usuaris

New-ADUser`
    -Name "Aina Ciurans"`
    -SamAccountName "aciurans"`
    -DisplayName "Aina Ciurans"`
    -UserPrincipalName "aciurans@musiccloud.local"`
    -EmailAdress "aciurans@musiccloud.local"`
    -AccountPassword (ConvertTo-SecureString "musiccloud" -AsPlainText -Force)` #Encryptar el password musiccloud convertint a cadena segura
    -Enabled $true`
    -ChangePasswordAtLogon $true`
    -Path "OU=Administracio,OU=Usuaris,OU=musiccloud,DC=musiccloud,DC=local"

#Modificar usuari

Set-AdUser -Identity aciuransx -Enabled $false

#Afegir usuari a un grup

Add-AdGroupMember`
    -Identitiy "GG-Comercial"`
    -Members "lvidal"

#Saber a quin grup pertany un usuari

Get-AdPrincipalGroupMembership -Identitiy "lvidal"
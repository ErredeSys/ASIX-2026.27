$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Add-Content `
    -Path ".\registre.log" `
    -Value "$data [INFO] Execució 'registre.ps1'"

# INFO 6, WARN, ERR, VERBOSE (massificat), DEBUG, 

Write-Error "$data [ERR] Invalid name"
Write-Warning "$data [WARN] Variable set to default value"



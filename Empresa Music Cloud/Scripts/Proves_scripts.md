## 1. Script – Creació de múltiples OUs

Aquest script permet crear diverses unitats organitzatives indicant els seus noms quan executem l'script. La ruta és opcional i, si no s'indica, les OUs es creen dins de `OU=MusicCloud,DC=musiccloud,DC=local`.

Abans de crear cada OU, comprova si la ruta indicada existeix i si la unitat organitzativa ja està creada. Si existeix, no la torna a crear.

### Execució

```powershell
C:\Compartida\script.ps1 -nomOU "Usuaris","Equips","Grups"
```

També podem indicar una ruta diferent:

```powershell
C:\Compartida\script.ps1 -nomOU "Administracio","Comercial","Desenvolupament","Sistemes","Direccio" -ruta "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
```

### Comprovació

```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```

He comprovat que les unitats organitzatives s'han creat dins de la ruta indicada i que, si torno a executar l'script, no es creen duplicades.
:::

## 2. Script – Creació de múltiples OUs utilitzant fitxers

### Prova 1 – Creació de les OUs

Executem l'script amb el CSV OUs.csv i comprovem el resultat:

```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```

Apareixen `Usuaris`, `Equips`, `Grups` i les tres OUs dins de `Usuaris`.

### Prova 2 – Segona execució (no es dupliquen)

Tornem a executar l'script amb el mateix CSV:

```powershell
.\script.ps1 -fitxer .\OUs.csv
Get-Content .\registre.log -Tail 10
```

Resultat esperat: al log surt un `[WARN] L'OU '...' ja existeix` per cada fila, i el nombre d'OUs no canvia.

### Prova 3 – Ruta que no existeix

Afegim una fila al CSV amb una ruta inexistent:

```csv
Nom,Ruta
Proves,"OU=NoExisteix,DC=musiccloud,DC=local"
```

Resultat esperat: l'OU no es crea i al log apareix `[ERR] Error en crear l'OU 'Proves'`. L'script continua amb la resta de files.

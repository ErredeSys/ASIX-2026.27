# Pràctica

## Objectiu

Preparar el servidor `SRV-AD-01` i promocionar-lo com a primer controlador de domini del domini `musiccloud.local`.

## Escenari

L’empresa **MusicCloud** vol iniciar la implantació d’Active Directory Domain Services.

El servidor Windows Server que s’utilitzarà com a controlador de domini serà:

```text
SRV-AD-01
```

El domini que es crearà serà:

```text
musiccloud.local
```

Aquest servidor també proporcionarà el servei DNS del domini.

## Tasques

### Part 1. Configuració inicial del servidor

Configureu el servidor perquè compleixi els requisits següents:

| Element           | Valor              |
| ----------------- | ------------------ |
| Nom del servidor  | `SRV-AD-01`        |
| Adreça IP         | fixa               |
| DNS preferit      | el mateix servidor |
| Connexió de xarxa | operativa          |
| Zona horària      | correcta           |
| Hora del sistema  | correcta           |

La configuració IP concreta dependrà de la xarxa del laboratori. Anoteu els valors utilitzats.

Completeu la taula següent:

| Paràmetre        | Valor configurat |
| ---------------- | ---------------- |
| Adreça IP        | 192.168.37.2     |
| Màscara          | 255.255.255.0    |
| Porta d’enllaç   |                  |
| DNS preferit     | 192.168.37.2     |
| Nom del servidor | SRV-AD-01        |

### Part 2. Instal·lació del rol AD DS

Localitzeu i utilitzeu el procediment adequat per instal·lar el rol AD DS i promocionar el servidor a controlador de domini. Documenteu breument les comandes o passos utilitzats.

> Pas 1: Instal·lar el rol amb aquesta comanda

```
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

> Pas 2: Importar el mòdul AD DS

```
Import-Module ADDSDeployment
```

### Part 3. Promoció a controlador de domini

Promocioneu el servidor a controlador de domini amb les opcions següents:

| Opció                                  | Valor              |
| -------------------------------------- | ------------------ |
| Tipus d’implantació                    | Crear un nou bosc  |
| Nom del domini arrel                   | `musiccloud.local` |
| Servidor DNS                           | Sí                 |
| Catàleg global                         | Sí                 |
| Nom NetBIOS                            | `MUSICCLOUD`       |
| Controlador de domini de només lectura | No                 |
| Reinici final                          | Sí                 |

Definiu una contrasenya segura per al mode de restauració de serveis de directori.

> Per promocionar el servidor i indicar les diferents opcions he utilitzat aquesta comanda:

```
Install-ADDSForest -DomainName "musiccloud.local" -DomainNetbiosName "MUSICCLOUD" -InstallDNS -NoRebootOnCompletion:$false
```

> I també aquesta altre per posar-li el nom que li correspon:

```
Rename-Computer -NewName "SRV-AD-01"
```

> Seguidament m'ha demanat que indiques la contrasenya del DSRM.

### Part 4. Verificació

Després del reinici, comproveu:

1. Que el servidor s’anomena `SRV-AD-01`.
2. Que el domini `musiccloud.local` existeix.
3. Que el servidor és controlador de domini.
4. Que el servei DNS està instal·lat.
5. Que el DNS resol correctament el domini.

Completeu la taula següent. Adjunta la comanda que has utilitzat per a cada una de les comprovacions.

| Comprovació                          | Resultat                              |
| ------------------------------------ | ------------------------------------- |
| Nom del servidor                     | hostname                              |
| IP fixa configurada                  | Get-NetIPAddress                      |
| AD DS instal·lat                     | Get-WindowsFeature AD-Domain-Services |
| Domini creat                         | Get-ADDomain                          |
| DNS instal·lat                       | Get-WindowsFeature DNS                |
| Resolució de `musiccloud.local`      | Resolve-DnsName musiccloud.local      |
| Eines d’Active Directory disponibles | Get-WindowsFeature RSAT-AD-Tools      |

## Preguntes

Responeu breument:

1. Per què `SRV-AD-01` necessita una IP fixa?

> Perquè un controlador de domini s'ha de poder localitzar sempre a la mateixa IP, ja que si canvies, els clients no podrien contactar amb l'AD.

2. Per què és necessari DNS en un domini Active Directory?

> El DNS en un domini d'AD és necessari ja que sense ell els usuaris i equips no es podrien autenticar i també es necessari per resoldre serveis i localitzar controladors de domini.h

3. Quina diferència hi ha entre instal·lar AD DS i promocionar el servidor a controlador de domini?

> Instal·lar AD DS només afegeix el rol al servidor, en canvi, promocionar crea el bosc, el domini, la DB AD, DNS i converteix el servidor en un DC.

4. Quin és el nom del domini creat?

> musiccloud.local

5. Quin és el nom NetBIOS del domini?

> MUSICCLOUD

6. Per què no és recomanable que els clients del domini utilitzin un DNS extern com a DNS principal?

> No es recomanable ja que no podrien torbar el DC, no podrien iniciar sessió, no es podrien aplicar GPOs i tampoc pot resoldre serveis d'AD.

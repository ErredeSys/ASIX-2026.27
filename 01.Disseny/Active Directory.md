# Activitat: del disseny a l’arquitectura d’AD DS

# Context

MusicCloud ja ha completat el disseny lògic del seu servei de directori.

Abans d’instal·lar Active Directory Domain Services, cal comprovar que l’alumnat identifica correctament els components que s’hauran d’implantar.

# Identificació dels components

A partir de l’arquitectura prevista, indiqueu:

1.  Quin serà el nom del bosc

> musiccloud.local

2.  Quin serà el nom del domini.

> musiccloud.local

3.  Quin servidor actuarà com a controlador de domini.

> El servidor que actuarà com a controlador de domini serà el SRV-AD-01

4.  Quin servidor proporcionarà DNS.

> El servidor que proporcionarà DNS serà el mateix, el SRV-AD-01

5.  Quin protocol s’utilitzarà principalment per a l’autenticació.

> S'utilitzarà principalment Kerberos per l'autenticació

6.  Quin protocol permetrà consultar els objectes.´

> Ens permetrà consultar objectes LDAP

7.  Quin servei de Windows emmagatzema i administra els objectes del domini?

> El servei de Windows que emmagatzema i administra els objectes del domini és l'AD DS.

# Anàlisi de l’arquitectura

Responeu breument:

1.  Per què el servidor `SRV-AD-01` necessita una adreça IP fixa?

> El servidor necessita una adreça IP fixa ja que els usuaris i els serveis buscaràn el servidor per la mateixa IP sempre ja que fa de DC i DNS alhora. Els clients han de tenir la seva IP al dns, i si cambies, no podrien localitzar el domini.

2.  Per què els clients del domini han d’utilitzar un servidor DNS capaç de resoldre la zona d’Active Directory?

> Els clients del domini han d'utilitzar un servidor DNS capaç de resoldre la zona d'Active Directory ja que és el mitjà per localitzar el DC i els serveis de domini com Kerberos i LDAP.

3.  Què passaria si `SRV-AD-01` estigués apagat?

> Si SRV-AD-01 estigués apagat, els usuaris no es podrien autenticar al domini i només podrien iniciar sessió els que tenen les credencials a la cachè. Tampoc es podria entrar a les carpetes compartides, aplicar GPOs i el DNS intern no funcionaria.

4.  Per què un únic controlador de domini és acceptable al laboratori però insuficient en una empresa real?

> És acceptable ja que en el laboratori no tindrem dades crítiques ni usuaris que depenguiin del servei i en cas de fallada, no pasaria res. En canvi, en una empresa real, si cau el DC es pararia tota l'empresa. Per tant, necessitariem tenir més d'un DC amb replicació que ens aportaria redundancia.

5.  Per què els departaments no s’han creat com a dominis diferents?

> Els departaments no s'han creat com a dominis diferents ja que són una divisió únicament organitzativa i no de seguretat ni administrativa. Com musiccloud es una empresa petita, amb un únic domini, OU i grups ja en tenim suficient.

# Planificació de la implantació

Ordeneu les accions següents:

- crear els usuaris.

- comprovar el DNS.

- assignar els usuaris als grups.

- instal·lar AD DS.

- crear les unitats organitzatives.

- preparar la xarxa del servidor.

- unir el client al domini.

- crear el bosc i el domini.

- crear els grups.

- comprovar el funcionament del domini.

Justifiqueu breument l’ordre escollit.

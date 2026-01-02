# Here are some basic commands in cybersecurity 

dirb https://website.com # Analyse URL by brute force to reveal links 

whois https://website.com # Permet de récupérer des infos sur le site, date de création, coordonnées bref un essentiel ! 

traceroute website.com # Affiche la liste des routeurs successifs empruntés par des paquets pour atteindre une destination, ainsi que les délais vers chacun d’eux.

telnet ip port # Ouvre une connexion réseau en clair vers un hôte distant pour interagir avec un service via un terminal.

nmap -p- --script=banner ip # The -p- argument to scan all ports, and --script=banner to see what's likely behind the port

dig website.com #Interroge les serveurs DNS pour obtenir des informations sur les enregistrements (A, MX, NS…).

curl -I https://website.com # Récupère les en-têtes HTTP d’un site, utile pour connaître le serveur, les redirections, etc.

nc -v ip port # Commande NetCat outil réseau pour lire et écrire des données via un port -v veut dire verbose

nmap -sU ip # -sU active le Scan UDP




# NMAP – CHEAT SHEET PENTEST ULTIME (RECON → ENUM → VULN → REPORT)

## 0. Philosophie Pentest (Rappel essentiel)

Nmap n’est **pas un simple scanner de ports**, c’est un **framework de reconnaissance active**.
Un bon pentest avec Nmap suit toujours ce cycle :

1. **Découverte des hôtes**
2. **Scan rapide**
3. **Scan exhaustif**
4. **Détection de services / OS**
5. **Scripts NSE ciblés**
6. **Évasion / discrétion si nécessaire**
7. **Reporting exploitable**

---

## 1. Spécification des Cibles (Target Specification)

| Syntaxe           | Description         | Exemple                |
| ----------------- | ------------------- | ---------------------- |
| `<IP>`            | Hôte unique         | `192.168.1.10`         |
| `<hostname>`      | Nom DNS             | `intranet.local`       |
| `<IP1-IP2>`       | Plage               | `192.168.1.10-50`      |
| `<CIDR>`          | Sous-réseau         | `10.10.10.0/24`        |
| `-iL targets.txt` | Import fichier      | `nmap -iL targets.txt` |
| `-iR 100`         | Cibles aléatoires   | Internet-wide          |
| `--exclude`       | Exclusion           | `--exclude 10.0.0.1`   |
| `--excludefile`   | Fichier d’exclusion | `ignore.txt`           |

---

## 2. Découverte d’Hôtes (Host Discovery)

### Objectif

Identifier **qui est vivant**, sans scanner les ports inutilement.

### Techniques principales

| Option         | Technique      | Usage réel                      |
| -------------- | -------------- | ------------------------------- |
| `-sn`          | Ping Scan      | Découverte rapide               |
| `-Pn`          | No Ping        | ICMP bloqué                     |
| `-PE`          | ICMP Echo      | Réseaux permissifs              |
| `-PP`          | ICMP Timestamp | Souvent oublié                  |
| `-PM`          | ICMP Netmask   | Rare mais utile                 |
| `-PS 443`      | TCP SYN Ping   | Firewall permissif              |
| `-PA 80`       | TCP ACK Ping   | Bypass stateful FW              |
| `-PU 53`       | UDP Ping       | DNS / SNMP                      |
| `-PR`          | ARP Scan       | LAN uniquement (le plus fiable) |
| `-n`           | No DNS         | Gain de vitesse                 |
| `--traceroute` | Chemin réseau  | Identifier FW / routeurs        |

### Commandes typiques

```bash
nmap -sn -PR 192.168.1.0/24
nmap -sn -PE 10.10.10.0/24
nmap -sn -Pn 172.16.0.0/16
```

---

## 3. Techniques de Scan de Ports

### Scans TCP

| Option       | Nom         | Usage Pentest                |
| ------------ | ----------- | ---------------------------- |
| `-sS`        | SYN Scan    | Standard or (furtif, rapide) |
| `-sT`        | TCP Connect | Sans root / pivot            |
| `-sA`        | ACK Scan    | Cartographie firewall        |
| `-sW`        | Window Scan | FW mal configuré             |
| `-sN`        | Null        | IDS basiques                 |
| `-sF`        | FIN         | IDS basiques                 |
| `-sX`        | Xmas        | IDS basiques                 |
| `-sI zombie` | Idle Scan   | Ultra furtif                 |
| `-sM`        | Maimon      | Rare                         |
| `-b ftp`     | FTP Bounce  | Obsolète                     |

### Scans UDP

| Option            | Usage      |
| ----------------- | ---------- |
| `-sU`             | Ports UDP  |
| `--top-ports 100` | UDP ciblé  |
| `-p U:53,161`     | DNS / SNMP |

---

## 4. Spécification des Ports

| Option          | Description      |
| --------------- | ---------------- |
| `-p 80,443`     | Liste            |
| `-p 1-1000`     | Plage            |
| `-p-`           | Tous les ports   |
| `-F`            | Fast (100 ports) |
| `--top-ports N` | Ports fréquents  |
| `-r`            | Ordre séquentiel |
| `-p U:53,T:22`  | Mix UDP/TCP      |

---

## 5. Détection de Services, Versions et OS

| Option                    | Fonction              |
| ------------------------- | --------------------- |
| `-sV`                     | Version exacte        |
| `--version-intensity 0-9` | Précision             |
| `--version-light`         | Rapide                |
| `--version-all`           | Exhaustif             |
| `-O`                      | OS Detection          |
| `--osscan-guess`          | Forcer estimation     |
| `-A`                      | Scan agressif complet |

---

## 6. NSE – Nmap Scripting Engine

### Général

| Option             | Description         |
| ------------------ | ------------------- |
| `-sC`              | Scripts par défaut  |
| `--script vuln`    | Vulnérabilités      |
| `--script safe`    | Non intrusif        |
| `--script auth`    | Authentification    |
| `--script brute`   | Bruteforce          |
| `--script exploit` | Exploitation active |
| `--script-args`    | Arguments           |
| `--script-help`    | Aide                |

### Scripts essentiels par service

| Service | Scripts clés                                       |
| ------- | -------------------------------------------------- |
| HTTP    | `http-enum`, `http-methods`                        |
| HTTPS   | `ssl-enum-ciphers`                                 |
| SMB     | `smb-os-discovery`, `smb-enum-shares`, `smb-vuln*` |
| FTP     | `ftp-anon`                                         |
| MySQL   | `mysql-empty-password`                             |
| SNMP    | `snmp-info`, `snmp-brute`                          |
| SSH     | `ssh-auth-methods`                                 |

---

## 7. Timing et Performance

| Option           | Usage          |
| ---------------- | -------------- |
| `-T0`            | IDS strict     |
| `-T1`            | Très discret   |
| `-T2`            | Polite         |
| `-T3`            | Défaut         |
| `-T4`            | Recommandé     |
| `-T5`            | LAN rapide     |
| `--min-rate`     | Forcer vitesse |
| `--max-retries`  | Réduire essais |
| `--host-timeout` | Timeout hôte   |

---

## 8. Évasion Firewall / IDS

| Technique         | Option          |
| ----------------- | --------------- |
| Fragmentation     | `-f`, `-ff`     |
| MTU custom        | `--mtu`         |
| Leurres           | `-D RND:10`     |
| IP Spoof          | `-S`            |
| Port source       | `-g 53`         |
| Payload aléatoire | `--data-length` |
| TTL custom        | `--ttl`         |
| Checksum invalide | `--badsum`      |

---

## 9. Sorties et Reporting

| Option           | Usage                          |
| ---------------- | ------------------------------ |
| `-oN`            | Lisible                        |
| `-oX`            | XML (Metasploit, Searchsploit) |
| `-oG`            | Grep                           |
| `-oA`            | Tous formats                   |
| `--open`         | Ports ouverts                  |
| `--reason`       | Justification                  |
| `--packet-trace` | Debug réseau                   |
| `--resume`       | Reprise scan                   |

---

## 10. États des Ports

| État       | Signification |             |
| ---------- | ------------- | ----------- |
| Open       | Service actif |             |
| Closed     | Aucun service |             |
| Filtered   | Bloqué        |             |
| Unfiltered | Accessible    |             |
| Open       | Filtered      | Indéterminé |
| Closed     | Filtered      | Indéterminé |

---

## 11. Méthodologie Pentest Recommandée

1. Ping sweep
2. Scan rapide TCP
3. Scan complet TCP
4. Scan UDP ciblé
5. Détection versions / OS
6. Scripts NSE ciblés
7. Évasion si nécessaire
8. Rapport

---

## 12. Ports à Forte Valeur (Prioritaires)

| Port | Service | Risque |
|----|--------|
| 21 | FTP | Anonymous |
| 22 | SSH | Bruteforce |
| 23 | Telnet | Cleartext |
| 25 | SMTP | Open relay |
| 53 | DNS | AXFR |
| 80/443 | Web | RCE, SQLi |
| 111 | RPC | Enum |
| 139/445 | SMB | EternalBlue |
| 161 | SNMP | Fuite massive |
| 3389 | RDP | Bruteforce |
| 8080 | Web Admin | Jenkins/Tomcat |

---

## 13. Commandes de Référence (Pro)

### Scan rapide

```bash
nmap -T4 -F <IP>
```

### Scan complet TCP

```bash
nmap -sS -p- --min-rate 3000 <IP>
```

### Scan UDP ciblé

```bash
nmap -sU --top-ports 100 <IP>
```

### Scan versions + OS

```bash
nmap -sV -O --version-intensity 5 <IP>
```

### Vulnérabilités

```bash
nmap --script vuln <IP>
```

---

## 14. Commande “Couteau Suisse” (Audit Standard)

```bash
nmap -sS -sV -sC -O -p- -T4 --min-rate 1000 -oA audit_complet <IP>
```


# demo-firewall


## Sommaire
### Introduction
### Solutions de firewalls
### Implémentation Manuelle des Solutions de Firewall
### Automatisation et Déploiement via Vagrant
### Analyse des Résultats
### Conclusion


## 1. Introduction
L'objectif de ce projet est de démontrer, via un POC, l'efficacité des solutions de firewall pour protéger un réseau. Pour cela, nous avons d'abord exploré et configuré manuellement différentes solutions (iptables, UFW et nftables) sur une VM, puis nous avons automatisé leur déploiement avec Vagrant. Ce travail permet de comparer les approches, d'identifier leurs avantages et inconvénients et de proposer une solution simple pour sécuriser un environnement réseau.

## 2. Solutions de firewalls
Les firewalls constituent la première ligne de défense dans la protection des infrastructures réseau. Ils permettent de filtrer les flux entrants et sortants en fonction d’un ensemble de règles définies, assurant ainsi que seules les connexions légitimes puissent atteindre les ressources sensibles.

### 2.1 Principes de fonctionnement
Les firewalls s’appuient sur des règles de filtrage qui peuvent être appliquées de manière « stateless » ou « stateful » :

Filtrage Stateless : Chaque paquet est évalué indépendamment, sans tenir compte de l’historique des connexions.
Filtrage Stateful : Les connexions sont suivies et évaluées globalement, permettant d’autoriser automatiquement les réponses aux requêtes initiées en interne.

### 2.2 Solutions de filtrage existantes
Plusieurs technologies se distinguent dans le domaine des firewalls sur les systèmes Linux :

#### Iptables et Netfilter
Description :
Iptables est l’outil traditionnel de configuration du pare-feu sous Linux, fonctionnant en étroite collaboration avec le framework Netfilter intégré au noyau.
Avantages :
Contrôle granulaire sur les règles de filtrage et très flexible pour des configurations avancées.
Inconvénients :
Complexité de la syntaxe et risque d’erreurs lors de configurations manuelles.

#### UFW (Uncomplicated Firewall)
Description :
UFW est un front-end simplifié pour iptables, conçu pour faciliter la mise en place de règles de filtrage de base.
Avantages :
Facilité d’utilisation et rapidité de configuration pour des besoins courants (accès HTTP, HTTPS, SSH, etc.).
Inconvénients :
Moins flexible pour des scénarios de filtrage complexes et une personnalisation avancée.

#### Nftables
Description :
Nftables est la solution de nouvelle génération qui tend à remplacer iptables. Elle propose une syntaxe simplifiée et une gestion unifiée des règles de filtrage.
Avantages :
Performance améliorée et gestion simplifiée des règles avec une syntaxe moderne.
Inconvénients :
Documentation et outils encore en cours de maturisation par rapport à iptables.

### 2.4 Notions de DMZ et segmentation réseau
La mise en place d’une DMZ (Zone Démilitarisée) permet d’isoler les serveurs exposés à l’internet (comme un serveur web) du reste du réseau interne. Cette architecture limite l’impact d’une éventuelle compromission, en empêchant l’accès direct aux ressources critiques situées dans le réseau privé. La segmentation et l’isolement des réseaux sont donc des stratégies clés pour renforcer la sécurité globale d’une infrastructure.

## 3. Implémentation Manuelle des Solutions de Firewall
Cette section détaille l’implémentation manuelle des différentes solutions de firewall sur une machine virtuelle, afin de valider leur fonctionnement et d’en évaluer les performances dans un contexte de tests de sécurité.

### 3.1 Mise en place d’une VM debian 12
Pour commencer, nous avons configuré une machine virtuelle sous Debian 12 avec Vagrant.

### 3.2 Installation et configuration des firewalls
#### 3.2.1 Iptables
Nous avons tout d’abord configuré iptables en définissant des règles de filtrage classiques. Exemple de règles mises en place :

Politique par défaut : Refuser tout le trafic entrant et autoriser le trafic sortant.
Règles spécifiques : Autoriser les connexions entrantes sur le port 80 (HTTP) et 443 (HTTPS), et le port 22 (SSH) pour la gestion à distance.
```bash
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

#### 3.2.2 UFW
L’outil UFW a ensuite été installé et configuré pour simplifier la gestion des règles :

```bash
sudo apt update && sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw enable
```

L’utilisation d’UFW permet une vérification rapide des règles via la commande sudo ufw status verbose.

#### 3.2.3 Nftables
Enfin, nous avons testé nftables pour comparer sa syntaxe et sa gestion des règles. Exemple de configuration :

```bash
sudo apt update && sudo apt install nftables -y
sudo nft add table inet filter
sudo nft add chain inet filter input { type filter hook input priority 0 \; policy drop \; }
sudo nft add rule inet filter input ct state established,related accept
sudo nft add rule inet filter input tcp dport 22 accept
sudo nft add rule inet filter input tcp dport 80 accept
sudo nft add rule inet filter input tcp dport 443 accept
```

### 3.3 Scénarios de tests et validation
Pour vérifier le bon fonctionnement des solutions de firewall, différents tests ont été réalisés à l’aide d’outils comme ping, curl et nmap. Voici un exemple de tableau récapitulatif des tests effectués :

[Insérer analyses]

### 3.4 Analyse comparative des implémentations
L’implémentation manuelle a révélé que :

Iptables offre une flexibilité maximale mais nécessite une bonne maîtrise de sa syntaxe.
UFW simplifie considérablement la gestion des règles, ce qui est avantageux dans un contexte de POC avec des besoins basiques.
Nftables montre des performances intéressantes et une syntaxe plus moderne, bien que son intégration puisse demander un temps d’adaptation.
Cette analyse a permis de justifier l’utilisation de UFW dans la phase d’automatisation via Vagrant, en raison de sa simplicité et de sa capacité à répondre aux exigences du POC.

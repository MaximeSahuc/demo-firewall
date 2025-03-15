# SAE61: Projet Firewall - Implémentation d'une DMZ et sécurisation d'un réseau 


# 1. Introduction

Ce projet vise à démontrer l’efficacité des firewalls pour sécuriser un réseau. À travers un POC, nous avons étudié plusieurs solutions (iptables, UFW, nftables) en les testant manuellement sur une VM, la solution UFW à été retenue. Nous avons ensuite mis en place une infrastructure via Vagrant afin de démontrer l'efficité d'un firewall pour protéger un réseau et les services d'un serveur.

---

# 2. Solutions de firewalls

## 2.1 Principes de fonctionnement

Un firewall filtre le trafic réseau selon des règles définies, offrant deux modes principaux :  
- **Stateless** : Chaque paquet est analysé indépendamment.  
- **Stateful** : Le trafic est évalué dans le contexte d’une connexion active.

## 2.2 Solutions de filtrage existantes

### Iptables et Netfilter
Iptables est l’outil traditionnel de configuration du pare-feu sous Linux, fonctionnant en étroite collaboration avec le framework Netfilter intégré au noyau.

**Avantages :** Contrôle granulaire sur les règles de filtrage et très flexible pour des configurations avancées.
**Inconvénients :** Complexité de la syntaxe et risque d’erreurs lors de configurations manuelles.


### Nftables
Nftables est la solution de nouvelle génération qui tend à remplacer iptables. Elle propose une syntaxe simplifiée et une gestion unifiée des règles de filtrage.

**Avantages :** Performance améliorée et gestion simplifiée des règles avec une syntaxe moderne.

**Inconvénients :** Documentation et outils encore en cours de maturisation par rapport à iptables.


## 2.3 Comparaison des solutions

| **Solution**  | **Description**                       | **Avantages**                       | **Inconvénients**                   |
|---------------|---------------------------------------|-------------------------------------|-------------------------------------|
| Iptables      | Outil traditionnel basé sur Netfilter | Contrôle granulaire et flexible     | Syntaxe complexe                    |
| UFW           | Front-end simplifié pour iptables     | Facilité d’utilisation, rapide      | Limité pour des besoins avancés     |
| Nftables      | Successeur d’iptables                 | Syntaxe moderne, meilleures perfs   | Moins mature que les autres outils  |

## 2.4 Notions de DMZ et segmentation réseau
La mise en place d’une DMZ (Zone Démilitarisée) permet d’isoler les serveurs exposés à l’internet (comme un serveur web) du reste du réseau interne. Cette architecture limite l’impact d’une éventuelle compromission, en empêchant l’accès direct aux ressources critiques situées dans le réseau privé. La segmentation et l’isolement des réseaux sont donc des stratégies clés pour renforcer la sécurité globale d’une infrastructure.

---

# 3. Machines virtuelles

## 3.1 Configurations des VMs

Les VMs sont crées via Vagrant et basées sur Debian 12. Elles sont configurées via des scripts de provisioning pour l'installations des paquets ou configuration du firewall.

### VM: Client LAN
VM sur le réseau LAN, qui servira à tester la connectivitée vers le serveur web et le WAN.


## 3.2 Configuration des firewalls






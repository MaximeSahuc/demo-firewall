# Suivi de projet

## Séance du 3 mars 2025
- Lecture du sujet et analyse du travail demandé
- Répartition des taches et organisation
- Recherches documentaires sur Vagrant, iptables, ufw

## Séance du 5 mars 2025
- Résolution des problèmes lié à l'utilisation de vagrant
    - Erreurs lors de l'utilisation de la dernière version de VirtualBox: retour à la version antérieur
    - Désactivation de modules kernel qui provoquaient des erreurs: KVM_AMD et KVM
- Lancement des premières VM et début des configurations de la VM "server" en modifiant le VagrantFile.

## Séance du 6 mars 2025
- VM serveur : Nginx fonctionnel et accessible
- VM client : fonctionne et peut accéder au serveur web

## Séance du 7 mars 2025
- Anniversaire de Marc
- Lecture de la documentation UFW
- Implémentation du firewall avec des règles spécifique
- Recherches sur l'implémentation d'une DMZ avec Vagrant
- Erreurs VirtualBox (low memory) tandis que la RAM n'était pas pleine, fix: echo 3 > /proc/sys/vm/drop_caches

## Séance du 10 mars 2025
- Début de mise en place d'une DMZ en utilisant une VM spécifique
- Documentation

## Séance du 11 mars 2025
- Implémentation de la DMZ via une machinne 'firewall'
- Rédaction de documentation

## Séance du 12 mars 2025
- Implémentation de la DMZ via la machinne 'firewall'
- Rédaction de documentation
- Rédaction protocole de test des flux réseaux
- Script de lancement de VMs
- Script de tests automatisés des flux réseaux
- Merger les vagrantfile

## Séance du 13 mars 2025
- Script de tests automatisés des flux réseaux
- Configuration firewall
- Test comparaison avec vs sans firewall
- Diapo
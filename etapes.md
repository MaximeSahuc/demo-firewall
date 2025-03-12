1. OK - Configuration initiale de l’environnement

2. OK - Création de la VM serveur
    - Configurer le Vagrantfile pour lancer une VM Debian (ex. Debian 12) avec une IPv4 statique préconfigurée.
    - Vérifier le démarrage de la VM et la connectivité de base.

3. OK - Installation de Nginx sur la VM serveur
    - Intégrer dans le script de provisioning les commandes d’installation de Nginx.
    - Déployer une page web statique pour valider le service.

4. OK - Création de la VM client
    - Configurer une seconde VM via Vagrant sur le même réseau privé (IPv4 statique) pour simuler un client.
    - S’assurer que la VM client peut communiquer avec la VM serveur (test initial avec ping).

5. OK - Test initial d’accès au serveur web
    - Depuis la VM client, utiliser des outils comme curl pour accéder à la page web de la VM serveur et valider la configuration de Nginx.

6. OK - Déploiement manuel d’UFW sur la VM serveur
    - Installer UFW sur la VM serveur.
    - Définir manuellement les règles de base (par exemple, autoriser le trafic HTTP/HTTPS, éventuellement SSH) et activer le firewall.

7. Implémentation d'une DMZ avec les règles réseaux Vagrant

8. Tests de filtrage par UFW
    - Réaliser un script pour chaque machine qui effectuera un test pour vérifier les flux autorisés et bloqués.

9. Documentation et validation finale
    - Consigner toutes les étapes, commandes et résultats dans un journal de bord (traces et logs).
    - S’assurer que le POC répond aux exigences du cahier des charges de manière claire et reproductible.
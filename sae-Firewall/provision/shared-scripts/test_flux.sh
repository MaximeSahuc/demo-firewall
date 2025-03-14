#!/bin/bash

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Adresses IP des serveurs
SERVEUR_IP="192.168.56.20"
CLIENT_LAN_IP="192.168.56.10"
CLIENT_WAN_IP="192.168.57.10"

# Fonction pour tester le ping
test_ping() {
  if ping -W 5 -c 1 "$1" > /dev/null 2>&1; then
    echo -e "  ${GREEN}Ping vers $1 OK${NC}"
    return 0
  else
    echo -e "  ${RED}Ping vers $1 KO${NC}"
    return 1
  fi
}

# Fonction pour tester curl
test_curl() {
  if curl -s --connect-timeout 5 --head "http://$1" > /dev/null 2>&1; then
    echo -e "  ${GREEN}Accès serveur web http://$1 OK${NC}"
    return 0
  else
    echo -e "  ${RED}Accès serveur web http://$1 KO${NC}"
    return 1
  fi
}

# Fonction pour tester SSH
test_ssh() {
  if timeout 0.5 bash -c "</dev/tcp/$1/22" >/dev/null 2>&1; then
    echo -e "  ${GREEN}Accès SSH sur $1 OK${NC}"
    return 0
  else
    echo -e "  ${RED}Accès SSH sur $1 KO${NC}"
    return 1
  fi
}

test_wan() {
  echo -e "\n${BLUE}Test de connectivité vers 'Client WAN (serveur web)'${NC}"
  test_ping "$CLIENT_WAN_IP"
  test_ssh "$CLIENT_WAN_IP"
  test_curl "$CLIENT_WAN_IP"
}

# Déterminer le hostname
HOSTNAME=$(hostname)

# Tests spécifiques en fonction du hostname
case "$HOSTNAME" in
  "client-lan")
    echo -e "${BLUE}Test de connectivité vers 'Serveur'${NC}"
    test_ping "$SERVEUR_IP"
    test_ssh "$SERVEUR_IP"
    test_curl "$SERVEUR_IP"
    # Test WAN access
    test_wan    
    ;;
  "client-wan")
    # Test Client LAN access
    echo -e "${BLUE}Test de connectivité vers 'Client LAN'${NC}"
    test_ping "$CLIENT_LAN_IP"
    test_ssh "$CLIENT_LAN_IP"
    # Test Server access
    echo -e "\n${BLUE}Test de connectivité vers 'Serveur'${NC}"
    test_ping "$SERVEUR_IP"
    test_ssh "$SERVEUR_IP"
    test_curl "$SERVEUR_IP"
    ;;
  "firewall")
    # Test Client LAN access
    echo -e "${BLUE}Test de connectivité vers 'Client LAN'${NC}"
    test_ping "$CLIENT_LAN_IP"
    test_ssh "$CLIENT_LAN_IP"
    # Test Server access
    echo -e "\n${BLUE}Test de connectivité vers 'Serveur'${NC}"
    test_ping "$SERVEUR_IP"
    test_ssh "$SERVEUR_IP"
    test_curl "$SERVEUR_IP"
    # Test WAN access
    test_wan
    ;;
  "serveur")
    # Test Client LAN access
    echo -e "${BLUE}Test de connectivité vers 'Client LAN'${NC}"
    test_ping "$CLIENT_LAN_IP"
    test_ssh "$CLIENT_LAN_IP"
    # Test WAN access
    test_wan
    ;;
  *)
    echo "Hostname non reconnu : $HOSTNAME"
    exit 1
    ;;
esac

exit 0
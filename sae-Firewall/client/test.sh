#!/bin/bash

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Adresses IP des serveurs
SERVEUR_IP="192.168.56.20"
CLIENT_LAN_IP="192.168.56.10"
CLIENT_WAN_IP="192.168.57.10"

# Fonction pour tester le ping
test_ping() {
  if ping -c 1 "$1" > /dev/null 2>&1; then
    echo -e "${GREEN}Test ping $1 OK${NC}"
    return 0
  else
    echo -e "${RED}Test ping $1 KO${NC}"
    return 1
  fi
}

# Fonction pour tester curl
test_curl() {
  if curl -s --head "http://$1" > /dev/null 2>&1; then
    echo -e "${GREEN}Test curl http://$1 OK${NC}"
    return 0
  else
    echo -e "${RED}Test curl http://$1 KO${NC}"
    return 1
  fi
}

# Fonction pour tester SSH
test_ssh() {
  if ssh -o BatchMode=yes -o ConnectTimeout=5 "$1" -l user -p 22 'exit' > /dev/null 2>&1; then
    echo -e "${GREEN}Test SSH $1 OK${NC}"
    return 0
  else
    echo -e "${RED}Test SSH $1 KO${NC}"
    return 1
  fi
}

# Fonction pour tester l'accès WAN (ping vers une adresse externe)
test_wan() {
  if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo -e "${GREEN}Test accès WAN OK${NC}"
    return 0
  else
    echo -e "${RED}Test accès WAN KO${NC}"
    return 1
  fi
}

# Déterminer le hostname
HOSTNAME=$(hostname)

# Tests spécifiques en fonction du hostname
case "$HOSTNAME" in
  "client-lan")
    test_ping "$SERVEUR_IP"
    test_curl "$SERVEUR_IP"
    test_wan
    ;;
  "client-wan")
    if test_ping "$CLIENT_LAN_IP"; then
        echo -e "${GREEN}Test ping $CLIENT_LAN_IP KO (normal)${NC}"
    else
        echo -e "${RED}Test ping $CLIENT_LAN_IP OK (devrait échouer)${NC}"
    fi

    if test_ssh "$CLIENT_LAN_IP"; then
        echo -e "${GREEN}Test SSH $CLIENT_LAN_IP KO (normal)${NC}"
    else
        echo -e "${RED}Test SSH $CLIENT_LAN_IP OK (devrait échouer)${NC}"
    fi

    if test_ssh "$SERVEUR_IP"; then
        echo -e "${GREEN}Test SSH $SERVEUR_IP KO (normal)${NC}"
    else
        echo -e "${RED}Test SSH $SERVEUR_IP OK (devrait échouer)${NC}"
    fi

    test_ping "$SERVEUR_IP"
    test_curl "$SERVEUR_IP"
    ;;
  "firewall")
    test_ping "$SERVEUR_IP"
    test_ping "$CLIENT_LAN_IP"
    test_wan
    ;;
  "serveur")
    test_ping "$CLIENT_LAN_IP"
    test_wan
    ;;
  *)
    echo "Hostname non reconnu : $HOSTNAME"
    exit 1
    ;;
esac

exit 0
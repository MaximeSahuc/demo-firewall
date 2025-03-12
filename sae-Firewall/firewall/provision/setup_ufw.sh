sudo apt update && sudo apt install -yy ufw

# Enable firewall
echo "y" | sudo ufw enable

# Default rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default allow routed


#Allow Host/VM trafic
sudo ufw allow in on eth0
sudo ufw allow out on eth0

# Allow SSH from LAN
sudo ufw allow from 192.168.56.0/24 proto tcp to any port 22

# Allow HTTP & HTTPS from WAN
sudo ufw allow in on eth2 to 192.168.56.20 port 80 proto tcp
sudo ufw allow in on eth2 to 192.168.56.20 port 443 proto tcp

# Allow LAN to WAN trafic 
sudo ufw allow in on eth1 to 192.168.57.0/24
sudo ufw allow in on eth1 to 192.168.57.0/24
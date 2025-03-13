sudo apt update && sudo apt install -yy ufw

# Comment the default ACCEPT ICMP rule 
sudo sed -i '/-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT/s/^/# /' /etc/ufw/before.rules
sudo sed -i '/-A ufw-before-forward -p icmp --icmp-type echo-request -j ACCEPT/s/^/# /' /etc/ufw/before.rules

# Enable firewall
echo "y" | sudo ufw enable


# Default rules
sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw default deny routed


#Allow Host/VM trafic
sudo ufw allow in on eth0 proto tcp to any port 22

# Allow all routed traffic to web server
sudo ufw route allow to 192.168.56.20 port 80 proto tcp

# Allow all routed to WAN
sudo ufw route allow in on eth1 to any

# Reload UFW
sudo ufw reload
# Enable UFW at start
sudo systemctl start ufw
sudo systemctl enable ufw
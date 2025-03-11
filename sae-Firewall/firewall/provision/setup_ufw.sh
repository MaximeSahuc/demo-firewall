sudo apt update && sudo apt install -yy ufw

# Enable firewall
echo "y" | sudo ufw enable

# Default rules
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow "OpenSSH"

# Enable Nginx profile (allow 80:433)
sudo ufw allow "Nginx HTTP"

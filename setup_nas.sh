#!/bin/bash

# --- Configuration Variables ---
SHARE_NAME="NAS_Share"
SHARE_PATH="/mnt/usb"
SAMBA_USER=$USER  # Uses your current logged-in username

echo "------------------------------------------------"
echo "🚀 Starting DIY NAS Setup (Samba)"
echo "------------------------------------------------"

# 1. Update and Install Samba
echo "📦 Installing Samba packages..."
sudo apt update && sudo apt install samba samba-common-bin -y

# 2. Create the Share Directory
echo "📁 Creating directory at $SHARE_PATH..."
sudo mkdir -p $SHARE_PATH
sudo chmod -R 777 $SHARE_PATH

# 3. Backup existing Samba config
echo "💾 Backing up original smb.conf..."
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# 4. Append Configuration to smb.conf
echo "📝 Configuring Samba share settings..."
sudo bash -c "cat >> /etc/samba/smb.conf <<EOF

[$SHARE_NAME]
   path = $SHARE_PATH
   browsable = yes
   writable = yes
   read only = no
   guest ok = no
   force user = $SAMBA_USER
EOF"

# 5. Set Samba Password
echo "🔐 Setting Samba password for user: $SAMBA_USER"
echo "Please enter the password you want to use for network access:"
sudo smbpasswd -a $SAMBA_USER

# 6. Restart Services
echo "🔄 Restarting Samba services..."
sudo systemctl restart smbd
sudo systemctl restart nmbd

echo "------------------------------------------------"
echo "✅ Setup Complete!"
echo "Your NAS is now available at: \\\\$(hostname -I | awk '{print $1}')\\$SHARE_NAME"
echo "------------------------------------------------"

**DIY NAS Server**: Raspberry Pi SMB File Share
This project demonstrates how to transform a Raspberry Pi (or any Linux-based system) into a DIY NAS (Network Attached Storage) using Samba (SMB). This setup allows you to easily offload files, sync media, and access storage across your local network from Windows, macOS, or Linux devices.

🚀 Features
+ Cross-Platform Access: Works seamlessly with Windows Explorer, macOS Finder, and Linux file managers.

+ Simple Setup: Minimal configuration required to get a working file server.

+ User-Level Security: Password-protected access to your shared files.

+ Lightweight: Runs efficiently even on older Raspberry Pi models.

🛠️ Prerequisites
+ A Raspberry Pi (or Linux Server) with an OS installed (Raspberry Pi OS, Ubuntu, etc.).

+ Network access (SSH or direct terminal access).

+ An external hard drive or USB drive for bulk storage.

📋 Step-by-Step Setup
1. Install Samba
First, update your package list and install the necessary Samba packages:
```bash
sudo apt update
sudo apt install samba samba-common-bin -y
```

2. Prepare the Storage Location
If you are using an external drive, ensure it is mounted. For this example, we will use /mnt/usb as the share path.
```bash
# Create the directory if it doesn't exist
sudo mkdir -p /mnt/usb

# Set wide-open permissions (Adjust as needed for security)
sudo chmod -R 777 /mnt/usb
```

3. Configure the Samba Share
Edit the Samba configuration file:
```bash
sudo nano /etc/samba/smb.conf
```

Scroll to the very bottom and add your share configuration. Here is a clean template:
```bash
[NAS_Share]
   path = /mnt/usb
   browsable = yes
   writable = yes
   read only = no
   guest ok = no
   force user = your_username
```

Replace NAS_Share with your preferred name and your_username with your Linux username (default is often pi).

4. Create a Samba User
Samba uses its own password system. Create a password for your user to allow network login:
```bash
sudo smbpasswd -a your_username
```

5. Restart and Verify
Restart the Samba service to apply the changes and check the status:
```bash
sudo systemctl restart smbd
sudo systemctl status smbd
```

Pro Tip: Use the command **$testparm** to check your configuration file for syntax errors.

💻 How to Access Your NAS
On macOS
1. Open Finder.

2. Press Cmd + K.

3. Enter: smb://[YOUR_PI_IP_ADDRESS]/NAS_Share

4. Log in with the Samba username and password you created.

On Windows
1. Open File Explorer.

2. In the address bar, type: \\[YOUR_PI_IP_ADDRESS]\NAS_Share

3. Enter your credentials when prompted.

🛠️ Troubleshooting
If you encounter issues during setup:

+ Service Errors: Run sudo systemctl status smbd to see the error log.

+ Config Errors: Run testparm to ensure your smb.conf isn't corrupted.

+ Permissions: If you can't write to the folder, double-check your chmod settings and the force user field in the config.


Note : This setup_nas.sh  Bash script in repo automates the entire process we discussed. It will install the dependencies, configure the directories, update the Samba configuration, and set your user password

🛠 How to Run the Script
1. Create the file:
```bash
nano setup_nas.sh
```

2. Paste the code above and save (Ctrl+O, Enter, Ctrl+X).

3. Make the script executable:
```bash
chmod +x setup_nas.sh
```

4. Run the script:
```bash
./setup_nas.sh
```

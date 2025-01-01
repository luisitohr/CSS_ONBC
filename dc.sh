#!/bin/bash

# Update system package list
sudo apt update

# Install Samba and its dependencies
sudo apt install -y samba samba-common-bin libpam-smbpass smbclient

# Install Bind9 and its dependencies
sudo apt install -y bind9 bind9utils bind9-doc

# Install additional dependencies for Samba domain controller
sudo apt install -y krb5-user krb5-config winbind libnss-winbind libpam-winbind

# Install necessary tools for network management
sudo apt install -y dnsutils net-tools

# Enable and start Samba and Bind9 services
sudo systemctl enable smbd nmbd winbind bind9
sudo systemctl start smbd nmbd winbind bind9

echo "Dependencies for Samba domain controller with Bind9 have been installed."

#!/bin/bash

# Create directories if they don't exist
mkdir -p /etc/samba/tls

# Generate private key
openssl genpkey -algorithm RSA -out /etc/samba/tls/dc.vcl.onbc.cu.key

# Generate Certificate Signing Request (CSR)
openssl req -new -key /etc/samba/tls/dc.vcl.onbc.cu.key -out /etc/samba/tls/dc.vcl.onbc.cu.csr

# Generate the certificate using the CSR
# Assuming you have a Certificate Authority (CA)
openssl x509 -req -in /etc/samba/tls/dc.vcl.onbc.cu.csr -CA /etc/samba/tls/vcl_CA.crt -CAkey /path/to/ca.key -CAcreateserial -out /etc/samba/tls/dc.vcl.onbc.cu.crt -days 365

# Ensure correct permissions
chmod 600 /etc/samba/tls/dc.vcl.onbc.cu.key
chmod 644 /etc/samba/tls/dc.vcl.onbc.cu.crt
chmod 644 /etc/samba/tls/vcl_CA.crt

echo "TLS certificates generated and placed in /etc/samba/tls/"

#!/bin/bash

# Configuración
CERTS_DIR="/etc/samba/tls"
CA_KEY="$CERTS_DIR/vcl_CA.key"
CA_CERT="$CERTS_DIR/vcl_CA.crt"
SERVER_KEY="$CERTS_DIR/dc.vcl.onbc.cu.key"
SERVER_CSR="$CERTS_DIR/dc.vcl.onbc.cu.csr"
SERVER_CERT="$CERTS_DIR/dc.vcl.onbc.cu.crt"

# Crear directorio para almacenar los certificados
mkdir -p "$CERTS_DIR"
chmod 700 "$CERTS_DIR"

# Generar clave privada de la CA
openssl genrsa -out "$CA_KEY" 4096

# Crear certificado autofirmado para la CA
openssl req -x509 -new -nodes -key "$CA_KEY" -sha256 -days 3650 -out "$CA_CERT" -subj "/C=CU/ST=VC/L=SC/O=ONBC/OU=ONBC VCL/CN=vcl_CA"

# Generar clave privada para el servidor
openssl genrsa -out "$SERVER_KEY" 4096

# Crear CSR para el servidor
openssl req -new -key "$SERVER_KEY" -out "$SERVER_CSR" -subj "/C=CU/ST=VC/L=SC/O=ONBC/OU=ONBC VCL/CN=dc.vcl.onbc.cu"

# Firmar el certificado del servidor con la CA
openssl x509 -req -in "$SERVER_CSR" -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out "$SERVER_CERT" -days 3650 -sha256

# Establecer permisos adecuados
chmod 600 "$CERTS_DIR"/*

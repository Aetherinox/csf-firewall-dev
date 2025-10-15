#!/bin/sh
# #
#   Generate CSF RSA 4096 self-signed certificate (POSIX compliant)
#   Output:
#       configserver.key  -> RSA private key
#       configserver.crt  -> self-signed certificate
# #

set -e

KEY_FILE="configserver.key"
CERT_FILE="configserver.crt"
CNF_FILE="configserver.cnf"

# #
#   Remove previous files if they exist
# #

[ -f "$KEY_FILE" ] && rm -f "$KEY_FILE"
[ -f "$CERT_FILE" ] && rm -f "$CERT_FILE"

# #
#   Step 1 & 2: Generate RSA key + self-signed certificate in one step
# #

openssl req -x509 -nodes -days 3650 -newkey rsa:4096 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -config "$CNF_FILE" \
    -extensions x509_ext

echo "✅ RSA 4096 certificate generated:"
echo "   Key:  $KEY_FILE"
echo "   Cert: $CERT_FILE"

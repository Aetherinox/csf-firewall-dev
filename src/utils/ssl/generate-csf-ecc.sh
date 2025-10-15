#!/bin/sh
# #
#   Generate CSF ECC 384 self-signed certificate (POSIX compliant)
#   Output:
#       configserver.key  -> ECC private key
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
#   Step 1: Generate ECC private key (NIST P-384)
# #

openssl ecparam -name secp384r1 -genkey -noout -out "$KEY_FILE"

# #
#   Step 2: Generate self-signed certificate with CNF
# #

openssl req -x509 -nodes -days 3650 \
    -key "$KEY_FILE" \
    -out "$CERT_FILE" \
    -config "$CNF_FILE" \
    -extensions x509_ext

echo "✅ ECC 384 certificate generated:"
echo "   Key:  $KEY_FILE"
echo "   Cert: $CERT_FILE"

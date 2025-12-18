#!/bin/bash
set -e

if [[ "$1" = "start" ]] ; then
  echo "--> Verificando permissao..."
  chown -R ldap:ldap /usr/local/openldap/var
  chown -R ldap:ldap /usr/local/openldap/etc
  chown -R ldap:ldap /backups

  echo "--> Iniciando OpenLDAP..."
  /usr/local/openldap/libexec/slapd \
    -f /usr/local/openldap/etc/openldap/slapd.conf \
    -u ldap -g ldap \
    -4 -d 2 \
    -h "ldap:/// ldapi:///"
else
  exec "$@"
fi

# LDAP para estudos

# Comandos:

Gerar o hash de senha:<br>
```
docker compose run --rm ldap bash -c 'slappasswd -s "SENHA"'
```

Copiar o HASH da senha para o arquivo slapd.conf

Realizar backup:<br>
```
docker compose run --rm ldap bash -c 'slapcat | gzip -f > /backups/ldap.bkp.$(date +%A).ldif.gz'
```

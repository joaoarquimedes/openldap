# LDAP para estudos

# Comandos:

Gerar o hash de senha:<br>
```
docker compose run --rm ldap bash -c 'slappasswd -s "secret"'
```

Copiar o HASH da senha para o arquivo slapd.conf

Realizar backup:<br>
```
docker compose run --rm ldap bash -c 'slapcat | gzip -f > /backups/ldap.bkp.$(date +%A).ldif.gz'
```

Openldap modo `slapd.conf`, mapear o volume:
```
- ./conf/slapd.conf:/usr/local/openldap/etc/openldap/slapd.conf:rw
```

Openldap modo `cn=config`, converter:
```
docker compose run --rm ldap bash -c 'slaptest -f dist/model/slapd.conf -F etc/openldap/slapd.d/'
# Iniciar o container
# Criar a base:
docker compose exec ldap bash -c 'ldapadd -Y EXTERNAL -H ldapi:/// -f dist/model/base.ldif'
# Teste
docker compose exec ldap bash -c 'ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=example,dc=org'
```

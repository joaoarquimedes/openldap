# LDAP para estudos

# Comandos:

Gerar o hash de senha:<br>
```
docker compose run --rm -it ldap bash -c 'slappasswd -s "SENHA"'
```

Copiar o HASH da senha para o arquivo slapd.conf

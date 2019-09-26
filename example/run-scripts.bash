#!/bin/bash

V_ADMIN="cn=admin,dc=bla,dc=org"
V_PWD="123456"

V_ADD_SCRIPTS="$(ls -1a *add*.ldif)"

V_MOD_SCRIPTS="$(ls -1a *modify*.ldif)"

for V_ADD_SCRIPT in ${V_ADD_SCRIPTS}
do
    echo "Executando ADD ${V_SCRIPT}"
    ldapadd -x -h localhost -D ${V_ADMIN} -w ${V_PWD} -f ${V_ADD_SCRIPT}
done

for V_MOD_SCRIPT in ${V_MOD_SCRIPTS}
do
    echo "Executando MOD ${V_SCRIPT}"
    ldapmodify -x -h localhost -D ${V_ADMIN} -w ${V_PWD} -f ${V_MOD_SCRIPT}
done

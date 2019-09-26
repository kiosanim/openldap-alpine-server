#!/bin/bash

V_ADMIN="cn=admin,dc=bla,dc=org"
V_PWD="123456"

V_ADD_SCRIPTS="$(ls -1a *add*.ldif)"

V_MOD_SCRIPTS="$(ls -1a *modify*.ldif)"

V_LDAP_HOST_URI="ldap://localhost:389"

sub_help() {
    echo -e "Parâmetros inválidos !!!\nTENTE: \n$0 -s: Para ldaps\n$0 -n: Para ldap"
    exit
}

if [ "$1" ]
    then
        case $1 in
            -s | --ldaps ) V_LDAP_HOST_URI="ldaps://localhost:636";;
            -n | --ldap  ) V_LDAP_HOST_URI="ldap://localhost:389";;
            * ) sub_help
        esac
    else
    sub_help

fi

for V_ADD_SCRIPT in ${V_ADD_SCRIPTS}
do
    echo "Executando ADD ${V_SCRIPT}"
    ldapadd -x -H ${V_LDAP_HOST_URI} -D ${V_ADMIN} -w ${V_PWD} -f ${V_ADD_SCRIPT}
done

for V_MOD_SCRIPT in ${V_MOD_SCRIPTS}
do
    echo "Executando MOD ${V_SCRIPT}"
    ldapmodify -x -H ${V_LDAP_HOST_URI} -D ${V_ADMIN} -w ${V_PWD} -f ${V_MOD_SCRIPT}
done

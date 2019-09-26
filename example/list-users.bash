#!/bin/bash

V_ADMIN="cn=admin,dc=bla,dc=org"
V_PWD="123456"
V_USERS_DN="ou=users,dc=bla,dc=org"
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

echo "Listando usuários"
ldapsearch -x -H ${V_LDAP_HOST_URI}  -D ${V_ADMIN} \
                            -w ${V_PWD} \
                            -b ${V_USERS_DN} \
                            -s sub \
                            uid \
			                memberOf


#!/bin/bash

V_ADMIN="cn=admin,dc=bla,dc=org"
V_PWD="123456"
V_USERS_DN="ou=users,dc=bla,dc=org"

echo "Listando usuários"
ldapsearch -x -h localhost  -D ${V_ADMIN} \
                            -w ${V_PWD} \
                            -b ${V_USERS_DN} \
                            -s sub \
                            uid \
			    memberOf


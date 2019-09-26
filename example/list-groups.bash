#!/bin/bash

V_ADMIN="cn=admin,dc=bla,dc=org"
V_PWD="123456"
V_GROUPS_DN="ou=groups,dc=bla,dc=org"

echo "Listando grupos"
ldapsearch -x -h localhost  -D ${V_ADMIN} \
                            -w ${V_PWD} \
                            -b ${V_GROUPS_DN} \
                            -s sub \
                            uid

#!/bin/bash

#############################
## Entrypoint for openldap ##
## Author: Fábio Sartori   ##
## Copyright 09/2019       ##
#############################

########################
## DOCKER ENTRY POINT ##
########################

OPENLDAP_HOME="/etc/openldap"

# SLAPD CONFIG FILE
SLAPD_CONF="${OPENLDAP_HOME}/slapd.conf"
test "${LDAP_ACCESS_CONTROL}" && sed -i "s#@LDAP_ACCESS_CONTROL@#${LDAP_ACCESS_CONTROL}#g" "${SLAPD_CONF}"

# Certs
if [ "${LDAPS_CERT_FILE}" ]
   then
    
    CERTS_HOME=$(dirname ${LDAPS_CERT_FILE})
    mkdir -p ${CERTS_HOME}

    echo "${LDAPS_CERT_SUBJ}"
    # Generating Server Cert and Key
    openssl req \
            -new \
            -x509 \
            -subj "${LDAPS_CERT_SUBJ}" \
            -nodes \
            -out ${LDAPS_CERT_FILE} \
            -keyout ${LDAPS_KEY_FILE} \
            -days 1460

    test "${LDAPS_CA_FILE}" && sed -i "s#@LDAPS_CA_FILE@#${LDAPS_CA_FILE}#g" "${SLAPD_CONF}"
    test "${LDAPS_KEY_FILE}" && sed -i "s#@LDAPS_KEY_FILE@#${LDAPS_KEY_FILE}#g" "${SLAPD_CONF}"
    test "${LDAPS_CERT_FILE}" && sed -i "s#@LDAPS_CERT_FILE@#${LDAPS_CERT_FILE}#g" "${SLAPD_CONF}"

fi

test "${LDAP_SUFFIX}" && sed -i "s#@LDAP_SUFFIX@#${LDAP_SUFFIX}#g" "${SLAPD_CONF}"
test "${LDAP_ADMIN}" && sed -i "s#@LDAP_ADMIN@#${LDAP_ADMIN}#g" "${SLAPD_CONF}"
LDAP_ADMIN_PWD=$(slappasswd -s "${LDAP_ADMIN_PWD}")
test "${LDAP_ADMIN_PWD}" && sed -i "s#@LDAP_ADMIN_PWD@#${LDAP_ADMIN_PWD}#g" "${SLAPD_CONF}"
test "${LDAP_LOG_LEVEL}" && sed -i "s#@LDAP_LOG_LEVEL@#${LDAP_LOG_LEVEL}#g" "${SLAPD_CONF}"

# BASE LDIF
BASE_LDIF="/etc/openldap/base.ldif"
test "${LDAP_SUFFIX}" && sed -i "s#@LDAP_SUFFIX@#${LDAP_SUFFIX}#g" "${BASE_LDIF}"
test "${LDAP_ORGANIZATION}" && sed -i "s#@LDAP_ORGANIZATION@#${LDAP_ORGANIZATION}#g" "${BASE_LDIF}"
test "${LDAP_USERS_BASE_DN}" && sed -i "s#@LDAP_USERS_BASE_DN@#${LDAP_USERS_BASE_DN}#g" "${BASE_LDIF}"
test "${LDAP_GROUPS_BASE_DN}" && sed -i "s#@LDAP_GROUPS_BASE_DN@#${LDAP_GROUPS_BASE_DN}#g" "${BASE_LDIF}"
test "${LDAP_APPS_BASE_DN}" && sed -i "s#@LDAP_APPS_BASE_DN@#${LDAP_APPS_BASE_DN}#g" "${BASE_LDIF}"

# memberOf
MEMBEROF_LDIF="/etc/openldap/memberof.ldif"

## Creating Base Tree

slapadd -l "${BASE_LDIF}"
slapadd -l "${MEMBEROF_LDIF}"

## Executing

SLAPD_URL="ldap:///"

test ${LDAPS_CERT_FILE} && SLAPD_URL="ldaps:///"
    

slapd -d "${LDAP_LOG_LEVEL}" -h "${SLAPD_URL}"

exec "$@"
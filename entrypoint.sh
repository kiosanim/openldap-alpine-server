#!/bin/bash

#############################
## Entrypoint for openldap ##
## Author: Fábio Sartori   ##
## Copyright 09/2019       ##
#############################

########################
## DOCKER ENTRY POINT ##
########################

# SLAPD CONFIG FILE
SLAPD_CONF="/etc/openldap/slapd.conf"
sed -i "s/@LDAP_ACCESS_CONTROL@/${LDAP_ACCESS_CONTROL}/g" "${SLAPD_CONF}"

#if [ "${LDAPS}" = true ]
#    then
#
#    sed -i "s/@LDAP_CA_FILE@/${LDAP_CA_FILE}/g" "${SLAPD_CONF}"
#   sed -i "s/@LDAP_KEY_FILE@/${LDAP_KEY_FILE}/g" "${SLAPD_CONF}"
#    sed -i "s/@LDAP_CERT_FILE@/${LDAP_CERT_FILE}/g" "${SLAPD_CONF}"
#
#fi

sed -i "s/@LDAP_SUFFIX@/${LDAP_SUFFIX}/g" "${SLAPD_CONF}"
sed -i "s/@LDAP_ADMIN@/${LDAP_ADMIN}/g" "${SLAPD_CONF}"
LDAP_ADMIN_PWD=$(slappasswd -s "${LDAP_ADMIN_PWD}")
sed -i "s/@LDAP_ADMIN_PWD@/${LDAP_ADMIN_PWD}/g" "${SLAPD_CONF}"
sed -i "s/@LDAP_LOG_LEVEL@/${LDAP_LOG_LEVEL}/g" "${SLAPD_CONF}"

# BASE LDIF
BASE_LDIF="/etc/openldap/base.ldif"
sed -i "s/@LDAP_SUFFIX@/${LDAP_SUFFIX}/g" "${BASE_LDIF}"
sed -i "s/@LDAP_ORGANIZATION@/${LDAP_ORGANIZATION}/g" "${BASE_LDIF}"
sed -i "s/@LDAP_USERS_BASE_DN@/${LDAP_USERS_BASE_DN}/g" "${BASE_LDIF}"
sed -i "s/@LDAP_GROUPS_BASE_DN@/${LDAP_GROUPS_BASE_DN}/g" "${BASE_LDIF}"

# memberOf
MEMBEROF_LDIF="/etc/openldap/memberof.ldif"

## Creating Base Tree

slapadd -l "${BASE_LDIF}"
slapadd -l "${MEMBEROF_LDIF}"

## Executing

slapd -d "${LDAP_LOG_LEVEL}" -h "ldap:///"

exec "$@"
# openldap-alpine-server
# Author: Fábio Sartori <fabio@fabiosartori.info>
A Simple OpenLDAP Container on Alpine Linux

# Variables

To run, export the variables as described below

| **Variable** | **Example** | **Description** |
|--------------|-------------|-----------------|
| LDAP_ORGANIZATION | Bla Ltd | Organization's Name |
| LDAP_SUFFIX | dc=bla,dc=org | Organization distinguished name |
| LDAP_USERS_BASE_DN | ou=users,dc=bla,dc=org | User's Base DN |
| LDAP_GROUPS_BASE_DN | ou=groups,dc=bla,dc=org | Groups's Base DN |
| LDAP_ADMIN | cn=admin | Admin User |
| LDAP_ADMIN_PWD | pwd | Admin's Password |
| LDAP_ACCESS_CONTROL | access to * by * read | Global Access Control |
| LDAP_CA_FILE | /etc/ldap/ssl/cacert.pem | TLSCACertificateFile |
| LDAP_CERT_FILE | /etc/ldap/ssl/servercrt.pem | TLSCertificateFile |
| LDAP_KEY_FILE | /etc/ldap/ssl/serverkeyopen.pem | TLSCertificateKeyFile |
| LDAP_LOG_LEVEL | 256 | LDAP's LOG LEVEL |
| LDAP_PORT | 389 | LDAP SERVER's PORT |
| LDAPS_PORT | 636 | LDAPS SERVER's PORT |

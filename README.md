# openldap-alpine-server
# Author: Fábio Sartori <fabio@fabiosartori.info>
A Simple OpenLDAP Container on Alpine Linux

# Dependencies
You have to create a volume called **openldap_volume**
```bash
docker volume create openldap_volume
```

# Variables

To run, export the variables as described below

| **Variable** | **Example** | **Description** |
|--------------|-------------|-----------------|
| LDAP_ORGANIZATION | Bla Ltd | Organization's Name |
| LDAP_SUFFIX | dc=bla,dc=org | Organization distinguished name |
| LDAP_USERS_BASE_DN | ou=users,dc=bla,dc=org | User's Base DN |
| LDAP_GROUPS_BASE_DN | ou=groups,dc=bla,dc=org | Groups's Base DN |
| LDAP_APPS_BASE_DN | ou=apps,dc=bla,dc=org | System's Users Base DN |
| LDAP_ADMIN | cn=admin | Admin User |
| LDAP_ADMIN_PWD | pwd | Admin's Password |
| LDAP_ACCESS_CONTROL | access to * by * read | Global Access Control |
| LDAP_LOG_LEVEL | 256 | LDAP's LOG LEVEL |
| LDAP_PORT | 389 | LDAP SERVER's PORT |
| LDAP_HOSTNAME | localhost | LDAP SERVER's HOSTNAME |
| LDAPS_PORT | 636 | LDAPS SERVER's PORT |
| LDAPS_CERT_SUBJ | /C=BR/ST=Bla State/L=Bla City/O=Bla Company/CN=ldap.bla.org | LDAP CERT's Subject " |
| LDAPS_CA_FILE | /etc/ldap/ssl/cacert.pem | TLSCACertificateFile |
| LDAPS_CERT_FILE | /etc/openldap/certs/server.crt | TLSCertificateFile |
| LDAPS_KEY_FILE | /etc/openldap/certs/server.key | TLSCertificateKeyFile |

**ATENTION:** If LDAPS_CERT_FILE variable is provided, than the server will start only in **ldaps:///** mode, or else only in **ldap:///** mode

# Errors

## Self-signed Certificate
If you received the error below on ldaps ldapsearch 

```bash
ldapsearch -v -x -D "cn=admin,dc=bla,dc=org" -W -H ldaps://ldap.bla.org -b "ou=users,dc=bla,dc=org" -s sub 'uid=juvenal'
ldap_start_tls: Connect error (-11)
    additional info: (unknown error code)
Enter LDAP Password:
ldap_result: Can't contact LDAP server (-1)
```

To solve this, add set **TLS_REQCERT** to **never** on **/etc/openldap/ldap.conf** file, as you can see below:

```bash
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

#BASE	dc=example,dc=com
#URI	ldap://ldap.example.com ldap://ldap-master.example.com:666

#SIZELIMIT	12
#TIMELIMIT	15
#DEREF		never
#TLS_REQCERT	demand
TLS_REQCERT 	never
```
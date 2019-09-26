FROM alpine:latest
MAINTAINER Fábio Sartori <fabio@fabiosartori.info>

# Environment variables
ENV LDAP_ORGANIZATION "Bla Ltd"
ENV LDAP_SUFFIX "dc=bla,dc=org"
ENV LDAP_ADMIN "cn=admin"
ENV LDAP_ADMIN_PWD "123456"
ENV LDAP_ACCESS_CONTROL "access to * by * read"
ENV LDAP_USERS_BASE_DN "ou=users,dc=bla,dc=org"
ENV LDAP_GROUPS_BASE_DN "ou=groups,dc=bla,dc=org"
ENV LDAP_APPS_BASE_DN "ou=apps,dc=bla,dc=org"
ENV LDAP_LOG_LEVEL 256
ENV LDAP_PORT 389
ENV LDAPS_PORT 636
ENV LDAP_HOSTNAME "localhost"
ENV LDAP_KEY_FILE "/etc/openldap/certs/server.key"
ENV LDAP_CERT_FILE "/etc/openldap/certs/server.crt"
ENV LDAP_CERT_SUBJ "/C=BR/ST=Bla State/L=Bla City/O=Bla Company/CN=${LDAP_HOSTNAME}"
# Installing package
RUN apk add --update openldap openldap-back-mdb openldap-overlay-memberof openssl && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    rm -rf /var/cache/apk/*

COPY scripts/* /etc/openldap/

RUN mkdir /etc/openldap/certs

COPY entrypoint.sh /

EXPOSE 389
EXPOSE 636

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
FROM alpine:latest
MAINTAINER Fábio Sartori <fabio@fabiosartori.info>

ENV LDAP_ORGANIZATION "Bla Ltd"
ENV LDAP_SUFFIX "dc=bla,dc=org"
ENV LDAP_ADMIN "cn=admin"
ENV LDAP_ADMIN_PWD "123456"
ENV LDAP_ACCESS_CONTROL "access to * by * read"
ENV LDAP_USERS_BASE_DN "ou=users,dc=bla,dc=org"
ENV LDAP_GROUPS_BASE_DN "ou=groups,dc=bla,dc=org"
ENV LDAP_LOG_LEVEL 256
ENV LDAP_PORT 389
ENV LDAPS_PORT 636

RUN apk add --update openldap openldap-back-mdb && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    rm -rf /var/cache/apk/*

COPY scripts/* /etc/openldap/
COPY entrypoint.sh /
COPY whiletrue.sh /


EXPOSE 389
EXPOSE 636

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
# ENTRYPOINT ["/whiletrue.sh"]
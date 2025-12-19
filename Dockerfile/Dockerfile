# check=skip=FromPlatformFlagConstDisallowed
FROM --platform=linux/amd64 ubuntu:24.04 AS build

RUN apt update
RUN apt upgrade -y
RUN apt install vim git curl wget procps iproute2 inetutils-ping openssl -y
RUN apt install build-essential libltdl-dev libsasl2-dev groff groff-base -y

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV LDAP_VERSION=2.6.10

RUN curl "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${LDAP_VERSION}.tgz" --output /usr/src/openldap-${LDAP_VERSION}.tgz
RUN tar -zxvf /usr/src/openldap-${LDAP_VERSION}.tgz -C /usr/src/

WORKDIR /usr/src/openldap-${LDAP_VERSION}/
RUN ./configure \
    --prefix=/usr/local/openldap \
    --enable-crypt \
    --enable-spasswd \
    --enable-slapd \
    --enable-modules \
    --enable-mdb

RUN make depend
RUN make
RUN make install

RUN ln -s /usr/local/openldap/bin/* /usr/local/bin/
RUN ln -s /usr/local/openldap/sbin/* /usr/local/sbin/
RUN ln -s /usr/local/openldap/libexec/slapd /usr/local/sbin/
RUN ln -s /usr/local/openldap/etc/openldap /etc/

RUN mkdir -p /usr/local/openldap/var/openldap-data
RUN mkdir -p /usr/local/openldap/etc/openldap/slapd.d
RUN adduser --shell /usr/sbin/nologin --no-create-home --disabled-password ldap
RUN chown -R ldap:ldap /usr/local/openldap/var
RUN chown -R ldap:ldap /usr/local/openldap/etc

WORKDIR /usr/local/openldap
COPY --chown=root:root --chmod=700 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 389 636

CMD ["start"]

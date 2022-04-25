FROM tomcat:8.5-jre8-alpine

ENV IPT_VERSION=2.5.7

RUN apk add --no-cache \
    curl \
    unzip \
    && rm -rf /var/cache/apk/*

RUN rm -Rf /usr/local/tomcat/webapps \
    && curl -LSsfo ipt.war https://repository.gbif.org/repository/releases/org/gbif/ipt/${IPT_VERSION}/ipt-${IPT_VERSION}.war \
    && for ipt in tajikistan belarus armenia ukraine; do mkdir -p /usr/local/tomcat/webapps/"$ipt" /srv/datadir-"$ipt" ; unzip -d /usr/local/tomcat/webapps/"$ipt" ipt.war ; done \
    && rm -f ipt.war

VOLUME /srv/datadir-tajikistan
VOLUME /srv/datadir-belarus
VOLUME /srv/datadir-armenia
VOLUME /srv/datadir-ukraine

EXPOSE 8080
CMD ["catalina.sh", "run"]

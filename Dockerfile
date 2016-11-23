FROM debian

ADD http://fhem.de/fhem-5.7.deb /tmp/fhem.deb

RUN set -ex \
 && apt-get update \
 && dpkg -i /tmp/fhem.deb || apt-get install -fy \
 && apt-get install -y libjson-perl

WORKDIR /opt/fhem

EXPOSE 8083 8084 8085 7072
VOLUME ["/data"]

ADD start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]

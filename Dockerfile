FROM debian

ADD http://fhem.de/fhem-5.8.deb /tmp/fhem.deb

RUN set -ex \
 && apt-get update \
 && dpkg -i /tmp/fhem.deb || apt-get install -fy \
 && apt-get install -y libjson-perl libxml-simple-perl psmisc

WORKDIR /opt/fhem

RUN set -ex \
 && perl fhem.pl fhem.cfg \
 && perl fhem.pl 7072 "attr global updateInBackground 0" \
 && perl fhem.pl 7072 update \
 && perl fhem.pl 7072 shutdown

EXPOSE 8083 8084 8085 7072
VOLUME ["/data"]

ADD start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]

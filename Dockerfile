FROM debian

ENV FHEM_BASE_VERSION 5.8

RUN set -ex \
 && apt-get update \
 && apt-get -y install \
      perl-base libdevice-serialport-perl libwww-perl libio-socket-ssl-perl \
      libcgi-pm-perl libjson-perl sqlite3 libdbd-sqlite3-perl libtext-diff-perl \
      libtimedate-perl libmail-imapclient-perl libgd-graph-perl \
      libtext-csv-perl libxml-simple-perl liblist-moreutils-perl ttf-liberation \
      libimage-librsvg-perl libgd-text-perl libsocket6-perl libio-socket-inet6-perl \
      libmime-base64-perl libimage-info-perl libusb-1.0-0-dev libnet-server-perl \
      psmisc curl procps \
 && rm -rf /var/lib/apt/lists/* \
 && curl -sSLfo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
 && chmod +x /usr/local/bin/dumb-init


RUN set -ex \
 && mkdir -p /opt/fhem \
 && curl -sSLf http://fhem.de/fhem-${FHEM_BASE_VERSION}.tar.gz | \
    tar -xzv --strip-components=1 -C /opt/fhem -f -

WORKDIR /opt/fhem

RUN set -ex \
 && perl fhem.pl fhem.cfg \
 && perl fhem.pl 7072 "attr global updateInBackground 0" \
 && perl fhem.pl 7072 update \
 && perl fhem.pl 7072 shutdown \
 && rm -rf log/* \
 && adduser --home /opt/fhem --system --disabled-password fhem

EXPOSE 8083 8084 8085 7072
VOLUME ["/data"]

ADD start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]

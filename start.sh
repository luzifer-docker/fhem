#!/bin/bash

[ -e /data/config.cfg ] || cp /opt/fhem/fhem.cfg /data/config.cfg

function finish {
  pgrep perl | xargs -r kill
}
trap finish EXIT

perl fhem.pl /data/config.cfg

tail -f ./log/*.log

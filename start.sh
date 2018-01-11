#!/bin/bash
set -euo pipefail

function finish {
  pgrep perl | xargs -r kill
}
trap finish EXIT

# Initialize with default config if none is provided
[ -e /data/config.cfg ] || cp /opt/fhem/fhem.cfg /data/config.cfg

# Install custom modules if present
[ -d /data/custom-modules ] && cp /data/custom-modules/* /opt/fhem/contrib/

# Start the fhem daemon
perl fhem.pl /data/config.cfg

# Attach to logs
tail -f ./log/*.log

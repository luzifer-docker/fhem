#!/usr/local/bin/dumb-init /bin/bash
set -euo pipefail

# Initialize with default config if none is provided
[ -e /data/config.cfg ] || cp /opt/fhem/fhem.cfg /data/config.cfg

# Install custom modules if present
[ -d /data/custom-modules ] && cp /data/custom-modules/* /opt/fhem/contrib/

# Ensure fhem can access its own files
chown -R fhem: /opt/fhem

# Start the fhem daemon
perl fhem.pl /data/config.cfg

# Attach to logs
tail -f ./log/*.log

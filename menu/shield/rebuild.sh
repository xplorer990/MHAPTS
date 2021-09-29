#!/bin/bash
#
# [Rebuilding Containers]
#
# GitHub:   https://github.com/PGBlitz/PGBlitz.com
# Author:   Admin9705 - Deiteq
# URL:      https://pgblitz.com
#
# PGBlitz Copyright (C) 2018 PGBlitz.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
docker ps -a --format "{{.Names}}" >/var/plexguide/container.running

sed -i -e "/traefik/d" /var/plexguide/container.running
sed -i -e "/oauth/d" /var/plexguide/container.running
sed -i -e "/watchtower/d" /var/plexguide/container.running
sed -i -e "/wp-*/d" /var/plexguide/container.running
sed -i -e "/plex/d" /var/plexguide/container.running
sed -i -e "/jellyfin/d" /var/plexguide/container.running
sed -i -e "/emby/d" /var/plexguide/container.running
sed -i -e "/x2go*/d" /var/plexguide/container.running
sed -i -e "/authclient/d" /var/plexguide/container.running
sed -i -e "/dockergc/d" /var/plexguide/container.running

count=$(wc -l </var/plexguide/container.running)
((count++))
((count--))

tee <<-EOF
	
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	⚠️  PTS-Shield - Rebuilding Containers!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
EOF
sleep 1.5
for ((i = 1; i < $count + 1; i++)); do
	app=$(sed "${i}q;d" /var/plexguide/container.running)

	tee <<-EOF
		
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		↘️  PTS-Shield - Rebuilding [$app]
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		
	EOF
	echo "$app" >/tmp/program_var
	sleep 1.5

	if [ -e "/opt/coreapps/apps/$app.yml" ]; then ansible-playbook /opt/coreapps/apps/$app.yml; fi
	if [ -e "/opt/communityapps/apps/$app.yml" ]; then ansible-playbook /opt/communityapps/apps/$app.yml; fi
done

echo ""
tee <<-EOF
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	✅️  PTS-Shield - All Containers Rebuilt!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
EOF
read -p 'Continue? | Press [ENTER] ' name </dev/tty

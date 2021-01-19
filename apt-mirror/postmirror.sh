#!/bin/bash


printf "\nRunning Post mirror script...\n"

#Run clean script
[[ -x /srv/mirror/var/clean.sh ]] && printf "\n\e[2G - Running apt-mirror clean script...\n"
[[ -x /srv/mirror/var/clean.sh ]] && /srv/mirror/var/clean.sh
[[ -x /srv/mirror/var/clean.sh ]] && { printf "\napt-mirror mirror script has completed\n" 2>&1; }

wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/meta-release https://changelogs.ubuntu.com/meta-release
wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/meta-release-lts https://changelogs.ubuntu.com/meta-release-lts


printf "\nPost-mirror script has completed\n" 2>&1

#!/bin/bash


printf "\nRunning Post mirror script...\n"

#Run clean script
[[ -x /srv/mirror/var/clean.sh ]] && printf "\n\e[2G - Running apt-mirror clean script...\n"
[[ -x /srv/mirror/var/clean.sh ]] && /srv/mirror/var/clean.sh
[[ -x /srv/mirror/var/clean.sh ]] && { printf "\napt-mirror mirror script has completed\n" 2>&1; }


printf "\nPost-mirror script has completed\n" 2>&1

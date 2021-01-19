#!/bin/bash


printf "\nRunning Post mirror script...\n"

#Run clean script
[[ -x /srv/mirror/var/clean.sh ]] && printf "\n\e[2G - Running apt-mirror clean script...\n"
[[ -x /srv/mirror/var/clean.sh ]] && /srv/mirror/var/clean.sh
[[ -x /srv/mirror/var/clean.sh ]] && { printf "\napt-mirror mirror script has completed\n" 2>&1; }

wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/meta-release https://changelogs.ubuntu.com/meta-release
wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/meta-release-lts https://changelogs.ubuntu.com/meta-release-lts

mkdir -p /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/
mkdir -p /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/xenial-updates/main/dist-upgrader-all/current/
mkdir -p /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/dist-upgrader-all/current/
mkdir -p /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/focal-updates/main/dist-upgrader-all/current/

sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/trusty.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/trusty.tar.gz
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/trusty.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/trusty.tar.gz.gpg
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/xenial-updates/main/dist-upgrader-all/current/xenial.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/xenial.tar.gz
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/xenial-updates/main/dist-upgrader-all/current/xenial.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/trusty-updates/main/dist-upgrader-all/current/xenial.tar.gz.gpg
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/dist-upgrader-all/current/bionic.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/dist-upgrader-all/current/bionic.tar.gz
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/dist-upgrader-all/current/bionic.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/dist-upgrader-all/current/bionic.tar.gz.gpg
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/focal-updates/main/dist-upgrader-all/current/focal.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/focal-updates/main/dist-upgrader-all/current/focal.tar.gz
sudo wget -qO /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists/focal-updates/main/dist-upgrader-all/current/focal.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/focal-updates/main/dist-upgrader-all/current/focal.tar.gz.gpg


printf "\nPost-mirror script has completed\n" 2>&1

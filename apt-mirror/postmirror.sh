#!/bin/bash
export VERSA_DIR='/srv/mirror'
export VERSA_ARCHIVES="${VERSA_DIR}/archives"
export MIRROR_LIST='/etc/apt/mirror.list'
export VERSA_LOCAL="http://ubuntu-archive.orangebox.me/"
declare -ag VERSA_DISTS=(trusty xenial bionic)

printf "\nRunning Post mirror script...\n"

#Run clean script
[[ -x ${VERSA_DIR}/var/clean.sh ]] && printf "\n\e[2G - Running apt-mirror clean script...\n"
[[ -x ${VERSA_DIR}/var/clean.sh ]] && ${VERSA_DIR}/var/clean.sh

#Grab meta-release files
printf "\nFetching https://changelogs.ubuntu.com/meta-release\n"
sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release https://changelogs.ubuntu.com/meta-release ${VERSA_ARCHIVES}/us.archive.ubuntu.com/
printf "\nFetching https://changelogs.ubuntu.com/meta-release-lts\n"
sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release-lts https://changelogs.ubuntu.com/meta-release-lts ${VERSA_ARCHIVES}/us.archive.ubuntu.com/

#Replace original URL with URL of our local mirror
printf "\nEditing ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release\n"
sudo -E sed -i "s|http://.*com/|${VERSA_LOCAL}|g" ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release
printf "\nEditing ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release-lts\n"
sudo -E sed -i "s|http://.*com/|${VERSA_LOCAL}|g" ${VERSA_ARCHIVES}/us.archive.ubuntu.com/meta-release-lts

for DIST in ${VERSA_DISTS[@]};do
    export DIST
    sudo -E mkdir -p ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current
    printf "\nPerforming wget for dist-upgrader files for ${DIST}\n"
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/DevelReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/DevelReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/DevelReleaseAnnouncement.html http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/DevelReleaseAnnouncement.html
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/EOLReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/EOLReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/EOLReleaseAnnouncement.html http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/EOLReleaseAnnouncement.html
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/ReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/ReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/ReleaseAnnouncement.html http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/ReleaseAnnouncement.html
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/${DIST}.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/${DIST}.tar.gz
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/${DIST}.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/${DIST}/main/dist-upgrader-all/current/${DIST}.tar.gz.gpg
    sudo -E mkdir -p ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current
    printf "\nPerforming wget for dist-upgrader files for ${DIST}-updates\n"
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/DevelReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/DevelReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/DevelReleaseAnnouncement.html http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/DevelReleaseAnnouncement.html
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/EOLReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/EOLReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/EOLReleaseAnnouncement.html http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/EOLReleaseAnnouncement.html
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/ReleaseAnnouncement http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/ReleaseAnnouncement
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/${DIST}.tar.gz http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/${DIST}.tar.gz
    sudo -E wget -qO ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/${DIST}.tar.gz.gpg http://us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates/main/dist-upgrader-all/current/${DIST}.tar.gz.gpg
done


printf "\nArchive mirror script has completed\n" 2>&1
exit 0

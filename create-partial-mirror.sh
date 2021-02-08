#!/bin/bash

#VERSA_GIT should match where https://github.com/ThinGuy/v-offline was cloned
export VERSA_GIT="/home/ubuntu/v-offline"
export VERSA_PKG_LISTS=${VERSA_GIT}/package-listings
export VERSA_POOL_LISTS=${VERSA_GIT}/pool-file-listings

#VERSA_DIR should the base for the centralized mirror
export VERSA_DIR='/srv/mirror'
export VERSA_ARCHIVES="${VERSA_DIR}/archives"
declare -ag VERSA_DISTS=(trusty xenial bionic)
export VERSA_PKG_CACHE="/home/ubuntu/versa-local/package-cache"

mkdir -p ${VERSA_PKG_CACHE}
# Copy pool.listing 
for DIST in ${VERSA_DISTS[@]};do
	eval cat ${VERSA_POOL_LISTS}/pool.files.${DIST}.txt|xargs -rn1 -P0 bash -c 'mkdir -p '${VERSA_PKG_CACHE}'/${0%/*};rsync -r --info=progress2 --info=name0 '${VERSA_ARCHIVES}'/us.archive.ubuntu.com/ubuntu/${0} '${VERSA_PKG_CACHE}'/${0}'
done

# Make dists dir then copy the releases specified
mkdir -p ${VERSA_PKG_CACHE}/dists
for DIST in ${VERSA_DISTS[@]};do
	cp -a ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST} ${VERSA_PKG_CACHE}/dists/ 
	cp -a ${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/dists/${DIST}-updates ${VERSA_PKG_CACHE}/dists/ 
done

# Copy meta-release files to base of mirror
cp ${VERSA_DIR}/archives/us.archive.ubuntu.com/meta-release ${VERSA_PKG_CACHE}/
cp ${VERSA_DIR}/archives/us.archive.ubuntu.com/meta-release-lts ${VERSA_PKG_CACHE}/

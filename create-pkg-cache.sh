#!/bin/bash

export VERSA_GIT="/home/ubuntu/v-offline"
export VERSA_PKG_LISTS=${VERSA_GIT}/package-listings
export VERSA_POOL_LISTS=${VERSA_GIT}/pool-file-listings
export VERSA_DIR='/srv/versa'
export VERSA_ARCHIVES="${VERSA_DIR}/archives"
export VERSA_LOCAL="http://ubuntu-archive.orangebox.me/"
declare -ag VERSA_DISTS=(trusty xenial bionic)
export VERSA_PKG_CACHE="/home/ubuntu/versa-local/package-cache"
mkdir -p ${VERSA_PKG_CACHE}

for DIST in ${VERSA_DISTS[@]};do
	eval cat ${VERSA_POOL_LISTS}/pool.files.${DIST}.txt|sed "s|^|${VERSA_ARCHIVES}/us.archive.ubuntu.com/ubuntu/|g"|\
	xargs -rn1 -P0 bash -c 'cp -a $0 '${VERSA_PKG_CACHE}'/${0##*/}'
done

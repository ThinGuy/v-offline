#!/bin/bash
export VERSA_GIT="/home/ubuntu/v-offline"
export VERSA_PKG_LISTS=${VERSA_GIT}/package-listings
export VERSA_POOL_LISTS=${VERSA_GIT}/pool-file-listings
export VERSA_DIR='/srv/versa'
export VERSA_ARCHIVES="${VERSA_DIR}/archives"
declare -ag VERSA_DISTS=(trusty xenial bionic)
export VERSA_PKG_CACHE="/home/ubuntu/versa-local/package-cache"
mkdir -p ${VERSA_PKG_CACHE}
#eval cat ${VERSA_POOL_LISTS}/pool.files.${DIST}.txt|xargs -rn1 -P0 bash -c 'echo ${0%%*/};echo rsync -r --info=progress2 --info=name0 '${VERSA_ARCHIVES}'/us.archive.ubuntu.com/ubuntu/${0} '${VERSA_PKG_CACHE}'/${0}'
for DIST in ${VERSA_DISTS[@]};do
	eval cat ${VERSA_POOL_LISTS}/pool.files.${DIST}.txt|xargs -rn1 -P0 bash -c 'mkdir -p '${VERSA_PKG_CACHE}'/${0%/*};rsync -r --info=progress2 --info=name0 '${VERSA_ARCHIVES}'/us.archive.ubuntu.com/ubuntu/${0} '${VERSA_PKG_CACHE}'/${0}'
done

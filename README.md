
# V-offline
Offline Upgrade Files for V

## Clone this repository on machine that will serve as the centralized mirror
cd ~/ && git clone https://github.com/ThinGuy/v-offline.git

### Install apt-mirror
sudo apt install apt-mirror
Note: If Ubuntu greater than 18.04, you need to grab a patched apt-mirror from https://github.com/josbraden/apt-mirror

mkdir -p /srv/mirror/{bin,etc}
sudo chown -R $USER:USER /srv/mirror
cp -a ~/v-offiline/apt-mirror/postmirror.sh /srv/mirror/bin/
cp -a ~/v-offiline/apt-mirror/mirror.list /srv/mirror/etc
sudo ln -sf /srv/mirror/etc/mirror.list /etc/apt/mirror.list

#### Starting with Trusty,Create a package listing then proceed to run:
See below to create a package listing
See below to create a pool file (This gives the location of the actual file in the pool directory)
sudo do-release-upgrade -f DistUpgradeViewNonInteractive
Reboot then repeat for each LTS you step through

#### Create a package listing per LTS
apt list --installed 2>/dev/null|awk -F/ '!/^Listing/{print $1}'|tee ~/pkg.list.$(lsb_release -cs).txt

#### Create a pool file
declare -ag PKGS=($(cat ~/pkg.list.$(lsb_release -cs).txt))
for i in ${PKGS[@]};do apt-cache show ${i}|grep -m1 -E '^Filename:'|sed 's/^Filename: //g'; done|tee ~/pool.files.$(lsb_release -cs).txt

###### Create partial mirror
mkdir /var/tmp/mirror/ubuntu
Copy /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/dists to /var/tmp/mirror/ubuntu/
Using each pool file (should have at least three), copy files from /srv/mirror/archives/us.archive.ubuntu.com/ubuntu/<path to entry> to /var/tmp/mirror/ubuntu/
Copy /var/tmp/mirror to a portable drive or to remote host.  This will be the basis of your file-based repo

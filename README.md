
# V**** offline Upgrade 
Offline Upgrade Files for V****

## 1) Clone this repository on machine that will serve as the centralized mirror
```
cd ~/ && git clone https://github.com/ThinGuy/v-offline.git
```

## 2) Install apt-mirror
```
sudo apt install apt-mirror
```

Note: If Ubuntu greater than 18.04, you need to grab a patched apt-mirror from https://github.com/josbraden/apt-mirror

```
mkdir -p /srv/mirror/{bin,etc}
```

```
sudo chown -R $USER:USER /srv/mirror
```

```
cp -a ~/v-offiline/apt-mirror/postmirror.sh /srv/mirror/bin/
```

```
cp -a ~/v-offiline/apt-mirror/mirror.list /srv/mirror/etc
```

```
sudo ln -sf /srv/mirror/etc/mirror.list /etc/apt/mirror.list
```

## 3) Starting with Trusty,Create a package listing then proceed to run:

### Create a package listing
```
apt list --installed 2>/dev/null|awk -F/ '!/^Listing/{print $1}'|tee ~/pkg.list.$(lsb_release -cs).txt
```
### Create a pool file from package listing
```
declare -ag PKGS=($(cat ~/pkg.list.$(lsb_release -cs).txt))
```

```
for i in ${PKGS[@]};do apt-cache show ${i}|grep -m1 -E '^Filename:'|sed 's/^Filename: //g'; done|tee ~/pool.files.$(lsb_release -cs).txt
```

### Step through LTS upgrades
```
sudo do-release-upgrade -f DistUpgradeViewNonInteractive
```

Reboot then repeat for each LTS you step through

## 4) Create partial mirror
Run the create-partial-mirror.sh script
  
## 5) From appliance
You should only have to do this on the first upgrade (Trusty)

Note: The following assumes you copied the partial mirror files to /package-cache on the appliance

### Edit /etc/apt/sources/list

Note: Currently all lines in /etc/apt/sources.list are commented out on sample appliance

```
deb [arch=amd64] file:///package-cache/ trusty main universe
deb [arch=amd64] file:///package-cache/ trusty-updates main universe
```

### Edit /etc/update-manager/meta-release

Change location of both URI and URI_LTS from:

```
URI = https://changelogs.ubuntu.com/meta-release to URI = file:///package-cache/meta-release

URI_LTS = https://changelogs.ubuntu.com/meta-release-lts to URI_LTS = file:///package-cache/meta-release-lts
```
### Run the upgrade
Starting with Trusty, run:

```
sudo do-release-upgrade -f DistUpgradeViewNonInteractive 
```

Reboot when finished, you should now be on Xenial (16.04).  Login and run:

```
sudo do-release-upgrade -f DistUpgradeViewNonInteractive
```

Reboot when finished, appliance should now be running Bionic (18.04)

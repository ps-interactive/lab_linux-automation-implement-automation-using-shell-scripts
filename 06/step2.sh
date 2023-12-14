#!/bin/bash
source /etc/os-release
echo "This is a $ID System"
valid_packages=""

if [ "$#" -lt 1 ]; then
  echo "At least one package name is required."
  exit 1
fi

for package_name in "$@" ; do
  if apt-cache search "^$package_name$" | grep -q "$package_name"; then
    valid_packages+="$package_name "
  else
    echo "The package $package_name is not available."
    continue
  fi

  if [ "$ID" = 'ubuntu' ] ; then
    pkgcache_file="/var/cache/apt/pkgcache.bin"
    current_time=$(date +%s)
    updated_time=$(stat -c%Y "$pkgcache_file")
    time_diff=$((current_time - updated_time))
    #The threshold is set to one day or 86400 seconds
    threshold=86400
    if [ "$time_diff" -le "$threshold" ]; then
       echo "Package cache has been updated in the last 24 hours."
       echo "Running the command sudo apt install -y $package_name"
    else
       echo "Package cache has not been updated in the last 24 hours."
       echo "Running the command sudo apt update"
       echo "Running the command sudo apt install -y $package_name"
    fi
  fi
done
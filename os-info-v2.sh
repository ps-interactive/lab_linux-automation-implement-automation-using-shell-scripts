#!/bin/bash
source /etc/os-release
echo "This is a $ID System"
if [ "$ID" = 'ubuntu' ] ; then
  pkgcache_file="/var/cache/apt/pkgcache.bin"
  current_time=$(date +%s)
  updated_time=$(stat -c%Y "$pkgcache_file")
  time_diff=$((current_time - updated_time))
  #The threshold is set to one day or 86400 seconds
  threshold=86400
  if [ "$time_diff" -le "$threshold" ]; then
     echo "Package cache has been updated in the last 24 hours."
  else
     echo "Package cache has not been updated in the last 24 hours."
  fi
fi

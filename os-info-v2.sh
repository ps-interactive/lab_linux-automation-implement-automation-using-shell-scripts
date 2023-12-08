#!/bin/bash
source /etc/os-release
echo "This is a $ID System"

#Test the ID variable to determine the OS
if [ "$ID" = 'ubuntu' ] ; then
  pkgcache_file="/var/cache/apt/pkgcache.bin"
  # Returns the time as seconds after the Linux Epoch 1/1/1970
  current_time=$(date +%s)
  # Returns the last update time in number of seconds after the Epoch
  updated_time=$(stat -c%Y "$pkgcache_file")
  # The time_diff shows the number of seconds since the last update
  time_diff=$((current_time - updated_time))
  # The threshold is set to one day or 86400 seconds
  threshold=86400
  # If the time)diff is less than a day (86400s) then it is up to date, else it is not up to date
  if [ "$time_diff" -le "$threshold" ]; then
     echo "Package cache has been updated in the last 24 hours."
  else
     echo "Package cache has not been updated in the last 24 hours."
  fi
fi

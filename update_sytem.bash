#!/bin/bash
# Script to update and upgrade system
# Usage: script can be manually trigered or set up at a certain time using crontab
# $? = saves last executed command output
# ne = not equal

echo -e "\n\n**********************************\n\n"
echo "Starting System Udate..."

# Update available package list
sudo apt-get update | tee -a system_update.log

# error handling, notifies user and exits script
if [ $? -ne 0 ]; then
	echo -e "\nError updating package list. Exiting script"
	exit 1
fi

# Upgrade installed packages
sudo apt-get upgrade -y | tee -a system_update.log

# error handling, notifies user and exits script
if [ $? -ne 0  ]; then
	echo -e "\nError upgrading package list. Exiting script"
	exit 1
fi

# Clean obsolete and temp files
sudo apt autoremove -y | tee -a system_update.log

# error handling, notifies user and exits script
if [ $? -ne 0 ]; then
	echo -e "\nError removing obsolete/temp files. Exiting script"
	exit 1
fi

# Confirm if a reboot is necessary if /var/run/reboot-required exists
if [ -f /var/run/reboot-required ]; then
	echo -e "\nA reboot is required"| tee -a system_update.log
fi

echo -e "\nSystem successfully updated"

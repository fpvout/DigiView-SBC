#!/bin/bash
# Purpose - Script to add a user to Linux system including passsword
# Author - Vivek Gite <www.cyberciti.biz> under GPL v2.0+
# ------------------------------------------------------------------
# Am i Root user?
if [ $(id -u) -eq 0 ]; then
	username=fpvout
	password=fpvout
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p "$pass" "$username"
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system."
	exit 2
fi

# add the fpvout user to all the groups
usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio fpvout

# edit sudoers to so fpvout does not need a password for sudo
sh -c "echo 'fpvout ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

# add the openbox directory and the autostart file
mkdir /home/fpvout/.config/
mkdir /home/fpvout/.config/openbox
mv autostart /home/fpvout/.config/openbox/autostart
chmod +x /home/.config/openbox/autostart

# set up X to autostart
touch /home/fpvout/.bash_profile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor' >> home/fpvout/.bash_profile

exit 0

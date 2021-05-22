#!/bin/bash

# make the hello_video script executable
chmod +x hello_video.sh

# run the new user script
chmod +x newuser.sh
./newuser.sh

# First, we make sure the system is up to date:
apt-get update

# Then we install the dependencies:
apt-get install -y -q git lightdm libusb-1.0 openbox obconf chromium python3 menu obmenu conky parcellite feh rox-filer \
tint2 xfce4-panel libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools \
gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-pulseaudio

# Now we set up the UDEV Rules
touch "/etc/udev/rules.d/5-FPVGoggle.rules"
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2ca3", MODE="0666"' >> \
/etc/udev/rules.d/5-FPVGoggle.rules
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2ca3", ACTION=="add", TAG+="systemd", \
ENV{SYSTEMD_WANTS}+="GoggleConnect.service"' >> /etc/udev/rules.d/5-FPVGoggle.rules

# Next we will move the GoggleConnect service to the system servies folder
# and make it executable, then we reload the services
mv GoggleConnect.service /etc/systemd/system/GoggleConnect.service
chmod 664 /etc/systemd/system/GoggleConnect.service
systemctl daemon-reload

# Now we move the fpvout-start.sh script to the Scripts Folder
# and make it executable.
mkdir /home/fpvout/Scripts
python mactest.py
chmod +x /home/fpvout/Scripts/fpvout-start.sh

# Then we clone fpv-c to the Scripts directory of the new fpvout user
cd /home/fpvout/Scripts
git clone https://github.com/fpvout/fpv-c.git
cd fpv-c
make

# set up environmental variable for openbox
echo 'export KIOSK_URL=/var/www/html/index.html' >> /etc/xdg/openbox/environment

exit 0

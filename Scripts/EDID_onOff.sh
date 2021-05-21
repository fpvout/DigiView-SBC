#!/bin/bash
# Turn EDID on or off

configFile=/boot/config.txt
string=#hdmi_ignore_edid=0xa5000080

# check whether line is already commented
if grep -iq '#hdmi_ignore_edid=0xa5000080' /boot/config.txt
   then
      # uncomment hdmi_ignore line
      sed -i '/hdmi_ignore/s/^#//g' $configFile
      echo "uncommented"
   else
       # comment the line
      sed -i '/hdmi_ignore/ s/^#*/#/g' $configFile
      echo "commented"
fi

systemctl reboot

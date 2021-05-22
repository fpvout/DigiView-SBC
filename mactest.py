# Python script for setting up Gstreamer on Linux based SBCs
# Written for DigiView by lavachemist

import os
import shutil
import subprocess

# first we find the Mac Address and get the first 8 characters (OUI including colons)
with open("/sys/class/net/eth0/address") as mac:
   oui = mac.read(8)
print(oui)

# then we compare the oui to our list of MACs

if oui == "dc:a6:32" or oui == "B8:27:EB":
   print("This is a Raspberry Pi")
   shutil.move('Pi/fpvout-start.sh', '/home/fpvout/Scripts/fpvout-start.sh')
   subprocess.call("/home/pi/DigiView-SBC/hello_video.sh") # install modified hello_video
elif oui == "48:b0:2d":
   print("This is an Nvidia Jetson")
   shutil.move('Jetson/fpvout-start.sh', '/home/fpvout/Scripts/fpvout-start.sh')
else:
   print("This is a generic SBC")
   shutil.move('Generic/fpvout-start.sh', '/home/fpvout/Scripts/fpvout-start.sh')

exit() 

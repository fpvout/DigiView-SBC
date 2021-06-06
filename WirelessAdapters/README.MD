## How to Install WLAN Drivers

```# Get the driver installer and move it to /usr/bin/install-wifi
sudo wget http://www.fars-robotics.net/install-wifi -O /usr/bin/install-wifi

# Make the installer executable
sudo chmod +x /usr/bin/install-wifi

# Read the help file
sudo install-wifi -h

# Connect your WLAN adapter and run the installer script, it should identify your adapter and install the drivers
sudo install-wifi```

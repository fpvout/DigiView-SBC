![Any Screen, Any Time.](docs/digiview.png)

# DigiView SBC

DigiView SBC is a linux image that allow you to get a Live preview from your DJI FPV goggles (V1 & V2) on a single board computer.

This is currently an alpha release with minimal features for the Raspberry Pi. It runs on Pi 2B or better, and can also be modified to run on Pi Zero (expect significant latency on the Pi Zero).

## Download
You can download the **Alpha** Release [here](https://github.com/fpvout/DigiView-SBC/releases/latest)

## Instructions
To get the best results :
- Power on our Raspberry Pi and wait for it to boot fully.
- You must have a monitor of some kind connected to the SBC before booting the Pi.
- Power on your googles.
- Power your drone.
- Wait for the link to be established.
- Plug the USB cable into a USB port your Raspberry Pi.
- Streaming is triggered when the Goggles are connected to the Pi via USB, so you should see video shortly after plugging in.
- If video latency is poor or image quality is bad, try replugging the USB.
- It is strongly recommended that you plug/unplug the Pi end of the cable: you would rather wear out the connector on the Pi than your goggles!

## Pi Zero Instructions
In order for the Pi Zero to boot, you must change the amount of RAM dedicated to the GPU:
- Connect the SD card to your PC.

In the Boot partition, open config.txt and change this:

``` gpu_mem=512 ```

To this:

``` gpu_mem=384 ```


## Advanced User Instructions
- If you want to log into the pi, you can connect a mouse and keyboard. Right-click on the desktop and open the terminal emulator.
- The default username is fpvout. The default password is fpvout.
- The pi user is not being used, but does exist. It's password is also fpvout.
- SSH is enabled by default, but you will need to add a wpa supplicant file to the boot partition to connect to Wi-Fi.
- There is no desktop environment on the image - this is intended to turn your SBC into an appliance that requires no user input for normal operation.

If there is any issue, please check on our [Discord server](https://discord.gg/uGYMNByeTH), some people might help you there. You can also consult the [DigiView Wiki.](https://github.com/fpvout/fpvout.com/wiki)

## Known Issues
- Do not plug into the Pi until after video is showing in your goggles.
- If you need to power cycle the air unit, you may need to replug the USB cable in order to re-establish the stream.
- **You might need to set Autotemp off on your Vista/Air unit to get it to work**.
- It may work best in 50mbps mode.

## Development
We will add more info here later, but broad strokes are:
- The Pi image is based on Raspbian Lite.
- The core components that make DigiView SBC are fpv-c, Gstreamer and Hello_Video (Pi version only).
- Auto-start on USB is accomplished via a UDEV rule that triggers the GoggleConnect service, which starts a bash script that initiates the stream.
- A tutorial for building your own version from scratch is planned for a future date.
- Jetson Nano 2gb, and RockPi 4 images are also in development.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Credits
- [lavachemist](https://github.com/lavachemist) - Digiview SBC Images
- [Frank Petrilli](https://github.com/FrankPetrilli) - fpv-c
- [Sergey Serov aka Gol](http://cosmostreamer.com/) - Video Decoder
- [Joonas](https://fpv.wtf/) - Found the secret packet - [Donate](https://www.buymeacoffee.com/fpv.wtf)
- [D3VL](https://d3vl.com) - Who is orchestrating all that stuff - [Donate](https://www.buymeacoffee.com/d3vl)

Please make sure to check theses guys out ! And feel free to donate ;)

## License
[GPL 3.0](https://choosealicense.com/licenses/gpl-3.0/mit/)

“Raspberry Pi is a trademark of the Raspberry Pi Foundation”.

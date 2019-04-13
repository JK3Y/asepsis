## Asepsis == solution for .DS_Store pollution.

This is a fork of [Asepsis](http://www.github.com/binaryage/asepsis). Since this is the best tool for preventing .DS_Store creation, when the original project no longer worked on High Sierra, I took it upon myself to make it compatible with newer macOS versions.

This has been tested and is working on macOS 10.13/10.14

### WARNING: This fork of Asepsis is not maintained by BinaryAge. Use at your own risk.

#### For end-user info please visit [http://asepsis.binaryage.com](http://asepsis.binaryage.com)

## Installation from sources
#### Requirements
- XCode 10
- Make sure [SIP is disabled.](https://totalfinder.binaryage.com/sip)

To build and install, run this command from the Terminal while inside the Asepsis folder:

	rake build
	rake install
Reboot your computer to complete installation.

## Uninstallation

    asepsisctl uninstall
Reboot your computer to finish uninstallation.

#### License: [MIT-Style](license.txt)

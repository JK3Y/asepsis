## Asepsis == solution for .DS_Store pollution.

### Compatible with macOS Mojave!
### WARNING: This fork of Asepsis is not maintained by BinaryAge. Use at your own risk.

#### For end-user info and versions compatible with macOS < 10.13 please visit [http://asepsis.binaryage.com](http://asepsis.binaryage.com)

### Installation from sources

You will need Xcode 8 for building it from sources:

    git clone https://github.com/JK3Y/asepsis.git
    cd asepsis
    rake build
    rake install
    sudo reboot

Note: for installing debug version which is more verbose in Console.app use `rake build_debug` instead of `rake build`. Also you may then run `rake debug_test` to check if asepsis works as expected.

Note: before `rake build` you might need to `open Asepsis.xcodeproj` once in Xcode. For some reason the xcodebuild hangs without that.

### Uninstallation

    asepsisctl uninstall

#### License: [MIT-Style](license.txt)

## Asepsis == solution for .DS_Store pollution.

### Compatible with macOS Mojave!
### WARNING: This fork of Asepsis is not maintained by BinaryAge. Use at your own risk.

#### For end-user info and versions compatible with macOS < 10.13 please visit [http://asepsis.binaryage.com](http://asepsis.binaryage.com)



### Installation from sources
Run this command to allow installer to ignore system version checks:
```bash
$ touch ~/.no-asepsis-os-restriction
```
    
You will need Xcode 8 for building it from sources:
```bash
$ git clone --recursive https://github.com/JK3Y/asepsis.git
$ cd asepsis/
$ gem install colored
$ rake build
$ rake install
$ sudo reboot
```

Note: for installing debug version which is more verbose in Console.app use `rake build_debug` instead of `rake build`. Also you may then run `rake debug_test` to check if asepsis works as expected.

Note: before `rake build` you might need to `open Asepsis.xcodeproj` once in Xcode. For some reason the xcodebuild hangs without that.


### Removing existing .DS_Store
```bash
$ find ~ -name ".DS_Store" -delete
```

### Uninstallation

    $ asepsisctl uninstall

#### License: [MIT-Style](license.txt)

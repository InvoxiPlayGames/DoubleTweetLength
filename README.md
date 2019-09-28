
# DoubleTweetLength

### An iOS MobileSubstrate tweak to let you tweet (and see) 280 character tweets on older versions of Twitter.

Tested and confirmed working on Twitter 5.12, 6.13.6 and Twitter 6.71.1 -- though it should be working on all versions of Twitter that don't have 280 character support. If it doesn't work on a certain version, start an issue!

## Pre-Compiled

Downloading a pre-compiled build of DoubleTweetLength can be done in multiple ways.
- **(Recommended)** Install the latest release from my Cydia repo at https://cydia.invoxiplaygames.uk/
- Install the latest beta package from my Cydia repo at https://cydia.invoxiplaygames.uk/beta (this may be an experimental build)
- Download the latest release DEB from the releases/tags page.

## Compiling
1. Set up a Theos environment.
- If you don't already have that, read [this guide](https://github.com/theos/theos/wiki/Installation) to get started - compatible with Windows 10, macOS, Linux and iOS
2. Edit the Makefile to your setup
- Make sure you change SDKVERSION and SDKVERSION_armv6 to the SDKs you have installed (the one provided uses the iOS 8.1 SDK in the default $THEOS folder, and iOS 5.0 for armv6 compiling. Remove armv6 from ARCHS if your compiler/linker complains.)
3. Run `make package` (or `make package install` if you have set THEOS_DEVICE_IP to your device's SSH IP)
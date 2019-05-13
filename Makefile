SDKVERSION = 10.0
SYSROOT = $(THEOS)/sdks/iPhoneOS10.0.sdk
TARGET=iphone::10.0:5.0
ARCHS=armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DoubleTweetLength
DoubleTweetLength_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Twitter"

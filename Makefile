SDKVERSION = 8.1
SDKVERSION_armv6=5.0
ARCHS=armv6 armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DoubleTweetLength
DoubleTweetLength_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Twitter"

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Freemote

Freemote_FILES = Tweak.xm $(wildcard *.m)
Freemote_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tabsa
Tabsa_FILES = Tweak.xm

ARCHS = arm64

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += Tabsa
include $(THEOS_MAKE_PATH)/aggregate.mk

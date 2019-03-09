include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Tabsa
Tabsa_FILES = TBSRootListController.m
Tabsa_INSTALL_PATH = /Library/PreferenceBundles
Tabsa_FRAMEWORKS = UIKit
Tabsa_PRIVATE_FRAMEWORKS = Preferences
Tabsa_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

ARCHS = arm64

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Tabsa.plist$(ECHO_END)

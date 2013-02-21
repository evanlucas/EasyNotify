ARCHS=armv7
export TARGET=iphone::5.0
export GO_EASY_ON_ME=1
include theos/makefiles/common.mk

LIBRARY_NAME = libeasynotify
libeasynotify_FILES = easynotify.xm
libeasynotify_FRAMEWORKS = UIKit CoreGraphics Foundation
libeasynotify_PRIVATEFRAMEWORKS = BulletinBoard
libeasynotify_LOGOSFLAGS = -c generator=internal
libeasynotify_CFLAGS = -I.
libeasynotify_LDFLAGS = -current_version $($(THEOS_CURRENT_INSTANCE)_LIBRARY_VERSION)
libeasynotify_LIBRARY_VERSION = $(shell echo "$(THEOS_PACKAGE_BASE_VERSION)" | cut -d'~' -f1)

TWEAK_NAME = EasyNotify
EasyNotify_FILES = Tweak.xm
EasyNotify_FRAMEWORKS = UIKit CoreGraphics Foundation
EasyNotify_PRIVATEFRAMEWORKS = BulletinBoard
EasyNotify_LIBRARIES = easynotify
EasyNotify_CFLAGS = -I.
EasyNotify_LDFLAGS = -L$(THEOS_OBJ_DIR)

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-libeasynotify-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/usr/include/libeasynotify$(ECHO_END)
	$(ECHO_NOTHING)cp libeasynotify.h $(THEOS_STAGING_DIR)/usr/include/libeasynotify/libeasynotify.h$(ECHO_END)



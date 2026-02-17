################################################################################
#
# REG Rescue System
#
################################################################################

RESCUE_SYSTEM_SOURCE=

RESCUE_SYSTEM_VERSION = 1.0
RESCUE_SYSTEM_DATE_TIME = $(shell date "+%Y/%m/%d %H:%M")
RESCUE_SYSTEM_DATE = $(shell date "+%Y/%m/%d")
RESCUE_SYSTEM_DEPENDENCIES =

ifeq ($(BR2_PACKAGE_RESCUE_TARGET_AARCH64),y)
	RESCUE_SYSTEM_ARCH=aarch64
else ifeq ($(BR2_PACKAGE_RESCUE_TARGET_ARMV7),y)
	RESCUE_SYSTEM_ARCH=armv7
else ifeq ($(BR2_PACKAGE_RESCUE_TARGET_ARMHF),y)
	RESCUE_SYSTEM_ARCH=armhf
else ifeq ($(BR2_PACKAGE_RESCUE_TARGET_RISCV64),y)
	RESCUE_SYSTEM_ARCH=riscv
else ifeq ($(BR2_PACKAGE_RESCUE_TARGET_X86_64),y)
	RESCUE_SYSTEM_ARCH=x86_64
else
	RESCUE_SYSTEM_ARCH=unknown
endif

ifneq (,$(findstring dev,$(RESCUE_SYSTEM_VERSION)))
    RESCUE_SYSTEM_COMMIT = "-$(shell cd $(BR2_EXTERNAL_RESCUE_PATH) && git rev-parse --short HEAD)"
else
    RESCUE_SYSTEM_COMMIT =
endif

define RESCUE_SYSTEM_INSTALL_TARGET_CMDS

	# version/arch
	mkdir -p $(TARGET_DIR)/usr/share/reglinux
	echo -n "$(RESCUE_SYSTEM_ARCH)" > $(TARGET_DIR)/usr/share/reglinux/system.arch
	echo $(RESCUE_SYSTEM_VERSION)$(RESCUE_SYSTEM_COMMIT) $(RESCUE_SYSTEM_DATE_TIME) > $(TARGET_DIR)/usr/share/reglinux/system.version

	# variables
	mkdir -p $(TARGET_DIR)/etc/profile.d
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_RESCUE_PATH)/package/core/rescue-system/xdg.sh $(TARGET_DIR)/etc/profile.d/xdg.sh
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_RESCUE_PATH)/package/core/rescue-system/dbus.sh $(TARGET_DIR)/etc/profile.d/dbus.sh

    # Other scripts needed
    $(INSTALL) -D -m 0755 $(BR2_EXTERNAL_RESCUE_PATH)/package/core/rescue-system/system-mount $(TARGET_DIR)/usr/bin/
    $(INSTALL) -D -m 0755 $(BR2_EXTERNAL_RESCUE_PATH)/package/core/rescue-system/system-part $(TARGET_DIR)/usr/bin/
    $(INSTALL) -D -m 0755 $(BR2_EXTERNAL_RESCUE_PATH)/package/core/rescue-system/system-usbmount $(TARGET_DIR)/usr/bin/

endef

$(eval $(generic-package))

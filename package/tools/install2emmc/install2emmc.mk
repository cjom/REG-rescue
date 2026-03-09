#############################################################
#
# install2emmc
#
#############################################################

INSTALL2EMMC_VERSION = 0.1
INSTALL2EMMC_SOURCE =
INSTALL2EMMC_PATH = $(BR2_EXTERNAL_RESCUE_PATH)/package/tools/install2emmc/src

define INSTALL2EMMC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin/
	install -m 0755 $(INSTALL2EMMC_PATH)/install2emmc $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))

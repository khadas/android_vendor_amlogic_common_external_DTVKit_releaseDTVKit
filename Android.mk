LOCAL_PATH := $(call my-dir)
TA_UUID := 1987f328-1755-9321-5441-43494343544c
TA_SUFFIX := .ta
DTVKIT_BUILD_FOR_AML_TEE ?= 0

ifeq ($(PLATFORM_TDK_VERSION), 24)
PLATFORM_TDK_PATH := $(BOARD_AML_VENDOR_PATH)/tdk
LOCAL_TA := ta/v2.4/$(TA_UUID)$(TA_SUFFIX)
endif

ifeq ($(TARGET_ENABLE_TA_ENCRYPT), true)
ENCRYPT := 1
else
ENCRYPT := 0
endif

ifeq (,$(wildcard $(LOCAL_PATH)/../DVBCore))
include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false
LOCAL_VENDOR_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := \
    android.hidl.allocator@1.0 \
    libam_adp \
    libam_mw \
    libamdvr \
    libbase \
    libbinder \
    libc++ \
    libc \
    libcrypto \
    libcurl \
    libcutils \
    libdl \
    libft2-aml \
    libhidlbase \
    libhidlmemory \
    libhidltransport \
    libjpeg \
    liblog \
    libm \
    libmediahal_resman \
    libmediahal_tsplayer \
    libmediandk \
    libsqlite \
    libssl \
    libutils \
    vendor.amlogic.hardware.dtvkitserver@1.0 \
    libaml_mp_sdk.vendor \
    libutilscallstack \
    libteec \
    libsecmem

LOCAL_MODULE := dtvkitserver

ifeq ($(DTVKIT_BUILD_FOR_AML_TEE), 1)
LOCAL_SRC_FILES := tee-server/dtvkitserver
else
LOCAL_SRC_FILES := dtvkitserver
endif

LOCAL_INIT_RC := dtvkitserver.rc
LOCAL_VINTF_FRAGMENTS := vendor.amlogic.hardware.dtvkitserver@1.0.xml
LOCAL_MODULE_RELATIVE_PATH := hw
include $(BUILD_PREBUILT)

ifeq ($(PLATFORM_TDK_VERSION), 24)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(LOCAL_TA)
LOCAL_MODULE := $(TA_UUID)
LOCAL_MODULE_SUFFIX := $(TA_SUFFIX)
LOCAL_STRIP_MODULE := false
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/teetz
ifeq ($(TARGET_ENABLE_TA_SIGN), true)
LOCAL_POST_INSTALL_CMD = $(PLATFORM_TDK_PATH)/ta_export/scripts/sign_ta_auto.py \
		--in=$(shell pwd)/$(LOCAL_MODULE_PATH)/$(TA_UUID)$(LOCAL_MODULE_SUFFIX) \
		--keydir=$(shell pwd)/$(BOARD_AML_TDK_KEY_PATH) \
		--encrypt=$(ENCRYPT)
endif
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := tee_ciplus_ta
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_REQUIRED_MODULES := $(TA_UUID)
include $(BUILD_PHONY_PACKAGE)
endif

endif

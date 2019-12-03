LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_SUFFIX :=.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false
LOCAL_PRODUCT_MODULE := true
LOCAL_SHARED_LIBRARIES := libEGL libGLESv2 libandroid libbinder libcurl libft2 libgui libjpeg liblog libsqlite libssl libutils
#directory
DVBCORE_DIRECTORY := $(LOCAL_PATH)/../DVBCore/
HAVE_DVBCORE_DIRECTORY := $(shell test -d $(DVBCORE_DIRECTORY) && echo yes)
ifeq ($(HAVE_DVBCORE_DIRECTORY),yes)
$(warning "DVBCore directory exist")
LOCAL_MODULE := libinvaildDTVKit
LOCAL_SRC_FILES := libinvaildDTVKit.so
else
LOCAL_MODULE := libdtvkitserver
LOCAL_SRC_FILES := libdtvkitserver.so
endif
include $(BUILD_PREBUILT)

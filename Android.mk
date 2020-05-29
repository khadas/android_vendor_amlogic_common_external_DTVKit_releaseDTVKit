LOCAL_PATH := $(call my-dir)
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
    vendor.amlogic.hardware.dtvkitserver@1.0

LOCAL_MODULE := dtvkitserver
LOCAL_SRC_FILES := dtvkitserver
LOCAL_INIT_RC := dtvkitserver.rc
LOCAL_VINTF_FRAGMENTS := vendor.amlogic.hardware.dtvkitserver@1.0.xml
LOCAL_MODULE_RELATIVE_PATH := hw
include $(BUILD_PREBUILT)
endif

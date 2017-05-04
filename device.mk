#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 560dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

PRODUCT_HARDWARE := taimen

# DEVICE_PACKAGE_OVERLAYS for the device should be before
# including common overlays since the one listed first
# takes precedence.
ifdef DEVICE_PACKAGE_OVERLAYS
$(warning Overlays defined in '$(DEVICE_PACKAGE_OVERLAYS)' will override '$(PRODUCT_HARDWARE)' overlays)
endif
DEVICE_PACKAGE_OVERLAYS += device/google/taimen/overlay

include device/google/wahoo/device.mk

PRODUCT_COPY_FILES += \
    device/google/taimen/init-taimen.rc:system/etc/init/init-taimen.rc \
    device/google/taimen/init.taimen.usb.rc:root/init.taimen.usb.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=560 \

# Kernel Modules Config
PRODUCT_COPY_FILES += \
    device/google/taimen/init.insmod.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.cfg

# Kernel modules
PRODUCT_COPY_FILES += \
    device/google/wahoo-kernel/touch_core_base.ko:$(TARGET_COPY_OUT_VENDOR)/lib/modules/touch_core_base.ko \
    device/google/wahoo-kernel/ftm4.ko:$(TARGET_COPY_OUT_VENDOR)/lib/modules/ftm4.ko \
    device/google/wahoo-kernel/sw49408.ko:$(TARGET_COPY_OUT_VENDOR)/lib/modules/sw49408.ko

# Logging
PRODUCT_COPY_FILES += \
    device/google/taimen/init.logging.rc:root/init.$(PRODUCT_HARDWARE).logging.rc


PRODUCT_COPY_FILES += \
    device/google/taimen/nfc/libnfc-nxp.taimen.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# TODO: move this to wahoo.
PRODUCT_COPY_FILES += \
    device/google/taimen/fstab.hardware:root/fstab.$(PRODUCT_HARDWARE)

PRODUCT_COPY_FILES += \
    device/google/taimen/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf \
    device/google/taimen/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-vr.conf

# Audio
PRODUCT_COPY_FILES += \
    device/google/taimen/mixer_paths_tavil.xml:system/etc/mixer_paths_tavil_taimen.xml \
    device/google/taimen/audio_platform_info_tavil.xml:system/etc/audio_platform_info_tavil_taimen.xml

# verity
AB_OTA_PARTITIONS += \
    vbmeta


#
# Copyright (C) 2017 The Android Open-Source Project
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

TARGET_BOOTLOADER_BOARD_NAME := taimen
DEFAULT_LOW_PERSISTENCE_MODE_BRIGHTNESS := 0x0000008c

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200,n8 earlycon=msm_serial_dm,0xc1b0000

include device/google/wahoo/BoardConfig.mk

BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
BOARD_AVB_ENABLE := true
BOARD_EXT4_SHARE_DUP_BLOCKS := true

# sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += device/google/taimen/sepolicy

# Kernel modules
ifeq (,$(filter-out taimen_kasan, $(TARGET_PRODUCT)))
# if TARGET_PRODUCT == taimen_kasan
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/kasan/touch_core_base.ko \
    device/google/wahoo-kernel/kasan/ftm4.ko \
    device/google/wahoo-kernel/kasan/sw49408.ko \
    device/google/wahoo-kernel/kasan/lge_battery.ko \
    device/google/wahoo-kernel/kasan/wlan.ko
else ifeq (,$(filter-out taimen_kernel_debug_memory, $(TARGET_PRODUCT)))
# if TARGET == taimen_kernel_debug_memory
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/debug_memory/touch_core_base.ko \
    device/google/wahoo-kernel/debug_memory/ftm4.ko \
    device/google/wahoo-kernel/debug_memory/sw49408.ko \
    device/google/wahoo-kernel/debug_memory/lge_battery.ko \
    device/google/wahoo-kernel/debug_memory/wlan.ko
else ifeq (,$(filter-out taimen_kernel_debug_locking, $(TARGET_PRODUCT)))
# if TARGET == taimen_kernel_debug_locking
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/debug_locking/touch_core_base.ko \
    device/google/wahoo-kernel/debug_locking/ftm4.ko \
    device/google/wahoo-kernel/debug_locking/sw49408.ko \
    device/google/wahoo-kernel/debug_locking/lge_battery.ko \
    device/google/wahoo-kernel/debug_locking/wlan.ko
else ifeq (,$(filter-out taimen_kernel_debug_hang, $(TARGET_PRODUCT)))
# if TARGET == taimen_kernel_debug_hang
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/debug_hang/touch_core_base.ko \
    device/google/wahoo-kernel/debug_hang/ftm4.ko \
    device/google/wahoo-kernel/debug_hang/sw49408.ko \
    device/google/wahoo-kernel/debug_hang/lge_battery.ko \
    device/google/wahoo-kernel/debug_hang/wlan.ko
else ifeq (,$(filter-out taimen_kernel_debug_api, $(TARGET_PRODUCT)))
# if TARGET == taimen_kernel_debug_api
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/debug_api/touch_core_base.ko \
    device/google/wahoo-kernel/debug_api/ftm4.ko \
    device/google/wahoo-kernel/debug_api/sw49408.ko \
    device/google/wahoo-kernel/debug_api/lge_battery.ko \
    device/google/wahoo-kernel/debug_api/wlan.ko
else
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/touch_core_base.ko \
    device/google/wahoo-kernel/ftm4.ko \
    device/google/wahoo-kernel/sw49408.ko \
    device/google/wahoo-kernel/lge_battery.ko \
    device/google/wahoo-kernel/wlan.ko
endif

-include vendor/google_devices/taimen/proprietary/BoardConfigVendor.mk

# Testing related defines
BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/wahoo-setup.sh

BOARD_LISA_TARGET_SCRIPTS := device/google/wahoo/lisa/

# Rounded corners recovery UI. 105px = 30dp * 3.5 density, where 30dp comes from
# rounded_corner_radius in overlay/frameworks/base/packages/SystemUI/res/values/dimens.xml.
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 105

TARGET_RECOVERY_UI_LIB := \
    librecovery_ui_taimen \
    libfstab

# VTS DTBO Verification. This kernel cmdline parameter should be added by the bootloader
# for all future devices.
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=12

# Allow Lineage config to override others
-include device/google/taimen/BoardConfigLineage.mk

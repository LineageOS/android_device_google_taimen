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

# sepolicy
BOARD_SEPOLICY_DIRS += device/google/taimen/sepolicy

-include vendor/google_devices/taimen/proprietary/BoardConfigVendor.mk

# Testing related defines
BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/wahoo-setup.sh

BOARD_LISA_TARGET_SCRIPTS := device/google/wahoo/lisa/

# Rounded corners recovery UI. 105px = 30dp * 3.5 density, where 30dp comes from
# rounded_corner_radius in overlay/frameworks/base/packages/SystemUI/res/values/dimens.xml.
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 105

# VTS DTBO Verification. This kernel cmdline parameter should be added by the bootloader
# for all future devices.
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=12

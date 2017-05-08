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
DEFAULT_LOW_PERSISTENCE_MODE_BRIGHTNESS := 0x00000056

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200,n8 earlycon=msm_serial_dm,0xc1b0000

TARGET_RECOVERY_FSTAB := device/google/taimen/fstab.hardware
include device/google/wahoo/BoardConfig.mk

BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
BOARD_AVB_ENABLE := true

-include vendor/google_devices/taimen/proprietary/BoardConfigVendor.mk

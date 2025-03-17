#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_pixel import (
    extract_pixel_factory_image,
    extract_pixel_firmware,
    pixel_factory_image_regex,
    pixel_firmware_regex,
)
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/qcom/wlan/legacy',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'gralloc.msm8998',
        'libgps.utils',
        'libloc_core',
        'libloc_pla',
        'libqdMetaData',
        'libqservice',
        'libsdmutils',
    ): lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    'product/etc/sysconfig/nexus.xml': blob_fixup()
        .regex_replace('qulacomm', 'qualcomm'),
    (
        'system/lib/com.qualcomm.qti.imsrtpservice@1.0.so',
        'system/lib64/com.qualcomm.qti.imsrtpservice@1.0.so',
        'vendor/bin/cnd',
        'vendor/bin/ims_rtp_daemon',
        'vendor/bin/imsrcsd',
        'vendor/bin/netmgrd',
        'vendor/lib/com.qualcomm.qti.imsrtpservice@1.0_vendor.so',
        'vendor/lib/com.quicinc.cne.api@1.0.so',
        'vendor/lib/com.quicinc.cne.server@1.0.so',
        'vendor/lib64/com.qualcomm.qti.imsrtpservice@1.0_vendor.so',
        'vendor/lib64/com.quicinc.cne.api@1.0.so',
        'vendor/lib64/com.quicinc.cne.server@1.0.so',
    ): blob_fixup()
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so'),
    'product/lib64/libakuaf.so': blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_product.so'),
    (
        'system/lib/lib-imsvt.so',
        'system/lib/libimsmedia_jni.so',
        'system/lib64/lib-imsvt.so',
        'system/lib64/libimsmedia_jni.so',
    ): blob_fixup()
        .add_needed('libgui_shim.so'),
    'vendor/bin/pm-service': blob_fixup()
        .add_needed('libutils-v33.so'),
    'vendor/lib/libmmcamera_faceproc.so': blob_fixup()
        .clear_symbol_version('__aeabi_memcpy')
        .clear_symbol_version('__aeabi_memset')
        .clear_symbol_version('__gnu_Unwind_Find_exidx'),
    (
        'vendor/lib/libwvhidl.so',
        'vendor/lib64/libwvhidl.so',
    ): blob_fixup()
        .add_needed('libcrypto_shim.so'),
    (
        'vendor/lib/hw/vulkan.adreno.so',
        'vendor/lib64/hw/vulkan.adreno.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_release'),
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    pixel_factory_image_regex: extract_pixel_factory_image,
    #pixel_firmware_regex: extract_pixel_firmware,
}

module = ExtractUtilsModule(
    'taimen',
    'google',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    #add_firmware_proprietary_file=True,
    extract_fns=extract_fns,
)

module.add_proprietary_file('proprietary-files-vendor.txt')

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()

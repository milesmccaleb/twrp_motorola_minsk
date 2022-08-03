#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# define hardware platform
PRODUCT_PLATFORM := sm6150

# A/B support
AB_OTA_UPDATER := true

LOCAL_PATH := device/motorola/minsk

# A/B
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    product \
    recovery \
    vbmeta \
    vbmeta_system \
    dtbo

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.$(PRODUCT_PLATFORM).recovery

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Encryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Blacklist
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.bootimage.build.date.utc \
    ro.build.date.utc

# Apex libraries
PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/ota

# Copy modules for depmod
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/bu520xx_pen.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/bu520xx_pen.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/ets_fps_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/ets_fps_mmi.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/exfat.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/exfat.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/fpc1020_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/fpc1020_mmi.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mcDrvModule.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mcDrvModule.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mmi_annotate.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mmi_annotate.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mmi_info.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mmi_info.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mmi_sys_temp.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mmi_sys_temp.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/moto_f_usbnet.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/moto_f_usbnet.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mpq-adapter.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mpq-adapter.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/mpq-dmx-hw-plugin.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/mpq-dmx-hw-plugin.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/nova_0flash_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/nova_0flash_mmi.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/qca_cld3_wlan.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/qca_cld3_wlan.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/qpnp_adaptive_charge.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/qpnp_adaptive_charge.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/qpnp-power-on-mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/qpnp-power-on-mmi.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/rdbg.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/rdbg.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/snd_smartpa_aw882xx.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/snd_smartpa_aw882xx.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sx933x_sar.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sx933x_sar.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/tps61280.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/tps61280.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/tzlog_dump.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/tzlog_dump.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/utags.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/utags.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/watchdog_cpu_ctx.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/watchdog_cpu_ctx.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/watchdogtest.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/watchdogtest.ko \

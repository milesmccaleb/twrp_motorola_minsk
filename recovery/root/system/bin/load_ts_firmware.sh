#!/system/bin/sh

module_path=/vendor/lib/modules/1.1/

# Load all needed modules
insmod $module_path/bu520xx_pen.ko
insmod $module_path/ets_fps_mmi.ko
insmod $module_path/exfat.ko
insmod $module_path/fpc1020_mmi.ko
insmod $module_path/mmi_annotate.ko
insmod $module_path/mmi_info.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/mpq-adapter.ko
insmod $module_path/mpq-dmx-hw-plugin.ko
insmod $module_path/nova_0flash_mmi.ko
insmod $module_path/qca_cld3_wlan.ko
insmod $module_path/qpnp_adaptive_charge.ko
insmod $module_path/qpnp-power-on-mmi.ko
insmod $module_path/rdbg.ko
insmod $module_path/snd_smartpa_aw882xx.ko
insmod $module_path/tzlog_dump.ko
insmod $module_path/utags.ko
insmod $module_path/watchdog_cpu_ctx.ko
insmod $module_path/watchdogtest.ko

# Update novatek touchscreen firmware early
cat /proc/nvt_update

setprop modules.loaded 1
return 0

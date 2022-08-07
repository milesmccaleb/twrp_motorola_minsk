#!/system/bin/sh

module_path=/vendor/lib/modules/1.1/

firmware_path=/vendor/firmware
touch_class_path=/sys/devices/platform/soc/a88000.spi/spi_master/spi1/spi1.0/of_node
touch_path=
firmware_file=

# Load all needed modules
insmod $module_path/bu520xx_pen.ko
insmod $module_path/ets_fps_mmi.ko
insmod $module_path/exfat.ko
insmod $module_path/fpc1020_mmi.ko
insmod $module_path/mcDrvModule.ko
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
insmod $module_path/sx933x_sar.ko
insmod $module_path/tps61280.ko
insmod $module_path/tzlog_dump.ko
insmod $module_path/utags.ko
insmod $module_path/watchdog_cpu_ctx.ko
insmod $module_path/watchdogtest.ko

load_touch()
{
	touch_product_string=$(ls /sys/class/touchscreen/primary)
	panel_supplier=""
	panel_supplier=$(cat /sys/devices/platform/soc/a88000.spi/spi_master/spi1/spi1.0/of_node/novatek,panel-supplier)
	    echo "panel supplier vendor is: [$panel_supplier]"
	    cd $firmware_path
	    case $panel_supplier in
	        auo)
			    firmware_file="auo_novatek_ts_fw.bin"
	            ;;
	        *)
			    firmware_file="auo_novatek_ts_fw.bin"
	            ;;
	    esac
	echo "Firmware file for upgrade $firmware_file"
	echo "forcing firmware upgrade"
	echo 1 > $touch_class_path/forcereflash
	echo "sending reflash command"
	echo $firmware_file > $touch_class_path/doreflash
	sleep 1.5
	setprop touch.fw.loaded 1
}

load_touch

# Update novatek touchscreen firmware early
cat /proc/nvt_update

setprop modules.loaded 1
return 0

# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Users\19165\Documents\Xilinx_Projects\muxtest2\vitis_workspace\lvds_test_app_system\_ide\scripts\systemdebugger_lvds_test_app_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Users\19165\Documents\Xilinx_Projects\muxtest2\vitis_workspace\lvds_test_app_system\_ide\scripts\systemdebugger_lvds_test_app_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248AA59A3" && level==0 && jtag_device_ctx=="jsn-Zed-210248AA59A3-23727093-0"}
fpga -file C:/Users/19165/Documents/Xilinx_Projects/muxtest2/vitis_workspace/lvds_test_app/_ide/bitstream/lvds_test_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Users/19165/Documents/Xilinx_Projects/muxtest2/vitis_workspace/lvds_test_wrapper/export/lvds_test_wrapper/hw/lvds_test_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/Users/19165/Documents/Xilinx_Projects/muxtest2/vitis_workspace/lvds_test_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/19165/Documents/Xilinx_Projects/muxtest2/vitis_workspace/lvds_test_app/Debug/lvds_test_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con

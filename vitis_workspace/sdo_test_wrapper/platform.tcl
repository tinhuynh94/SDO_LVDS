# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\19165\Documents\Xilinx_Projects\SDO_LVDS\vitis_workspace\sdo_test_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\19165\Documents\Xilinx_Projects\SDO_LVDS\vitis_workspace\sdo_test_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {sdo_test_wrapper}\
-hw {C:\Users\19165\Documents\Xilinx_Projects\SDO_LVDS\sdo_test_wrapper.xsa}\
-out {C:/Users/19165/Documents/Xilinx_Projects/SDO_LVDS/vitis_workspace}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {sdo_test_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate

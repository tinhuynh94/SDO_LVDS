#
# This file was created by Xilinx Vitis tool.
#


#
# tools
#

RM = rm -f
RMDIR = rm -rf



#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = C:/Users/19165/Documents/Xilinx_Projects/SDO_LVDS/vitis_workspace/sdo_test_wrapper/export/sdo_test_wrapper/sdo_test_wrapper.xpfm
SYS_CONFIG = sdo_test_wrapper
DOMAINS = standalone_ps7_cortexa9_0
BIF_PATH = C:/Users/19165/Documents/Xilinx_Projects/SDO_LVDS/vitis_workspace/sdo_test_app_system/Debug/system.bif

BITSTREAM_PATH = C:/Users/19165/Documents/Xilinx_Projects/SDO_LVDS/vitis_workspace/sdo_test_app/_ide/bitstream/sdo_test_wrapper.bit
SD_FILES = --elf C:/Users/19165/Documents/Xilinx_Projects/SDO_LVDS/vitis_workspace/sdo_test_app/Debug/sdo_test_app.elf,ps7_cortexa9_0

#
# primary build targets
#

package:
	-@echo Generating bif file for the system project
	generate_system_bif.bat 64763 ${XPFM_PATH} ${DOMAINS} ${BIF_PATH}
	${SDCARD_GEN} --xpfm ${XPFM_PATH} --sys_config ${SYS_CONFIG} --bif ${BIF_PATH} --bitstream ${BITSTREAM_PATH} ${SD_FILES}

clean:
	$(RMDIR) ./_sds
	${RMDIR} package
	${RM} system.bif

.PHONY: all package clean

all: package



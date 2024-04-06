set_property PACKAGE_PIN F22 [get_ports {sws_8bits_tri_i[0]}]
set_property PACKAGE_PIN G22 [get_ports {sws_8bits_tri_i[1]}]
set_property PACKAGE_PIN H22 [get_ports {sws_8bits_tri_i[2]}]
set_property PACKAGE_PIN F21 [get_ports {sws_8bits_tri_i[3]}]
set_property PACKAGE_PIN H19 [get_ports {sws_8bits_tri_i[4]}]
set_property PACKAGE_PIN H18 [get_ports {sws_8bits_tri_i[5]}]
set_property PACKAGE_PIN H17 [get_ports {sws_8bits_tri_i[6]}]
set_property PACKAGE_PIN M15 [get_ports {sws_8bits_tri_i[7]}]
set_property PACKAGE_PIN T22 [get_ports {leds_8bits[0]}]
set_property PACKAGE_PIN T21 [get_ports {leds_8bits[1]}]
set_property PACKAGE_PIN U22 [get_ports {leds_8bits[2]}]
set_property PACKAGE_PIN U21 [get_ports {leds_8bits[3]}]
set_property PACKAGE_PIN V22 [get_ports {leds_8bits[4]}]
set_property PACKAGE_PIN W22 [get_ports {leds_8bits[5]}]
set_property PACKAGE_PIN U19 [get_ports {leds_7to6[0]}]
set_property PACKAGE_PIN U14 [get_ports {leds_7to6[1]}]
set_property PACKAGE_PIN P16 [get_ports {btns_5bits_tri_i[0]}]
set_property PACKAGE_PIN R16 [get_ports {btns_5bits_tri_i[1]}]
set_property PACKAGE_PIN N15 [get_ports {btns_5bits_tri_i[2]}]
set_property PACKAGE_PIN R18 [get_ports {btns_5bits_tri_i[3]}]
set_property PACKAGE_PIN T18 [get_ports {btns_5bits_tri_i[4]}]

set_property IOSTANDARD LVCMOS25 [get_ports {leds_8bits[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {leds_7to6[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sws_8bits_tri_i[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {btns_5bits_tri_i[*]}]

set_property PULLDOWN true [get_ports {leds_8bits_tri_o[*]}]
set_property PULLDOWN true [get_ports {sws_8bits_tri_i[*]}]

#set_property IOSTANDARD LVCMOS25 [get_ports qspi_clk]
#set_property PACKAGE_PIN T21 [get_ports qspi_clk]

set_property IOSTANDARD LVDS_25 [get_ports LVDS_CLK_P]
set_property PACKAGE_PIN N17 [get_ports LVDS_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports LVDS_CLK_N]
set_property PACKAGE_PIN N18 [get_ports LVDS_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports LVDS_DATA_P]
set_property PACKAGE_PIN T16 [get_ports LVDS_DATA_P]
set_property IOSTANDARD LVDS_25 [get_ports LVDS_DATA_N]
set_property PACKAGE_PIN T17 [get_ports LVDS_DATA_N]

set_property IOSTANDARD LVCMOS25 [get_ports test_clk]
set_property PACKAGE_PIN R21 [get_ports test_clk]

set_property IOSTANDARD LVCMOS25 [get_ports {MISC_rtl_tri_io[*]}]
set_property PACKAGE_PIN C15 [get_ports MISC_rtl_tri_io[0]]; # VProg Ctrl
set_property PACKAGE_PIN B15 [get_ports MISC_rtl_tri_io[1]]; # Reset Ctrl
set_property PACKAGE_PIN J22 [get_ports MISC_rtl_tri_io[2]]; # BUSY
set_property PACKAGE_PIN J21 [get_ports MISC_rtl_tri_io[3]]; # DTB

set_property IOSTANDARD LVCMOS25 [get_ports {QSPI_rtl_tri_io[*]}]
set_property PACKAGE_PIN G20 [get_ports QSPI_rtl_tri_io[0]]; # SD0
set_property PACKAGE_PIN K21 [get_ports QSPI_rtl_tri_io[1]]; # SD1
set_property PACKAGE_PIN P21 [get_ports QSPI_rtl_tri_io[2]]; # SD2
set_property PACKAGE_PIN P20 [get_ports QSPI_rtl_tri_io[3]]; # SD3
set_property PACKAGE_PIN G19 [get_ports QSPI_rtl_tri_io[4]]; # SCK
set_property PACKAGE_PIN G21 [get_ports QSPI_rtl_tri_io[5]]; # CSN

set_property IOSTANDARD LVCMOS25 [get_ports {CLK_25MHZ[0]}]
set_property PACKAGE_PIN E20 [get_ports CLK_25MHZ[0]]; 

set_property IOSTANDARD LVCMOS25 [get_ports {CLK_10MHZ}]
set_property PACKAGE_PIN D21 [get_ports CLK_10MHZ]; 

set_property IOSTANDARD LVCMOS25 [get_ports {LEV_SHIFT_rtl_tri_o[0]}]
set_property PACKAGE_PIN P22 [get_ports LEV_SHIFT_rtl_tri_o[0]]; 

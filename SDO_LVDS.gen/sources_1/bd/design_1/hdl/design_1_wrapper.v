//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
//Date        : Fri Apr  5 15:19:57 2024
//Host        : LAPTOP-4NG0TGNQ running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLK_10MHZ,
    CLK_25MHZ,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    LEV_SHIFT_rtl_tri_o,
    LVDS_CLK_N,
    LVDS_CLK_P,
    LVDS_DATA_N,
    LVDS_DATA_P,
    MISC_rtl_tri_io,
    QSPI_rtl_tri_io);
  output CLK_10MHZ;
  output [0:0]CLK_25MHZ;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [0:0]LEV_SHIFT_rtl_tri_o;
  output [0:0]LVDS_CLK_N;
  output [0:0]LVDS_CLK_P;
  output [0:0]LVDS_DATA_N;
  output [0:0]LVDS_DATA_P;
  inout [3:0]MISC_rtl_tri_io;
  inout [5:0]QSPI_rtl_tri_io;

  wire CLK_10MHZ;
  wire [0:0]CLK_25MHZ;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [0:0]LEV_SHIFT_rtl_tri_o;
  wire [0:0]LVDS_CLK_N;
  wire [0:0]LVDS_CLK_P;
  wire [0:0]LVDS_DATA_N;
  wire [0:0]LVDS_DATA_P;
  wire [0:0]MISC_rtl_tri_i_0;
  wire [1:1]MISC_rtl_tri_i_1;
  wire [2:2]MISC_rtl_tri_i_2;
  wire [3:3]MISC_rtl_tri_i_3;
  wire [0:0]MISC_rtl_tri_io_0;
  wire [1:1]MISC_rtl_tri_io_1;
  wire [2:2]MISC_rtl_tri_io_2;
  wire [3:3]MISC_rtl_tri_io_3;
  wire [0:0]MISC_rtl_tri_o_0;
  wire [1:1]MISC_rtl_tri_o_1;
  wire [2:2]MISC_rtl_tri_o_2;
  wire [3:3]MISC_rtl_tri_o_3;
  wire [0:0]MISC_rtl_tri_t_0;
  wire [1:1]MISC_rtl_tri_t_1;
  wire [2:2]MISC_rtl_tri_t_2;
  wire [3:3]MISC_rtl_tri_t_3;
  wire [0:0]QSPI_rtl_tri_i_0;
  wire [1:1]QSPI_rtl_tri_i_1;
  wire [2:2]QSPI_rtl_tri_i_2;
  wire [3:3]QSPI_rtl_tri_i_3;
  wire [4:4]QSPI_rtl_tri_i_4;
  wire [5:5]QSPI_rtl_tri_i_5;
  wire [0:0]QSPI_rtl_tri_io_0;
  wire [1:1]QSPI_rtl_tri_io_1;
  wire [2:2]QSPI_rtl_tri_io_2;
  wire [3:3]QSPI_rtl_tri_io_3;
  wire [4:4]QSPI_rtl_tri_io_4;
  wire [5:5]QSPI_rtl_tri_io_5;
  wire [0:0]QSPI_rtl_tri_o_0;
  wire [1:1]QSPI_rtl_tri_o_1;
  wire [2:2]QSPI_rtl_tri_o_2;
  wire [3:3]QSPI_rtl_tri_o_3;
  wire [4:4]QSPI_rtl_tri_o_4;
  wire [5:5]QSPI_rtl_tri_o_5;
  wire [0:0]QSPI_rtl_tri_t_0;
  wire [1:1]QSPI_rtl_tri_t_1;
  wire [2:2]QSPI_rtl_tri_t_2;
  wire [3:3]QSPI_rtl_tri_t_3;
  wire [4:4]QSPI_rtl_tri_t_4;
  wire [5:5]QSPI_rtl_tri_t_5;

  IOBUF MISC_rtl_tri_iobuf_0
       (.I(MISC_rtl_tri_o_0),
        .IO(MISC_rtl_tri_io[0]),
        .O(MISC_rtl_tri_i_0),
        .T(MISC_rtl_tri_t_0));
  IOBUF MISC_rtl_tri_iobuf_1
       (.I(MISC_rtl_tri_o_1),
        .IO(MISC_rtl_tri_io[1]),
        .O(MISC_rtl_tri_i_1),
        .T(MISC_rtl_tri_t_1));
  IOBUF MISC_rtl_tri_iobuf_2
       (.I(MISC_rtl_tri_o_2),
        .IO(MISC_rtl_tri_io[2]),
        .O(MISC_rtl_tri_i_2),
        .T(MISC_rtl_tri_t_2));
  IOBUF MISC_rtl_tri_iobuf_3
       (.I(MISC_rtl_tri_o_3),
        .IO(MISC_rtl_tri_io[3]),
        .O(MISC_rtl_tri_i_3),
        .T(MISC_rtl_tri_t_3));
  IOBUF QSPI_rtl_tri_iobuf_0
       (.I(QSPI_rtl_tri_o_0),
        .IO(QSPI_rtl_tri_io[0]),
        .O(QSPI_rtl_tri_i_0),
        .T(QSPI_rtl_tri_t_0));
  IOBUF QSPI_rtl_tri_iobuf_1
       (.I(QSPI_rtl_tri_o_1),
        .IO(QSPI_rtl_tri_io[1]),
        .O(QSPI_rtl_tri_i_1),
        .T(QSPI_rtl_tri_t_1));
  IOBUF QSPI_rtl_tri_iobuf_2
       (.I(QSPI_rtl_tri_o_2),
        .IO(QSPI_rtl_tri_io[2]),
        .O(QSPI_rtl_tri_i_2),
        .T(QSPI_rtl_tri_t_2));
  IOBUF QSPI_rtl_tri_iobuf_3
       (.I(QSPI_rtl_tri_o_3),
        .IO(QSPI_rtl_tri_io[3]),
        .O(QSPI_rtl_tri_i_3),
        .T(QSPI_rtl_tri_t_3));
  IOBUF QSPI_rtl_tri_iobuf_4
       (.I(QSPI_rtl_tri_o_4),
        .IO(QSPI_rtl_tri_io[4]),
        .O(QSPI_rtl_tri_i_4),
        .T(QSPI_rtl_tri_t_4));
  IOBUF QSPI_rtl_tri_iobuf_5
       (.I(QSPI_rtl_tri_o_5),
        .IO(QSPI_rtl_tri_io[5]),
        .O(QSPI_rtl_tri_i_5),
        .T(QSPI_rtl_tri_t_5));
  design_1 design_1_i
       (.CLK_10MHZ(CLK_10MHZ),
        .CLK_25MHZ(CLK_25MHZ),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .LEV_SHIFT_rtl_tri_o(LEV_SHIFT_rtl_tri_o),
        .LVDS_CLK_N(LVDS_CLK_N),
        .LVDS_CLK_P(LVDS_CLK_P),
        .LVDS_DATA_N(LVDS_DATA_N),
        .LVDS_DATA_P(LVDS_DATA_P),
        .MISC_rtl_tri_i({MISC_rtl_tri_i_3,MISC_rtl_tri_i_2,MISC_rtl_tri_i_1,MISC_rtl_tri_i_0}),
        .MISC_rtl_tri_o({MISC_rtl_tri_o_3,MISC_rtl_tri_o_2,MISC_rtl_tri_o_1,MISC_rtl_tri_o_0}),
        .MISC_rtl_tri_t({MISC_rtl_tri_t_3,MISC_rtl_tri_t_2,MISC_rtl_tri_t_1,MISC_rtl_tri_t_0}),
        .QSPI_rtl_tri_i({QSPI_rtl_tri_i_5,QSPI_rtl_tri_i_4,QSPI_rtl_tri_i_3,QSPI_rtl_tri_i_2,QSPI_rtl_tri_i_1,QSPI_rtl_tri_i_0}),
        .QSPI_rtl_tri_o({QSPI_rtl_tri_o_5,QSPI_rtl_tri_o_4,QSPI_rtl_tri_o_3,QSPI_rtl_tri_o_2,QSPI_rtl_tri_o_1,QSPI_rtl_tri_o_0}),
        .QSPI_rtl_tri_t({QSPI_rtl_tri_t_5,QSPI_rtl_tri_t_4,QSPI_rtl_tri_t_3,QSPI_rtl_tri_t_2,QSPI_rtl_tri_t_1,QSPI_rtl_tri_t_0}));
endmodule

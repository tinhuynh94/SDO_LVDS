--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
--Date        : Fri Apr  5 15:18:11 2024
--Host        : LAPTOP-4NG0TGNQ running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    CLK_10MHZ : out STD_LOGIC;
    CLK_25MHZ : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    LEV_SHIFT_rtl_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_CLK_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_CLK_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_DATA_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_DATA_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    MISC_rtl_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    QSPI_rtl_tri_io : inout STD_LOGIC_VECTOR ( 5 downto 0 )
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    MISC_rtl_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    MISC_rtl_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    MISC_rtl_tri_t : out STD_LOGIC_VECTOR ( 3 downto 0 );
    QSPI_rtl_tri_i : in STD_LOGIC_VECTOR ( 5 downto 0 );
    QSPI_rtl_tri_o : out STD_LOGIC_VECTOR ( 5 downto 0 );
    QSPI_rtl_tri_t : out STD_LOGIC_VECTOR ( 5 downto 0 );
    LVDS_CLK_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_CLK_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_DATA_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    LVDS_DATA_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_10MHZ : out STD_LOGIC;
    CLK_25MHZ : out STD_LOGIC_VECTOR ( 0 to 0 );
    LEV_SHIFT_rtl_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal MISC_rtl_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal MISC_rtl_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal MISC_rtl_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal MISC_rtl_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal MISC_rtl_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal MISC_rtl_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal MISC_rtl_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal MISC_rtl_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal MISC_rtl_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal MISC_rtl_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal MISC_rtl_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal MISC_rtl_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal MISC_rtl_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal MISC_rtl_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal MISC_rtl_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal MISC_rtl_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal QSPI_rtl_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal QSPI_rtl_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal QSPI_rtl_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal QSPI_rtl_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal QSPI_rtl_tri_i_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal QSPI_rtl_tri_i_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal QSPI_rtl_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal QSPI_rtl_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal QSPI_rtl_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal QSPI_rtl_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal QSPI_rtl_tri_io_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal QSPI_rtl_tri_io_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal QSPI_rtl_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal QSPI_rtl_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal QSPI_rtl_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal QSPI_rtl_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal QSPI_rtl_tri_o_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal QSPI_rtl_tri_o_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal QSPI_rtl_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal QSPI_rtl_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal QSPI_rtl_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal QSPI_rtl_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal QSPI_rtl_tri_t_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal QSPI_rtl_tri_t_5 : STD_LOGIC_VECTOR ( 5 to 5 );
begin
MISC_rtl_tri_iobuf_0: component IOBUF
     port map (
      I => MISC_rtl_tri_o_0(0),
      IO => MISC_rtl_tri_io(0),
      O => MISC_rtl_tri_i_0(0),
      T => MISC_rtl_tri_t_0(0)
    );
MISC_rtl_tri_iobuf_1: component IOBUF
     port map (
      I => MISC_rtl_tri_o_1(1),
      IO => MISC_rtl_tri_io(1),
      O => MISC_rtl_tri_i_1(1),
      T => MISC_rtl_tri_t_1(1)
    );
MISC_rtl_tri_iobuf_2: component IOBUF
     port map (
      I => MISC_rtl_tri_o_2(2),
      IO => MISC_rtl_tri_io(2),
      O => MISC_rtl_tri_i_2(2),
      T => MISC_rtl_tri_t_2(2)
    );
MISC_rtl_tri_iobuf_3: component IOBUF
     port map (
      I => MISC_rtl_tri_o_3(3),
      IO => MISC_rtl_tri_io(3),
      O => MISC_rtl_tri_i_3(3),
      T => MISC_rtl_tri_t_3(3)
    );
QSPI_rtl_tri_iobuf_0: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_0(0),
      IO => QSPI_rtl_tri_io(0),
      O => QSPI_rtl_tri_i_0(0),
      T => QSPI_rtl_tri_t_0(0)
    );
QSPI_rtl_tri_iobuf_1: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_1(1),
      IO => QSPI_rtl_tri_io(1),
      O => QSPI_rtl_tri_i_1(1),
      T => QSPI_rtl_tri_t_1(1)
    );
QSPI_rtl_tri_iobuf_2: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_2(2),
      IO => QSPI_rtl_tri_io(2),
      O => QSPI_rtl_tri_i_2(2),
      T => QSPI_rtl_tri_t_2(2)
    );
QSPI_rtl_tri_iobuf_3: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_3(3),
      IO => QSPI_rtl_tri_io(3),
      O => QSPI_rtl_tri_i_3(3),
      T => QSPI_rtl_tri_t_3(3)
    );
QSPI_rtl_tri_iobuf_4: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_4(4),
      IO => QSPI_rtl_tri_io(4),
      O => QSPI_rtl_tri_i_4(4),
      T => QSPI_rtl_tri_t_4(4)
    );
QSPI_rtl_tri_iobuf_5: component IOBUF
     port map (
      I => QSPI_rtl_tri_o_5(5),
      IO => QSPI_rtl_tri_io(5),
      O => QSPI_rtl_tri_i_5(5),
      T => QSPI_rtl_tri_t_5(5)
    );
design_1_i: component design_1
     port map (
      CLK_10MHZ => CLK_10MHZ,
      CLK_25MHZ(0) => CLK_25MHZ(0),
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      LEV_SHIFT_rtl_tri_o(0) => LEV_SHIFT_rtl_tri_o(0),
      LVDS_CLK_N(0) => LVDS_CLK_N(0),
      LVDS_CLK_P(0) => LVDS_CLK_P(0),
      LVDS_DATA_N(0) => LVDS_DATA_N(0),
      LVDS_DATA_P(0) => LVDS_DATA_P(0),
      MISC_rtl_tri_i(3) => MISC_rtl_tri_i_3(3),
      MISC_rtl_tri_i(2) => MISC_rtl_tri_i_2(2),
      MISC_rtl_tri_i(1) => MISC_rtl_tri_i_1(1),
      MISC_rtl_tri_i(0) => MISC_rtl_tri_i_0(0),
      MISC_rtl_tri_o(3) => MISC_rtl_tri_o_3(3),
      MISC_rtl_tri_o(2) => MISC_rtl_tri_o_2(2),
      MISC_rtl_tri_o(1) => MISC_rtl_tri_o_1(1),
      MISC_rtl_tri_o(0) => MISC_rtl_tri_o_0(0),
      MISC_rtl_tri_t(3) => MISC_rtl_tri_t_3(3),
      MISC_rtl_tri_t(2) => MISC_rtl_tri_t_2(2),
      MISC_rtl_tri_t(1) => MISC_rtl_tri_t_1(1),
      MISC_rtl_tri_t(0) => MISC_rtl_tri_t_0(0),
      QSPI_rtl_tri_i(5) => QSPI_rtl_tri_i_5(5),
      QSPI_rtl_tri_i(4) => QSPI_rtl_tri_i_4(4),
      QSPI_rtl_tri_i(3) => QSPI_rtl_tri_i_3(3),
      QSPI_rtl_tri_i(2) => QSPI_rtl_tri_i_2(2),
      QSPI_rtl_tri_i(1) => QSPI_rtl_tri_i_1(1),
      QSPI_rtl_tri_i(0) => QSPI_rtl_tri_i_0(0),
      QSPI_rtl_tri_o(5) => QSPI_rtl_tri_o_5(5),
      QSPI_rtl_tri_o(4) => QSPI_rtl_tri_o_4(4),
      QSPI_rtl_tri_o(3) => QSPI_rtl_tri_o_3(3),
      QSPI_rtl_tri_o(2) => QSPI_rtl_tri_o_2(2),
      QSPI_rtl_tri_o(1) => QSPI_rtl_tri_o_1(1),
      QSPI_rtl_tri_o(0) => QSPI_rtl_tri_o_0(0),
      QSPI_rtl_tri_t(5) => QSPI_rtl_tri_t_5(5),
      QSPI_rtl_tri_t(4) => QSPI_rtl_tri_t_4(4),
      QSPI_rtl_tri_t(3) => QSPI_rtl_tri_t_3(3),
      QSPI_rtl_tri_t(2) => QSPI_rtl_tri_t_2(2),
      QSPI_rtl_tri_t(1) => QSPI_rtl_tri_t_1(1),
      QSPI_rtl_tri_t(0) => QSPI_rtl_tri_t_0(0)
    );
end STRUCTURE;

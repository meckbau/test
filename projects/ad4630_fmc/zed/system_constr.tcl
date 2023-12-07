###############################################################################
## Copyright (C) 2021-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

if {![info exists AD463X_AD403X_N]} {
  set AD463X_AD403X_N $::env(AD463X_AD403X_N)
}

if {![info exists NUM_OF_SDI]} {
  set NUM_OF_SDI $::env(NUM_OF_SDI)
}

switch $AD463X_AD403X_N {
  1 {
  
    switch $NUM_OF_SDI {
      1 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
      }
      
      2 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
        set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[1]}]       ; ## G09  FMC-LA04_P
      }
      
      4 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
        set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[1]}]       ; ## H10  FMC-LA02_N
        set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[2]}]       ; ## G09  FMC-LA04_P
        set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[3]}]       ; ## G10  FMC-LA04_N
      }
      
      8 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
        set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[1]}]       ; ## H08  FMC-LA02_N
        set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[2]}]       ; ## G09  FMC-LA03_P
        set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[3]}]       ; ## G10  FMC-LA03_N
        set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[4]}]       ; ## H10  FMC-LA04_P
        set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[5]}]       ; ## H11  FMC-LA04_N
        set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[6]}]       ; ## D11  FMC-LA05_P
        set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[7]}]       ; ## D12  FMC-LA05_N
      }
    }
  }
  
  0 { 
    switch $NUM_OF_SDI {
      1 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
      }

      2 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
        set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[1]}]       ; ## H08  FMC-LA02_N
      }

      4 {
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[0]}]       ; ## H07  FMC-LA02_P
        set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[1]}]       ; ## H08  FMC-LA02_N
        set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[2]}]       ; ## G09  FMC-LA03_P
        set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports {ad4x3x_spi_sdi[3]}]       ; ## G10  FMC-LA03_N     
      }
    }
  }
}

# input delays for MISO lines (SDO for the device)
# data is latched on negative edge

set tsetup 5.6
set thold 1.6

set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[0]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[0]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[1]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[1]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[2]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[2]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[3]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[3]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[4]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[4]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[5]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[5]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[6]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[6]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports ad4x3x_spi_sdi[7]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports ad4x3x_spi_sdi[7]]

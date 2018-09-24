set_property PACKAGE_PIN Y9 [get_ports clk]
set_property PACKAGE_PIN W11 [get_ports rx]
set_property PACKAGE_PIN Y11 [get_ports PWM_0]
set_property PACKAGE_PIN AA11 [get_ports PWM_1]
set_property PACKAGE_PIN Y10 [get_ports PWM_2]
set_property PACKAGE_PIN AA9 [get_ports PWM_3]
set_property PACKAGE_PIN M15 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports PWM_0]
set_property IOSTANDARD LVCMOS33 [get_ports PWM_1]
set_property IOSTANDARD LVCMOS33 [get_ports PWM_2]
set_property IOSTANDARD LVCMOS33 [get_ports PWM_3]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN T22 [get_ports count_done]
set_property IOSTANDARD LVCMOS33 [get_ports count_done]
set_property PACKAGE_PIN U21 [get_ports rst_flag]
set_property IOSTANDARD LVCMOS33 [get_ports rst_flag]
set_property PACKAGE_PIN U14 [get_ports demux_out0]
set_property IOSTANDARD LVCMOS33 [get_ports demux_out0]
set_property PACKAGE_PIN U19 [get_ports demux_out1]
set_property IOSTANDARD LVCMOS33 [get_ports demux_out1]
set_property PACKAGE_PIN W22 [get_ports demux_out2]
set_property IOSTANDARD LVCMOS33 [get_ports demux_out2]
set_property PACKAGE_PIN V22 [get_ports set_bit_reg]
set_property IOSTANDARD LVCMOS33 [get_ports set_bit_reg]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property BITSTREAM.GENERAL.UNCONSTRAINEDPINS Allow [current_design]

set_property PACKAGE_PIN U22 [get_ports delay_start]
set_property IOSTANDARD LVCMOS33 [get_ports delay_start]


 set_property CFGBVS VCCO [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE 3.3 [current_design]
 #where value2 is the voltage provided to configuration bank 0





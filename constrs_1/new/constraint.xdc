## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk -waveform {0 5} [get_ports clk]

## Reset input
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Branch Taken input
set_property PACKAGE_PIN V17 [get_ports branch_taken]
set_property IOSTANDARD LVCMOS33 [get_ports branch_taken]

## Branch Not Taken input
set_property PACKAGE_PIN V16 [get_ports branch_not_taken]
set_property IOSTANDARD LVCMOS33 [get_ports branch_not_taken]

## Branch Prediction output
set_property PACKAGE_PIN W16 [get_ports branch_prediction]
set_property IOSTANDARD LVCMOS33 [get_ports branch_prediction]

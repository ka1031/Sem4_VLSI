# Synopsys Design Constraints (SDC) File
# Fuzzy Logic Controller - Timing Constraints

# Clock Definition (50 MHz = 20ns period)
create_clock -name clk -period 20.0 [get_ports clk]

# Clock uncertainty (jitter and skew)
set_clock_uncertainty -setup 0.5 [get_clocks clk]
set_clock_uncertainty -hold 0.2 [get_clocks clk]

# Clock transition time
set_clock_transition 0.1 [get_clocks clk]

# Input Constraints
set_input_delay -clock clk -max 2.0 [get_ports temperature[*]]
set_input_delay -clock clk -min 0.5 [get_ports temperature[*]]
set_input_delay -clock clk -max 2.0 [get_ports humidity[*]]
set_input_delay -clock clk -min 0.5 [get_ports humidity[*]]
set_input_delay -clock clk -max 2.0 [get_ports rst]

# Output Constraints
set_output_delay -clock clk -max 2.0 [get_ports heater_power[*]]
set_output_delay -clock clk -min 0.5 [get_ports heater_power[*]]
set_output_delay -clock clk -max 2.0 [get_ports cooler_power[*]]
set_output_delay -clock clk -min 0.5 [get_ports cooler_power[*]]
set_output_delay -clock clk -max 2.0 [get_ports humidifier_power[*]]
set_output_delay -clock clk -min 0.5 [get_ports humidifier_power[*]]
set_output_delay -clock clk -max 2.0 [get_ports dehumidifier_power[*]]
set_output_delay -clock clk -min 0.5 [get_ports dehumidifier_power[*]]

# Output loads
set_load 0.1 [get_ports heater_power[*]]
set_load 0.1 [get_ports cooler_power[*]]
set_load 0.1 [get_ports humidifier_power[*]]
set_load 0.1 [get_ports dehumidifier_power[*]]

# Design Rule Constraints
set_max_transition 0.5 [current_design]
set_max_fanout 20 [current_design]
set_max_capacitance 0.5 [current_design]

# False paths
set_false_path -from [get_ports rst]

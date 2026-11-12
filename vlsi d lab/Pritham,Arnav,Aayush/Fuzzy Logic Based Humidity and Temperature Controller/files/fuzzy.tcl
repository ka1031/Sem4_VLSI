read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib

read_hdl fuzzy_controller.v

elaborate fuzzy_controller

read_sdc fuzzy.sdc

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt

report_timing > fuzzy_controller_timing.rep
report_area > fuzzy_controller_area.rep
report_power > fuzzy_controller_power.rep

write_hdl > fuzzy_controller_netlist.v
write_sdc > fuzzy_controller_out.sdc

gui_show

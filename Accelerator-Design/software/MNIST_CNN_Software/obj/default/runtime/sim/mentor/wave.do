onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/clk
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/clk_en
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/reset
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/dataa
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/datab
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/result
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/dataa_reg
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/nextstate_dataa_reg
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/datab_reg
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/nextstate_datab_reg
add wave -noupdate -expand -group Add_multi /nios_system_tb/nios_system_inst/floating_point_adder_multicycle_0/fpadder_result
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/clk
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/clk_en
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/reset
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/dataa
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/datab
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/result
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/dataa_reg
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/nextstate_dataa_reg
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/datab_reg
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/nextstate_datab_reg
add wave -noupdate -expand -group Mul_multi /nios_system_tb/nios_system_inst/floating_point_multiplier_multicycle_0/fpmultiplier_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 633
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {703 ps}

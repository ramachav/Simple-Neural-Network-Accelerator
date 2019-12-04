onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/clk
add wave -noupdate /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/reset
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/address
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/read
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/write
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/beginbursttransfer
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/burstcount
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/writedata
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/waitrequest
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/readdatavalid
add wave -noupdate -group {Avalon Slave Interface Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/readdata
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/current_burstcount
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/nextstate_burstcount
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/ifbursttransfer
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/burstread
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/burstaddress
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/calccount
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/nextstate_calccount
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/calcinprogress
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/calcinprogress_reg
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/adder_enable
add wave -noupdate -group {Internal Control Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/adder_en_reg
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_write_enable
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_read_enable
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_buffer_empty
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_buffer_full
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/illegal_weight_access
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_read_en_reg
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_write_data
add wave -noupdate -group {Weight Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/weight_read_data
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_write_enable
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_read_enable
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_buffer_empty
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_buffer_full
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/illegal_image_access
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_read_en_reg
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_write_data
add wave -noupdate -group {Image Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/image_read_data
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_write_enable
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_read_enable
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_buffer_empty
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_buffer_full
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/illegal_result_access
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_write_data
add wave -noupdate -group {Result Buffer Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/result_read_data
add wave -noupdate -group {Adder Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/adder_input_a
add wave -noupdate -group {Adder Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/adder_input_b
add wave -noupdate -group {Adder Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/adder_output
add wave -noupdate -group {Multiplier Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/multiplier_input_a
add wave -noupdate -group {Multiplier Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/multiplier_input_b
add wave -noupdate -group {Multiplier Signals} /nios_system_tb/nios_system_inst/nn_acc_single_buffer_version_1/multiplier_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 329
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
WaveRestoreZoom {0 ps} {890 ps}

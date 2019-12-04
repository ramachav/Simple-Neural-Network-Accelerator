onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/clk
add wave -noupdate /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/reset
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/address
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/read
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/write
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/beginbursttransfer
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/burstcount
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/writedata
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/waitrequest
add wave -noupdate -expand -group {Avalon Slave Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/readdata
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/current_burstcount
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/nextstate_burstcount
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/ifbursttransfer
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/burstaddress
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_enable
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_en_reg
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/illegal_weight_access
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/illegal_image_access
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/illegal_result_access
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/calccount
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/nextstate_calccount
add wave -noupdate -expand -group {Internal Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/calcinprogress
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_write_enable
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_enable
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_en_reg
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_buffer_empty
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_buffer_full
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_write_data
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_data
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/write_ptr
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/read_ptr
add wave -noupdate -group {Weight Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/data_buffer_array
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_write_enable
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_enable
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_en_reg
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_buffer_empty
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_buffer_full
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_write_data
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_data
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/write_ptr
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/read_ptr
add wave -noupdate -group {Image Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/data_buffer_array
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_write_enable
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_read_enable
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_buffer_empty
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_buffer_full
add wave -noupdate -expand -group {Result Buffer Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_write_data
add wave -noupdate -expand -group {Result Buffer Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_read_data
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/write_ptr
add wave -noupdate -expand -group {Result Buffer Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/read_ptr
add wave -noupdate -expand -group {Result Buffer Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/data_buffer_array
add wave -noupdate -expand -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_input_a
add wave -noupdate -expand -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_input_b
add wave -noupdate -expand -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_output
add wave -noupdate -expand -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_input_a
add wave -noupdate -expand -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_input_b
add wave -noupdate -expand -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {482988 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 447
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
configure wave -timelineunits ns
update
WaveRestoreZoom {482819 ns} {488973 ns}

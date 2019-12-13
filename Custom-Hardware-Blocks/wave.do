onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/clk
add wave -noupdate /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/reset
add wave -noupdate -group {Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/address
add wave -noupdate -group {Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/read
add wave -noupdate -group {Interface Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/write
add wave -noupdate -group {Interface Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/writedata
add wave -noupdate -group {Interface Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/readdata
add wave -noupdate -group {Weight Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_write_enable
add wave -noupdate -group {Weight Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_enable
add wave -noupdate -group {Weight Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_buffer_empty
add wave -noupdate -group {Weight Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_buffer_full
add wave -noupdate -group {Weight Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_en_reg
add wave -noupdate -group {Weight Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_write_data
add wave -noupdate -group {Weight Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/weight_read_data
add wave -noupdate -group {Image Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_write_enable
add wave -noupdate -group {Image Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_enable
add wave -noupdate -group {Image Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_buffer_empty
add wave -noupdate -group {Image Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_buffer_full
add wave -noupdate -group {Image Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_en_reg
add wave -noupdate -group {Image Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_write_data
add wave -noupdate -group {Image Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/image_read_data
add wave -noupdate -group {Result Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_write_enable
add wave -noupdate -group {Result Signals} -radix decimal /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_read_enable
add wave -noupdate -group {Result Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_buffer_empty
add wave -noupdate -group {Result Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_buffer_full
add wave -noupdate -group {Result Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_write_data
add wave -noupdate -group {Result Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/result_read_data
add wave -noupdate -group {Control Signals} -radix decimal /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/calccount
add wave -noupdate -group {Control Signals} -radix decimal /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/nextstate_calccount
add wave -noupdate -group {Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_enable
add wave -noupdate -group {Control Signals} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_en_reg
add wave -noupdate -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_input_a
add wave -noupdate -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_input_b
add wave -noupdate -group {Adder Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/adder_output
add wave -noupdate -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_input_a
add wave -noupdate -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_input_b
add wave -noupdate -group {Multiplier Signals} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/multiplier_output
add wave -noupdate -group {Weight Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/write_ptr
add wave -noupdate -group {Weight Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/nextstate_write_ptr
add wave -noupdate -group {Weight Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/read_ptr
add wave -noupdate -group {Weight Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/nextstate_read_ptr
add wave -noupdate -group {Weight Buffer} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/WEIGHT_BUFFER/data_buffer_array
add wave -noupdate -group {Image Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/write_ptr
add wave -noupdate -group {Image Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/nextstate_write_ptr
add wave -noupdate -group {Image Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/read_ptr
add wave -noupdate -group {Image Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/nextstate_read_ptr
add wave -noupdate -group {Image Buffer} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/IMAGE_BUFFER/data_buffer_array
add wave -noupdate -group {Result Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/write_ptr
add wave -noupdate -group {Result Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/nextstate_write_ptr
add wave -noupdate -group {Result Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/read_ptr
add wave -noupdate -group {Result Buffer} /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/nextstate_read_ptr
add wave -noupdate -group {Result Buffer} -radix float32 /nn_acc_single_tb/SINGLE_MAC_NN_ACCELERATOR/RESULT_BUFFER/data_buffer_array
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {285 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 386
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
WaveRestoreZoom {0 ns} {5018 ns}

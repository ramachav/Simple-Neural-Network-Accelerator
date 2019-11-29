


vlog -reportprogress 300 -work work /home/ecegrid/a/695r07/ece695r/Project/SoCProject/Custom-Hardware-Blocks/AcceleratorPackage.sv

vlog -reportprogress 300 -work work /home/ecegrid/a/695r07/ece695r/Project/SoCProject/Custom-Hardware-Blocks/AcceleratorTopMod.sv

vlog -reportprogress 300 -work work /home/ecegrid/a/695r07/ece695r/Project/SoCProject/Custom-Hardware-Blocks/tbAccl.sv

vsim -novopt work.tbAccl


add wave -position insertpoint sim:/tbAccl/tbLd/*
add wave -position insertpoint sim:/tbAccl/accl/*

run 200 ns


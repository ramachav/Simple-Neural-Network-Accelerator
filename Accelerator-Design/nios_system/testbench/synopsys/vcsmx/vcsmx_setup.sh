
# (C) 2001-2019 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 17.0 595 linux 2019.12.13.10:18:56

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     nios_system_tb
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level shell script that compiles Altera simulation libraries 
# and the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "vcsmx_sim.sh", and modify text as directed.
# 
# You can also modify the simulation flow to suit your needs. Set the
# following variables to 1 to disable their corresponding processes:
# - SKIP_FILE_COPY: skip copying ROM/RAM initialization files
# - SKIP_DEV_COM: skip compiling the Quartus EDA simulation library
# - SKIP_COM: skip compiling Quartus-generated IP simulation files
# - SKIP_ELAB and SKIP_SIM: skip elaboration and simulation
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator. In this case, you must also copy the generated library
# # setup "synopsys_sim.setup" into the location from which you launch the
# # simulator, or incorporate into any existing library setup.
# #
# # Run Quartus-generated IP simulation script once to compile Quartus EDA
# # simulation libraries and Quartus-generated IP simulation files, and copy
# # any ROM/RAM initialization files to the simulation directory.
# #
# # - If necessary, specify USER_DEFINED_COMPILE_OPTIONS.
# source <script generation output directory>/synopsys/vcsmx/vcsmx_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1 \
# USER_DEFINED_COMPILE_OPTIONS=<compilation options for your design> \
# QSYS_SIMDIR=<script generation output directory>
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the IP script)
# #
# vlogan <compilation options> <design and testbench files>
# #
# # TOP_LEVEL_NAME is used in this script to set the top-level simulation or
# # testbench module/entity name.
# #
# # Run the IP script again to elaborate and simulate the top level:
# # - Specify TOP_LEVEL_NAME and USER_DEFINED_ELAB_OPTIONS.
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# #
# source <script generation output directory>/synopsys/vcsmx/vcsmx_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME="'-top <simulation top>'" \
# QSYS_SIMDIR=<script generation output directory> \
# USER_DEFINED_ELAB_OPTIONS=<elaboration options for your design> \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If nios_system_tb is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 17.0 595 linux 2019.12.13.10:18:56
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="nios_system_tb"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="/package/eda/altera/altera17.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_common_sv_packages/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/avalon_st_adapter_002/
mkdir -p ./libraries/avalon_st_adapter_001/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/nios2_qsys_0_data_master_to_sram_0_avalon_sram_slave_cmd_width_adapter/
mkdir -p ./libraries/rsp_mux_003/
mkdir -p ./libraries/rsp_mux_002/
mkdir -p ./libraries/rsp_mux_001/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux_009/
mkdir -p ./libraries/rsp_demux_005/
mkdir -p ./libraries/rsp_demux_002/
mkdir -p ./libraries/rsp_demux_001/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux_009/
mkdir -p ./libraries/cmd_mux_008/
mkdir -p ./libraries/cmd_mux_005/
mkdir -p ./libraries/cmd_mux_002/
mkdir -p ./libraries/cmd_mux_001/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux_004/
mkdir -p ./libraries/cmd_demux_003/
mkdir -p ./libraries/cmd_demux_002/
mkdir -p ./libraries/cmd_demux_001/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/sram_0_avalon_sram_slave_burst_adapter/
mkdir -p ./libraries/nios2_qsys_0_data_master_limiter/
mkdir -p ./libraries/router_014/
mkdir -p ./libraries/router_013/
mkdir -p ./libraries/router_010/
mkdir -p ./libraries/router_007/
mkdir -p ./libraries/router_006/
mkdir -p ./libraries/router_005/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/router_002/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/sram_0_avalon_sram_slave_agent_rsp_fifo/
mkdir -p ./libraries/sram_0_avalon_sram_slave_agent/
mkdir -p ./libraries/video_pixel_buffer_dma_0_avalon_pixel_dma_master_agent/
mkdir -p ./libraries/video_pixel_buffer_dma_0_avalon_pixel_dma_master_translator/
mkdir -p ./libraries/tda/
mkdir -p ./libraries/slave_translator/
mkdir -p ./libraries/tdt/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/nios2_qsys_0_custom_instruction_master_comb_slave_translator0/
mkdir -p ./libraries/nios2_qsys_0_custom_instruction_master_comb_xconnect/
mkdir -p ./libraries/nios2_qsys_0_custom_instruction_master_translator/
mkdir -p ./libraries/video_vga_controller_0/
mkdir -p ./libraries/video_rgb_resampler_0/
mkdir -p ./libraries/video_pixel_buffer_dma_0/
mkdir -p ./libraries/video_dual_clock_buffer_0/
mkdir -p ./libraries/video_character_buffer_with_dma_0/
mkdir -p ./libraries/video_alpha_blender_0/
mkdir -p ./libraries/tristate_conduit_bridge_0/
mkdir -p ./libraries/timer_0/
mkdir -p ./libraries/sram_0/
mkdir -p ./libraries/performance_counter_0/
mkdir -p ./libraries/nn_acc_single_buffer_version_1/
mkdir -p ./libraries/nios2_qsys_0/
mkdir -p ./libraries/new_sdram_controller_0/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/generic_tristate_controller_0/
mkdir -p ./libraries/floating_point_multiplier_0/
mkdir -p ./libraries/floating_point_adder_0/
mkdir -p ./libraries/dma_0/
mkdir -p ./libraries/tristate_conduit_bridge_0_tcb_translator/
mkdir -p ./libraries/nios_system_inst_reset_0_bfm/
mkdir -p ./libraries/nios_system_inst_clk_0_bfm/
mkdir -p ./libraries/nios_system_inst/
mkdir -p ./libraries/new_sdram_controller_0_my_partner/
mkdir -p ./libraries/generic_tristate_controller_0_external_mem_bfm/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneive_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_char_mode_rom_128.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_fb_color_rom.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ociram_default_contents.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ociram_default_contents.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ociram_default_contents.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_dc_tag_ram.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_dc_tag_ram.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_dc_tag_ram.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_b.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_b.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_b.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_a.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_a.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_rf_ram_a.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_bht_ram.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_bht_ram.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_bht_ram.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ic_tag_ram.hex ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ic_tag_ram.dat ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_ic_tag_ram.mif ./
  cp -f $QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_external_memory_bfm.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.v"  -work cycloneive_ver  
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/verbosity_pkg.sv"                                                       -work altera_common_sv_packages                                             
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_002_error_adapter_0.sv" -work error_adapter_0                                                       
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv" -work error_adapter_0                                                       
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -work error_adapter_0                                                       
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_002.v"                  -work avalon_st_adapter_002                                                 
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_001.v"                  -work avalon_st_adapter_001                                                 
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_avalon_st_adapter.v"                      -work avalon_st_adapter                                                     
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_width_adapter.sv"                                         -work nios2_qsys_0_data_master_to_sram_0_avalon_sram_slave_cmd_width_adapter
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_address_alignment.sv"                                     -work nios2_qsys_0_data_master_to_sram_0_avalon_sram_slave_cmd_width_adapter
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_uncompressor.sv"                                    -work nios2_qsys_0_data_master_to_sram_0_avalon_sram_slave_cmd_width_adapter
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_mux_003.sv"                           -work rsp_mux_003                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work rsp_mux_003                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_mux_002.sv"                           -work rsp_mux_002                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work rsp_mux_002                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_mux_001.sv"                           -work rsp_mux_001                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work rsp_mux_001                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_mux.sv"                               -work rsp_mux                                                               
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work rsp_mux                                                               
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_demux_009.sv"                         -work rsp_demux_009                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_demux_005.sv"                         -work rsp_demux_005                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_demux_002.sv"                         -work rsp_demux_002                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_demux_001.sv"                         -work rsp_demux_001                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_rsp_demux.sv"                             -work rsp_demux                                                             
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux_009.sv"                           -work cmd_mux_009                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux_009                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux_008.sv"                           -work cmd_mux_008                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux_008                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux_005.sv"                           -work cmd_mux_005                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux_005                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux_002.sv"                           -work cmd_mux_002                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux_002                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux_001.sv"                           -work cmd_mux_001                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux_001                                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_mux.sv"                               -work cmd_mux                                                               
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                            -work cmd_mux                                                               
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_demux_004.sv"                         -work cmd_demux_004                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_demux_003.sv"                         -work cmd_demux_003                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_demux_002.sv"                         -work cmd_demux_002                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_demux_001.sv"                         -work cmd_demux_001                                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_cmd_demux.sv"                             -work cmd_demux                                                             
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_adapter.sv"                                         -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                  -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_adapter_13_1.sv"                                    -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_adapter_new.sv"                                     -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_incr_burst_converter.sv"                                         -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_wrap_burst_converter.sv"                                         -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_default_burst_converter.sv"                                      -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_address_alignment.sv"                                     -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_st_pipeline_stage.sv"                                     -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                                       -work sram_0_avalon_sram_slave_burst_adapter                                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_traffic_limiter.sv"                                       -work nios2_qsys_0_data_master_limiter                                      
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_reorder_memory.sv"                                        -work nios2_qsys_0_data_master_limiter                                      
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                                -work nios2_qsys_0_data_master_limiter                                      
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                                       -work nios2_qsys_0_data_master_limiter                                      
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_014.sv"                            -work router_014                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_013.sv"                            -work router_013                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_010.sv"                            -work router_010                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_007.sv"                            -work router_007                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_006.sv"                            -work router_006                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_005.sv"                            -work router_005                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_003.sv"                            -work router_003                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_002.sv"                            -work router_002                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router_001.sv"                            -work router_001                                                            
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0_router.sv"                                -work router                                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                                -work sram_0_avalon_sram_slave_agent_rsp_fifo                               
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_slave_agent.sv"                                           -work sram_0_avalon_sram_slave_agent                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_burst_uncompressor.sv"                                    -work sram_0_avalon_sram_slave_agent                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_master_agent.sv"                                          -work video_pixel_buffer_dma_0_avalon_pixel_dma_master_agent                
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_master_translator.sv"                                     -work video_pixel_buffer_dma_0_avalon_pixel_dma_master_translator           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_tristate_controller_aggregator.sv"                               -work tda                                                                   
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_merlin_slave_translator.sv"                                      -work slave_translator                                                      
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_tristate_controller_translator.sv"                               -work tdt                                                                   
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_reset_controller.v"                                              -work rst_controller                                                        
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_reset_synchronizer.v"                                            -work rst_controller                                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_irq_mapper.sv"                                              -work irq_mapper                                                            
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_mm_interconnect_0.v"                                        -work mm_interconnect_0                                                     
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_customins_slave_translator.sv"                                   -work nios2_qsys_0_custom_instruction_master_comb_slave_translator0         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_custom_instruction_master_comb_xconnect.sv"    -work nios2_qsys_0_custom_instruction_master_comb_xconnect                  
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_customins_master_translator.v"                                   -work nios2_qsys_0_custom_instruction_master_translator                     
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_avalon_video_vga_timing.v"                                    -work video_vga_controller_0                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_vga_controller_0.v"                                   -work video_vga_controller_0                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_rgb_resampler_0.v"                                    -work video_rgb_resampler_0                                                 
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_pixel_buffer_dma_0.v"                                 -work video_pixel_buffer_dma_0                                              
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_dual_clock_buffer_0.v"                                -work video_dual_clock_buffer_0                                             
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_128_character_rom.v"                                    -work video_character_buffer_with_dma_0                                     
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_fb_color_rom.v"                                         -work video_character_buffer_with_dma_0                                     
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_character_buffer_with_dma_0.v"                        -work video_character_buffer_with_dma_0                                     
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_alpha_blender_normal.v"                                 -work video_alpha_blender_0                                                 
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_up_video_alpha_blender_simple.v"                                 -work video_alpha_blender_0                                                 
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_video_alpha_blender_0.v"                                    -work video_alpha_blender_0                                                 
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_tristate_conduit_bridge_0.sv"                               -work tristate_conduit_bridge_0                                             
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_timer_0.v"                                                  -work timer_0                                                               
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_sram_0.v"                                                   -work sram_0                                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_performance_counter_0.v"                                    -work performance_counter_0                                                 
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/data_buffer.sv"                                                         -work nn_acc_single_buffer_version_1                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/fp_adder.sv"                                                            -work nn_acc_single_buffer_version_1                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/fp_multiplier.sv"                                                       -work nn_acc_single_buffer_version_1                                        
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nn_acc_single_non_burst.sv"                                             -work nn_acc_single_buffer_version_1                                        
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0.vo"                                            -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_jtag_debug_module_wrapper.v"                   -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_jtag_debug_module_sysclk.v"                    -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_jtag_debug_module_tck.v"                       -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_oci_test_bench.v"                              -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_mult_cell.v"                                   -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_nios2_qsys_0_test_bench.v"                                  -work nios2_qsys_0                                                          
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_new_sdram_controller_0_test_component.v"                    -work new_sdram_controller_0                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_new_sdram_controller_0.v"                                   -work new_sdram_controller_0                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_jtag_uart_0.v"                                              -work jtag_uart_0                                                           
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_generic_tristate_controller_0.v"                            -work generic_tristate_controller_0                                         
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/fp_multiplier.sv"                                                       -work floating_point_multiplier_0                                           
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/fp_adder.sv"                                                            -work floating_point_adder_0                                                
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system_dma_0.v"                                                    -work dma_0                                                                 
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_inout.sv"                                                        -work tristate_conduit_bridge_0_tcb_translator                              
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_tristate_conduit_bridge_translator.sv"                           -work tristate_conduit_bridge_0_tcb_translator                              
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_reset_source.sv"                                          -work nios_system_inst_reset_0_bfm                                          
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_avalon_clock_source.sv"                                          -work nios_system_inst_clk_0_bfm                                            
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/nios_system.v"                                                          -work nios_system_inst                                                      
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_sdram_partner_module.v"                                          -work new_sdram_controller_0_my_partner                                     
  vlogan +v2k -sverilog $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/nios_system_tb/simulation/submodules/altera_external_memory_bfm.sv"                                          -work generic_tristate_controller_0_external_mem_bfm                        
  vlogan +v2k $USER_DEFINED_COMPILE_OPTIONS           "$QSYS_SIMDIR/nios_system_tb/simulation/nios_system_tb.v"                                                                                                                                              
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi

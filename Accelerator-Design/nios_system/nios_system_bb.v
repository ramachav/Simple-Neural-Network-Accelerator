
module nios_system (
	clk_clk,
	clk_0_clk,
	new_sdram_controller_0_wire_addr,
	new_sdram_controller_0_wire_ba,
	new_sdram_controller_0_wire_cas_n,
	new_sdram_controller_0_wire_cke,
	new_sdram_controller_0_wire_cs_n,
	new_sdram_controller_0_wire_dq,
	new_sdram_controller_0_wire_dqm,
	new_sdram_controller_0_wire_ras_n,
	new_sdram_controller_0_wire_we_n,
	reset_reset_n,
	reset_0_reset_n,
	sram_0_external_interface_DQ,
	sram_0_external_interface_ADDR,
	sram_0_external_interface_LB_N,
	sram_0_external_interface_UB_N,
	sram_0_external_interface_CE_N,
	sram_0_external_interface_OE_N,
	sram_0_external_interface_WE_N,
	tristate_conduit_bridge_0_out_tcm_address_out,
	tristate_conduit_bridge_0_out_tcm_read_n_out,
	tristate_conduit_bridge_0_out_tcm_write_n_out,
	tristate_conduit_bridge_0_out_tcm_data_out,
	tristate_conduit_bridge_0_out_tcm_chipselect_n_out,
	video_vga_controller_0_external_interface_CLK,
	video_vga_controller_0_external_interface_HS,
	video_vga_controller_0_external_interface_VS,
	video_vga_controller_0_external_interface_BLANK,
	video_vga_controller_0_external_interface_SYNC,
	video_vga_controller_0_external_interface_R,
	video_vga_controller_0_external_interface_G,
	video_vga_controller_0_external_interface_B);	

	input		clk_clk;
	input		clk_0_clk;
	output	[12:0]	new_sdram_controller_0_wire_addr;
	output	[1:0]	new_sdram_controller_0_wire_ba;
	output		new_sdram_controller_0_wire_cas_n;
	output		new_sdram_controller_0_wire_cke;
	output		new_sdram_controller_0_wire_cs_n;
	inout	[31:0]	new_sdram_controller_0_wire_dq;
	output	[3:0]	new_sdram_controller_0_wire_dqm;
	output		new_sdram_controller_0_wire_ras_n;
	output		new_sdram_controller_0_wire_we_n;
	input		reset_reset_n;
	input		reset_0_reset_n;
	inout	[15:0]	sram_0_external_interface_DQ;
	output	[19:0]	sram_0_external_interface_ADDR;
	output		sram_0_external_interface_LB_N;
	output		sram_0_external_interface_UB_N;
	output		sram_0_external_interface_CE_N;
	output		sram_0_external_interface_OE_N;
	output		sram_0_external_interface_WE_N;
	output	[22:0]	tristate_conduit_bridge_0_out_tcm_address_out;
	output	[0:0]	tristate_conduit_bridge_0_out_tcm_read_n_out;
	output	[0:0]	tristate_conduit_bridge_0_out_tcm_write_n_out;
	inout	[7:0]	tristate_conduit_bridge_0_out_tcm_data_out;
	output	[0:0]	tristate_conduit_bridge_0_out_tcm_chipselect_n_out;
	output		video_vga_controller_0_external_interface_CLK;
	output		video_vga_controller_0_external_interface_HS;
	output		video_vga_controller_0_external_interface_VS;
	output		video_vga_controller_0_external_interface_BLANK;
	output		video_vga_controller_0_external_interface_SYNC;
	output	[7:0]	video_vga_controller_0_external_interface_R;
	output	[7:0]	video_vga_controller_0_external_interface_G;
	output	[7:0]	video_vga_controller_0_external_interface_B;
endmodule

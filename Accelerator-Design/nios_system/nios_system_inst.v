	nios_system u0 (
		.clk_clk                                            (<connected-to-clk_clk>),                                            //                                       clk.clk
		.clk_0_clk                                          (<connected-to-clk_0_clk>),                                          //                                     clk_0.clk
		.new_sdram_controller_0_wire_addr                   (<connected-to-new_sdram_controller_0_wire_addr>),                   //               new_sdram_controller_0_wire.addr
		.new_sdram_controller_0_wire_ba                     (<connected-to-new_sdram_controller_0_wire_ba>),                     //                                          .ba
		.new_sdram_controller_0_wire_cas_n                  (<connected-to-new_sdram_controller_0_wire_cas_n>),                  //                                          .cas_n
		.new_sdram_controller_0_wire_cke                    (<connected-to-new_sdram_controller_0_wire_cke>),                    //                                          .cke
		.new_sdram_controller_0_wire_cs_n                   (<connected-to-new_sdram_controller_0_wire_cs_n>),                   //                                          .cs_n
		.new_sdram_controller_0_wire_dq                     (<connected-to-new_sdram_controller_0_wire_dq>),                     //                                          .dq
		.new_sdram_controller_0_wire_dqm                    (<connected-to-new_sdram_controller_0_wire_dqm>),                    //                                          .dqm
		.new_sdram_controller_0_wire_ras_n                  (<connected-to-new_sdram_controller_0_wire_ras_n>),                  //                                          .ras_n
		.new_sdram_controller_0_wire_we_n                   (<connected-to-new_sdram_controller_0_wire_we_n>),                   //                                          .we_n
		.reset_reset_n                                      (<connected-to-reset_reset_n>),                                      //                                     reset.reset_n
		.reset_0_reset_n                                    (<connected-to-reset_0_reset_n>),                                    //                                   reset_0.reset_n
		.sram_0_external_interface_DQ                       (<connected-to-sram_0_external_interface_DQ>),                       //                 sram_0_external_interface.DQ
		.sram_0_external_interface_ADDR                     (<connected-to-sram_0_external_interface_ADDR>),                     //                                          .ADDR
		.sram_0_external_interface_LB_N                     (<connected-to-sram_0_external_interface_LB_N>),                     //                                          .LB_N
		.sram_0_external_interface_UB_N                     (<connected-to-sram_0_external_interface_UB_N>),                     //                                          .UB_N
		.sram_0_external_interface_CE_N                     (<connected-to-sram_0_external_interface_CE_N>),                     //                                          .CE_N
		.sram_0_external_interface_OE_N                     (<connected-to-sram_0_external_interface_OE_N>),                     //                                          .OE_N
		.sram_0_external_interface_WE_N                     (<connected-to-sram_0_external_interface_WE_N>),                     //                                          .WE_N
		.tristate_conduit_bridge_0_out_tcm_address_out      (<connected-to-tristate_conduit_bridge_0_out_tcm_address_out>),      //             tristate_conduit_bridge_0_out.tcm_address_out
		.tristate_conduit_bridge_0_out_tcm_read_n_out       (<connected-to-tristate_conduit_bridge_0_out_tcm_read_n_out>),       //                                          .tcm_read_n_out
		.tristate_conduit_bridge_0_out_tcm_write_n_out      (<connected-to-tristate_conduit_bridge_0_out_tcm_write_n_out>),      //                                          .tcm_write_n_out
		.tristate_conduit_bridge_0_out_tcm_data_out         (<connected-to-tristate_conduit_bridge_0_out_tcm_data_out>),         //                                          .tcm_data_out
		.tristate_conduit_bridge_0_out_tcm_chipselect_n_out (<connected-to-tristate_conduit_bridge_0_out_tcm_chipselect_n_out>), //                                          .tcm_chipselect_n_out
		.video_vga_controller_0_external_interface_CLK      (<connected-to-video_vga_controller_0_external_interface_CLK>),      // video_vga_controller_0_external_interface.CLK
		.video_vga_controller_0_external_interface_HS       (<connected-to-video_vga_controller_0_external_interface_HS>),       //                                          .HS
		.video_vga_controller_0_external_interface_VS       (<connected-to-video_vga_controller_0_external_interface_VS>),       //                                          .VS
		.video_vga_controller_0_external_interface_BLANK    (<connected-to-video_vga_controller_0_external_interface_BLANK>),    //                                          .BLANK
		.video_vga_controller_0_external_interface_SYNC     (<connected-to-video_vga_controller_0_external_interface_SYNC>),     //                                          .SYNC
		.video_vga_controller_0_external_interface_R        (<connected-to-video_vga_controller_0_external_interface_R>),        //                                          .R
		.video_vga_controller_0_external_interface_G        (<connected-to-video_vga_controller_0_external_interface_G>),        //                                          .G
		.video_vga_controller_0_external_interface_B        (<connected-to-video_vga_controller_0_external_interface_B>)         //                                          .B
	);


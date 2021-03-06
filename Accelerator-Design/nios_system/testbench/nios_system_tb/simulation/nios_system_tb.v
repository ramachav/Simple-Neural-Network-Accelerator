// nios_system_tb.v

// Generated using ACDS version 17.0 595

`timescale 1 ps / 1 ps
module nios_system_tb (
	);

	wire         nios_system_inst_clk_bfm_clk_clk;                                    // nios_system_inst_clk_bfm:clk -> [generic_tristate_controller_0_external_mem_bfm:clk, new_sdram_controller_0_my_partner:clk, nios_system_inst:clk_clk, nios_system_inst_reset_0_bfm:clk, nios_system_inst_reset_bfm:clk]
	wire         nios_system_inst_clk_0_bfm_clk_clk;                                  // nios_system_inst_clk_0_bfm:clk -> nios_system_inst:clk_0_clk
	wire         nios_system_inst_new_sdram_controller_0_wire_cs_n;                   // nios_system_inst:new_sdram_controller_0_wire_cs_n -> new_sdram_controller_0_my_partner:zs_cs_n
	wire   [3:0] nios_system_inst_new_sdram_controller_0_wire_dqm;                    // nios_system_inst:new_sdram_controller_0_wire_dqm -> new_sdram_controller_0_my_partner:zs_dqm
	wire         nios_system_inst_new_sdram_controller_0_wire_cas_n;                  // nios_system_inst:new_sdram_controller_0_wire_cas_n -> new_sdram_controller_0_my_partner:zs_cas_n
	wire         nios_system_inst_new_sdram_controller_0_wire_ras_n;                  // nios_system_inst:new_sdram_controller_0_wire_ras_n -> new_sdram_controller_0_my_partner:zs_ras_n
	wire         nios_system_inst_new_sdram_controller_0_wire_we_n;                   // nios_system_inst:new_sdram_controller_0_wire_we_n -> new_sdram_controller_0_my_partner:zs_we_n
	wire  [12:0] nios_system_inst_new_sdram_controller_0_wire_addr;                   // nios_system_inst:new_sdram_controller_0_wire_addr -> new_sdram_controller_0_my_partner:zs_addr
	wire         nios_system_inst_new_sdram_controller_0_wire_cke;                    // nios_system_inst:new_sdram_controller_0_wire_cke -> new_sdram_controller_0_my_partner:zs_cke
	wire  [31:0] new_sdram_controller_0_my_partner_conduit_dq;                        // [] -> [new_sdram_controller_0_my_partner:zs_dq, nios_system_inst:new_sdram_controller_0_wire_dq]
	wire   [1:0] nios_system_inst_new_sdram_controller_0_wire_ba;                     // nios_system_inst:new_sdram_controller_0_wire_ba -> new_sdram_controller_0_my_partner:zs_ba
	wire   [0:0] tristate_conduit_bridge_0_tcb_translator_out_tcm_chipselect_n_out;   // tristate_conduit_bridge_0_tcb_translator:tcm_chipselect_n_out -> generic_tristate_controller_0_external_mem_bfm:cdt_chipselect
	wire  [22:0] tristate_conduit_bridge_0_tcb_translator_out_tcm_address_out;        // tristate_conduit_bridge_0_tcb_translator:tcm_address_out -> generic_tristate_controller_0_external_mem_bfm:cdt_address
	wire   [7:0] generic_tristate_controller_0_external_mem_bfm_conduit_tcm_data_out; // [] -> [generic_tristate_controller_0_external_mem_bfm:cdt_data_io, tristate_conduit_bridge_0_tcb_translator:tcm_data_out]
	wire   [0:0] tristate_conduit_bridge_0_tcb_translator_out_tcm_read_n_out;         // tristate_conduit_bridge_0_tcb_translator:tcm_read_n_out -> generic_tristate_controller_0_external_mem_bfm:cdt_read
	wire   [0:0] tristate_conduit_bridge_0_tcb_translator_out_tcm_write_n_out;        // tristate_conduit_bridge_0_tcb_translator:tcm_write_n_out -> generic_tristate_controller_0_external_mem_bfm:cdt_write
	wire   [0:0] nios_system_inst_tristate_conduit_bridge_0_out_tcm_chipselect_n_out; // nios_system_inst:tristate_conduit_bridge_0_out_tcm_chipselect_n_out -> tristate_conduit_bridge_0_tcb_translator:in_tcm_chipselect_n_out
	wire  [22:0] nios_system_inst_tristate_conduit_bridge_0_out_tcm_address_out;      // nios_system_inst:tristate_conduit_bridge_0_out_tcm_address_out -> tristate_conduit_bridge_0_tcb_translator:in_tcm_address_out
	wire   [7:0] nios_system_inst_tristate_conduit_bridge_0_out_tcm_data_out;         // [] -> [nios_system_inst:tristate_conduit_bridge_0_out_tcm_data_out, tristate_conduit_bridge_0_tcb_translator:in_tcm_data_out]
	wire   [0:0] nios_system_inst_tristate_conduit_bridge_0_out_tcm_read_n_out;       // nios_system_inst:tristate_conduit_bridge_0_out_tcm_read_n_out -> tristate_conduit_bridge_0_tcb_translator:in_tcm_read_n_out
	wire   [0:0] nios_system_inst_tristate_conduit_bridge_0_out_tcm_write_n_out;      // nios_system_inst:tristate_conduit_bridge_0_out_tcm_write_n_out -> tristate_conduit_bridge_0_tcb_translator:in_tcm_write_n_out
	wire         nios_system_inst_reset_bfm_reset_reset;                              // nios_system_inst_reset_bfm:reset -> nios_system_inst:reset_reset_n
	wire         nios_system_inst_reset_0_bfm_reset_reset;                            // nios_system_inst_reset_0_bfm:reset -> nios_system_inst:reset_0_reset_n

	altera_external_memory_bfm #(
		.USE_CHIPSELECT           (1),
		.USE_WRITE                (1),
		.USE_READ                 (1),
		.USE_OUTPUTENABLE         (0),
		.USE_BEGINTRANSFER        (0),
		.ACTIVE_LOW_BYTEENABLE    (0),
		.ACTIVE_LOW_CHIPSELECT    (1),
		.ACTIVE_LOW_WRITE         (1),
		.ACTIVE_LOW_READ          (1),
		.ACTIVE_LOW_OUTPUTENABLE  (0),
		.ACTIVE_LOW_BEGINTRANSFER (0),
		.ACTIVE_LOW_RESET         (0),
		.CDT_ADDRESS_W            (23),
		.CDT_SYMBOL_W             (8),
		.CDT_NUMSYMBOLS           (1),
		.INIT_FILE                ("altera_external_memory_bfm.hex"),
		.CDT_READ_LATENCY         (0),
		.VHDL_ID                  (0)
	) generic_tristate_controller_0_external_mem_bfm (
		.clk               (nios_system_inst_clk_bfm_clk_clk),                                    //     clk.clk
		.cdt_write         (tristate_conduit_bridge_0_tcb_translator_out_tcm_write_n_out),        // conduit.tcm_write_n_out
		.cdt_read          (tristate_conduit_bridge_0_tcb_translator_out_tcm_read_n_out),         //        .tcm_read_n_out
		.cdt_chipselect    (tristate_conduit_bridge_0_tcb_translator_out_tcm_chipselect_n_out),   //        .tcm_chipselect_n_out
		.cdt_address       (tristate_conduit_bridge_0_tcb_translator_out_tcm_address_out),        //        .tcm_address_out
		.cdt_data_io       (generic_tristate_controller_0_external_mem_bfm_conduit_tcm_data_out), //        .tcm_data_out
		.cdt_outputenable  (1'b0),                                                                // (terminated)
		.cdt_begintransfer (1'b0),                                                                // (terminated)
		.cdt_byteenable    (1'b1),                                                                // (terminated)
		.cdt_reset         (1'b0)                                                                 // (terminated)
	);

	altera_sdram_partner_module new_sdram_controller_0_my_partner (
		.clk      (nios_system_inst_clk_bfm_clk_clk),                   //     clk.clk
		.zs_dq    (new_sdram_controller_0_my_partner_conduit_dq),       // conduit.dq
		.zs_addr  (nios_system_inst_new_sdram_controller_0_wire_addr),  //        .addr
		.zs_ba    (nios_system_inst_new_sdram_controller_0_wire_ba),    //        .ba
		.zs_cas_n (nios_system_inst_new_sdram_controller_0_wire_cas_n), //        .cas_n
		.zs_cke   (nios_system_inst_new_sdram_controller_0_wire_cke),   //        .cke
		.zs_cs_n  (nios_system_inst_new_sdram_controller_0_wire_cs_n),  //        .cs_n
		.zs_dqm   (nios_system_inst_new_sdram_controller_0_wire_dqm),   //        .dqm
		.zs_ras_n (nios_system_inst_new_sdram_controller_0_wire_ras_n), //        .ras_n
		.zs_we_n  (nios_system_inst_new_sdram_controller_0_wire_we_n)   //        .we_n
	);

	nios_system nios_system_inst (
		.clk_clk                                            (nios_system_inst_clk_bfm_clk_clk),                                    //                                       clk.clk
		.clk_0_clk                                          (nios_system_inst_clk_0_bfm_clk_clk),                                  //                                     clk_0.clk
		.new_sdram_controller_0_wire_addr                   (nios_system_inst_new_sdram_controller_0_wire_addr),                   //               new_sdram_controller_0_wire.addr
		.new_sdram_controller_0_wire_ba                     (nios_system_inst_new_sdram_controller_0_wire_ba),                     //                                          .ba
		.new_sdram_controller_0_wire_cas_n                  (nios_system_inst_new_sdram_controller_0_wire_cas_n),                  //                                          .cas_n
		.new_sdram_controller_0_wire_cke                    (nios_system_inst_new_sdram_controller_0_wire_cke),                    //                                          .cke
		.new_sdram_controller_0_wire_cs_n                   (nios_system_inst_new_sdram_controller_0_wire_cs_n),                   //                                          .cs_n
		.new_sdram_controller_0_wire_dq                     (new_sdram_controller_0_my_partner_conduit_dq),                        //                                          .dq
		.new_sdram_controller_0_wire_dqm                    (nios_system_inst_new_sdram_controller_0_wire_dqm),                    //                                          .dqm
		.new_sdram_controller_0_wire_ras_n                  (nios_system_inst_new_sdram_controller_0_wire_ras_n),                  //                                          .ras_n
		.new_sdram_controller_0_wire_we_n                   (nios_system_inst_new_sdram_controller_0_wire_we_n),                   //                                          .we_n
		.reset_reset_n                                      (nios_system_inst_reset_bfm_reset_reset),                              //                                     reset.reset_n
		.reset_0_reset_n                                    (nios_system_inst_reset_0_bfm_reset_reset),                            //                                   reset_0.reset_n
		.sram_0_external_interface_DQ                       (),                                                                    //                 sram_0_external_interface.DQ
		.sram_0_external_interface_ADDR                     (),                                                                    //                                          .ADDR
		.sram_0_external_interface_LB_N                     (),                                                                    //                                          .LB_N
		.sram_0_external_interface_UB_N                     (),                                                                    //                                          .UB_N
		.sram_0_external_interface_CE_N                     (),                                                                    //                                          .CE_N
		.sram_0_external_interface_OE_N                     (),                                                                    //                                          .OE_N
		.sram_0_external_interface_WE_N                     (),                                                                    //                                          .WE_N
		.tristate_conduit_bridge_0_out_tcm_address_out      (nios_system_inst_tristate_conduit_bridge_0_out_tcm_address_out),      //             tristate_conduit_bridge_0_out.tcm_address_out
		.tristate_conduit_bridge_0_out_tcm_read_n_out       (nios_system_inst_tristate_conduit_bridge_0_out_tcm_read_n_out),       //                                          .tcm_read_n_out
		.tristate_conduit_bridge_0_out_tcm_write_n_out      (nios_system_inst_tristate_conduit_bridge_0_out_tcm_write_n_out),      //                                          .tcm_write_n_out
		.tristate_conduit_bridge_0_out_tcm_data_out         (nios_system_inst_tristate_conduit_bridge_0_out_tcm_data_out),         //                                          .tcm_data_out
		.tristate_conduit_bridge_0_out_tcm_chipselect_n_out (nios_system_inst_tristate_conduit_bridge_0_out_tcm_chipselect_n_out), //                                          .tcm_chipselect_n_out
		.video_vga_controller_0_external_interface_CLK      (),                                                                    // video_vga_controller_0_external_interface.CLK
		.video_vga_controller_0_external_interface_HS       (),                                                                    //                                          .HS
		.video_vga_controller_0_external_interface_VS       (),                                                                    //                                          .VS
		.video_vga_controller_0_external_interface_BLANK    (),                                                                    //                                          .BLANK
		.video_vga_controller_0_external_interface_SYNC     (),                                                                    //                                          .SYNC
		.video_vga_controller_0_external_interface_R        (),                                                                    //                                          .R
		.video_vga_controller_0_external_interface_G        (),                                                                    //                                          .G
		.video_vga_controller_0_external_interface_B        ()                                                                     //                                          .B
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (25000000),
		.CLOCK_UNIT (1)
	) nios_system_inst_clk_0_bfm (
		.clk (nios_system_inst_clk_0_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) nios_system_inst_clk_bfm (
		.clk (nios_system_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) nios_system_inst_reset_0_bfm (
		.reset (nios_system_inst_reset_0_bfm_reset_reset), // reset.reset_n
		.clk   (nios_system_inst_clk_bfm_clk_clk)          //   clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) nios_system_inst_reset_bfm (
		.reset (nios_system_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (nios_system_inst_clk_bfm_clk_clk)        //   clk.clk
	);

	altera_tristate_conduit_bridge_translator tristate_conduit_bridge_0_tcb_translator (
		.in_tcm_address_out      (nios_system_inst_tristate_conduit_bridge_0_out_tcm_address_out),      //  in.tcm_address_out
		.in_tcm_read_n_out       (nios_system_inst_tristate_conduit_bridge_0_out_tcm_read_n_out),       //    .tcm_read_n_out
		.in_tcm_write_n_out      (nios_system_inst_tristate_conduit_bridge_0_out_tcm_write_n_out),      //    .tcm_write_n_out
		.in_tcm_data_out         (nios_system_inst_tristate_conduit_bridge_0_out_tcm_data_out),         //    .tcm_data_out
		.in_tcm_chipselect_n_out (nios_system_inst_tristate_conduit_bridge_0_out_tcm_chipselect_n_out), //    .tcm_chipselect_n_out
		.tcm_address_out         (tristate_conduit_bridge_0_tcb_translator_out_tcm_address_out),        // out.tcm_address_out
		.tcm_read_n_out          (tristate_conduit_bridge_0_tcb_translator_out_tcm_read_n_out),         //    .tcm_read_n_out
		.tcm_write_n_out         (tristate_conduit_bridge_0_tcb_translator_out_tcm_write_n_out),        //    .tcm_write_n_out
		.tcm_data_out            (generic_tristate_controller_0_external_mem_bfm_conduit_tcm_data_out), //    .tcm_data_out
		.tcm_chipselect_n_out    (tristate_conduit_bridge_0_tcb_translator_out_tcm_chipselect_n_out)    //    .tcm_chipselect_n_out
	);

endmodule

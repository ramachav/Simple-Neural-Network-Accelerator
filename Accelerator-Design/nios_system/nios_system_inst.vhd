	component nios_system is
		port (
			clk_clk                                            : in    std_logic                     := 'X';             -- clk
			clk_0_clk                                          : in    std_logic                     := 'X';             -- clk
			new_sdram_controller_0_wire_addr                   : out   std_logic_vector(12 downto 0);                    -- addr
			new_sdram_controller_0_wire_ba                     : out   std_logic_vector(1 downto 0);                     -- ba
			new_sdram_controller_0_wire_cas_n                  : out   std_logic;                                        -- cas_n
			new_sdram_controller_0_wire_cke                    : out   std_logic;                                        -- cke
			new_sdram_controller_0_wire_cs_n                   : out   std_logic;                                        -- cs_n
			new_sdram_controller_0_wire_dq                     : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			new_sdram_controller_0_wire_dqm                    : out   std_logic_vector(3 downto 0);                     -- dqm
			new_sdram_controller_0_wire_ras_n                  : out   std_logic;                                        -- ras_n
			new_sdram_controller_0_wire_we_n                   : out   std_logic;                                        -- we_n
			reset_reset_n                                      : in    std_logic                     := 'X';             -- reset_n
			reset_0_reset_n                                    : in    std_logic                     := 'X';             -- reset_n
			sram_0_external_interface_DQ                       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
			sram_0_external_interface_ADDR                     : out   std_logic_vector(19 downto 0);                    -- ADDR
			sram_0_external_interface_LB_N                     : out   std_logic;                                        -- LB_N
			sram_0_external_interface_UB_N                     : out   std_logic;                                        -- UB_N
			sram_0_external_interface_CE_N                     : out   std_logic;                                        -- CE_N
			sram_0_external_interface_OE_N                     : out   std_logic;                                        -- OE_N
			sram_0_external_interface_WE_N                     : out   std_logic;                                        -- WE_N
			tristate_conduit_bridge_0_out_tcm_address_out      : out   std_logic_vector(22 downto 0);                    -- tcm_address_out
			tristate_conduit_bridge_0_out_tcm_read_n_out       : out   std_logic_vector(0 downto 0);                     -- tcm_read_n_out
			tristate_conduit_bridge_0_out_tcm_write_n_out      : out   std_logic_vector(0 downto 0);                     -- tcm_write_n_out
			tristate_conduit_bridge_0_out_tcm_data_out         : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- tcm_data_out
			tristate_conduit_bridge_0_out_tcm_chipselect_n_out : out   std_logic_vector(0 downto 0);                     -- tcm_chipselect_n_out
			video_vga_controller_0_external_interface_CLK      : out   std_logic;                                        -- CLK
			video_vga_controller_0_external_interface_HS       : out   std_logic;                                        -- HS
			video_vga_controller_0_external_interface_VS       : out   std_logic;                                        -- VS
			video_vga_controller_0_external_interface_BLANK    : out   std_logic;                                        -- BLANK
			video_vga_controller_0_external_interface_SYNC     : out   std_logic;                                        -- SYNC
			video_vga_controller_0_external_interface_R        : out   std_logic_vector(7 downto 0);                     -- R
			video_vga_controller_0_external_interface_G        : out   std_logic_vector(7 downto 0);                     -- G
			video_vga_controller_0_external_interface_B        : out   std_logic_vector(7 downto 0)                      -- B
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk                                            => CONNECTED_TO_clk_clk,                                            --                                       clk.clk
			clk_0_clk                                          => CONNECTED_TO_clk_0_clk,                                          --                                     clk_0.clk
			new_sdram_controller_0_wire_addr                   => CONNECTED_TO_new_sdram_controller_0_wire_addr,                   --               new_sdram_controller_0_wire.addr
			new_sdram_controller_0_wire_ba                     => CONNECTED_TO_new_sdram_controller_0_wire_ba,                     --                                          .ba
			new_sdram_controller_0_wire_cas_n                  => CONNECTED_TO_new_sdram_controller_0_wire_cas_n,                  --                                          .cas_n
			new_sdram_controller_0_wire_cke                    => CONNECTED_TO_new_sdram_controller_0_wire_cke,                    --                                          .cke
			new_sdram_controller_0_wire_cs_n                   => CONNECTED_TO_new_sdram_controller_0_wire_cs_n,                   --                                          .cs_n
			new_sdram_controller_0_wire_dq                     => CONNECTED_TO_new_sdram_controller_0_wire_dq,                     --                                          .dq
			new_sdram_controller_0_wire_dqm                    => CONNECTED_TO_new_sdram_controller_0_wire_dqm,                    --                                          .dqm
			new_sdram_controller_0_wire_ras_n                  => CONNECTED_TO_new_sdram_controller_0_wire_ras_n,                  --                                          .ras_n
			new_sdram_controller_0_wire_we_n                   => CONNECTED_TO_new_sdram_controller_0_wire_we_n,                   --                                          .we_n
			reset_reset_n                                      => CONNECTED_TO_reset_reset_n,                                      --                                     reset.reset_n
			reset_0_reset_n                                    => CONNECTED_TO_reset_0_reset_n,                                    --                                   reset_0.reset_n
			sram_0_external_interface_DQ                       => CONNECTED_TO_sram_0_external_interface_DQ,                       --                 sram_0_external_interface.DQ
			sram_0_external_interface_ADDR                     => CONNECTED_TO_sram_0_external_interface_ADDR,                     --                                          .ADDR
			sram_0_external_interface_LB_N                     => CONNECTED_TO_sram_0_external_interface_LB_N,                     --                                          .LB_N
			sram_0_external_interface_UB_N                     => CONNECTED_TO_sram_0_external_interface_UB_N,                     --                                          .UB_N
			sram_0_external_interface_CE_N                     => CONNECTED_TO_sram_0_external_interface_CE_N,                     --                                          .CE_N
			sram_0_external_interface_OE_N                     => CONNECTED_TO_sram_0_external_interface_OE_N,                     --                                          .OE_N
			sram_0_external_interface_WE_N                     => CONNECTED_TO_sram_0_external_interface_WE_N,                     --                                          .WE_N
			tristate_conduit_bridge_0_out_tcm_address_out      => CONNECTED_TO_tristate_conduit_bridge_0_out_tcm_address_out,      --             tristate_conduit_bridge_0_out.tcm_address_out
			tristate_conduit_bridge_0_out_tcm_read_n_out       => CONNECTED_TO_tristate_conduit_bridge_0_out_tcm_read_n_out,       --                                          .tcm_read_n_out
			tristate_conduit_bridge_0_out_tcm_write_n_out      => CONNECTED_TO_tristate_conduit_bridge_0_out_tcm_write_n_out,      --                                          .tcm_write_n_out
			tristate_conduit_bridge_0_out_tcm_data_out         => CONNECTED_TO_tristate_conduit_bridge_0_out_tcm_data_out,         --                                          .tcm_data_out
			tristate_conduit_bridge_0_out_tcm_chipselect_n_out => CONNECTED_TO_tristate_conduit_bridge_0_out_tcm_chipselect_n_out, --                                          .tcm_chipselect_n_out
			video_vga_controller_0_external_interface_CLK      => CONNECTED_TO_video_vga_controller_0_external_interface_CLK,      -- video_vga_controller_0_external_interface.CLK
			video_vga_controller_0_external_interface_HS       => CONNECTED_TO_video_vga_controller_0_external_interface_HS,       --                                          .HS
			video_vga_controller_0_external_interface_VS       => CONNECTED_TO_video_vga_controller_0_external_interface_VS,       --                                          .VS
			video_vga_controller_0_external_interface_BLANK    => CONNECTED_TO_video_vga_controller_0_external_interface_BLANK,    --                                          .BLANK
			video_vga_controller_0_external_interface_SYNC     => CONNECTED_TO_video_vga_controller_0_external_interface_SYNC,     --                                          .SYNC
			video_vga_controller_0_external_interface_R        => CONNECTED_TO_video_vga_controller_0_external_interface_R,        --                                          .R
			video_vga_controller_0_external_interface_G        => CONNECTED_TO_video_vga_controller_0_external_interface_G,        --                                          .G
			video_vga_controller_0_external_interface_B        => CONNECTED_TO_video_vga_controller_0_external_interface_B         --                                          .B
		);


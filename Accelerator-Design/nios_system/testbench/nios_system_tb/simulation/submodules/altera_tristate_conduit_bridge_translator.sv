
`timescale 1 ns / 1 ns			    

module altera_tristate_conduit_bridge_translator (
                     input wire [23-1:0] in_tcm_address_out
                     ,output wire [23-1:0] tcm_address_out
                     ,input wire [1-1:0] in_tcm_read_n_out
                     ,output wire [1-1:0] tcm_read_n_out
                     ,input wire [1-1:0] in_tcm_write_n_out
                     ,output wire [1-1:0] tcm_write_n_out
                     ,inout wire [8-1:0] in_tcm_data_out
                     ,inout wire [8-1:0] tcm_data_out
                     ,input wire [1-1:0] in_tcm_chipselect_n_out
                     ,output wire [1-1:0] tcm_chipselect_n_out
		);
       assign tcm_address_out = in_tcm_address_out;
       assign tcm_read_n_out = in_tcm_read_n_out;
       assign tcm_write_n_out = in_tcm_write_n_out;
       altera_inout #(
           .WIDTH_A(8),
           .WIDTH_B(8)
       ) tcm_data_out_inout_module (
           .a(tcm_data_out),
           .b(in_tcm_data_out)
       );
       assign tcm_chipselect_n_out = in_tcm_chipselect_n_out;
endmodule


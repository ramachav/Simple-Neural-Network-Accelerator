// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



`timescale 1 ns / 1 ns

module altera_inout #(
                parameter WIDTH_A = 1,
		parameter WIDTH_B = 1
        ) (
                inout wire [WIDTH_A-1:0] a,
                inout wire [WIDTH_B-1:0] b
        );
	
	genvar i;

	generate
            if(WIDTH_A <= WIDTH_B) begin
	        for(i = 0; i < WIDTH_A; i++) begin : width_a_loop
		    tran (a[i],b[i]);
	        end
            end
	    else begin
		for(i = 0; i < WIDTH_B; i++) begin : width_b_loop
		    tran (a[i],b[i]);
	        end
	    end
	endgenerate

endmodule // altera_inout

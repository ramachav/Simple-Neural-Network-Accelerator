/*****************************************************************************
*  Pipeline Registers for the Accelerator				      _________      *
*  ECE 69500R SoC Architecture                                |       |	     *
*  Simple Neural Network Accelerator                          |   	  |	 	 *
*														      | 	  |	 	 *
*  Pipeline stages: MULTIPLY || ADDITION || SUM || ACCUMULATE |->|| RESULT	 *
*  Acronyms: MULTIPLY: mul, ADDITION: add, 								     *
*			 SUM: sum, ACCUMULATE: acc, RESULT: res				     	     *
*****************************************************************************/

module pipeline_registers (
	input logic  clk, 
	input logic  reset,
	//Stage 1 Registers (From MULTIPLY to ADDITION)
	input logic  stage_1_en,
	input logic  [31:0] muladd_in0, muladd_in1, muladd_in2, muladd_in3, muladd_in4, muladd_in5, muladd_in6, muladd_in7,
	output logic [31:0] muladd_out0, muladd_out1, muladd_out2, muladd_out3, muladd_out4, muladd_out5, muladd_out6, muladd_out7,
	//Stage 2 Registers (From ADDITION to SUM)
	input logic  stage_2_en,
	input logic  [31:0] addsum_in0, addsum_in1, addsum_in2, addsum_in3,
	output logic [31:0] addsum_out0, addsum_out1, addsum_out2, addsum_out3,
	//Stage 3 Registers (From SUM to ACCUMULATE)
	input logic stage_3_en,
	input logic  [31:0] sumacc_in0, sumacc_in1, 
	output logic [31:0] sumacc_out0, sumacc_out1,
	//Stage 4 Registers (From ACCUMULATE to RESULT)
	input logic stage_4_en,
	input logic [31:0] accres_in0, accres_in1,
	output logic [31:0] accres_out0, accres_out1,

	input logic accumulatorReset
);

//Stage 1 Registers
always_ff @ (posedge clk, posedge reset) begin 
	if(reset) begin 
		muladd_out0 <= '0;
		muladd_out1 <= '0;
		muladd_out2 <= '0;
		muladd_out3 <= '0;
		muladd_out4 <= '0;
		muladd_out5 <= '0;
		muladd_out6 <= '0;
		muladd_out7 <= '0;
	end 
	else if(stage_1_en) begin 
		muladd_out0 <= muladd_in0;
		muladd_out1 <= muladd_in1;
		muladd_out2 <= muladd_in2;
		muladd_out3 <= muladd_in3;
		muladd_out4 <= muladd_in4;
		muladd_out5 <= muladd_in5;
		muladd_out6 <= muladd_in6;
		muladd_out7 <= muladd_in7;
	end 
	else begin 
		muladd_out0 <= muladd_out0;
		muladd_out1 <= muladd_out1;
		muladd_out2 <= muladd_out2;
		muladd_out3 <= muladd_out3;
		muladd_out4 <= muladd_out4;
		muladd_out5 <= muladd_out5;
		muladd_out6 <= muladd_out6;
		muladd_out7 <= muladd_out7;
	end 
end 

//Stage 2 Registers
always_ff @ (posedge clk, posedge reset) begin 
	if(reset) begin 
		addsum_out0 <= '0;
		addsum_out1 <= '0;
		addsum_out2 <= '0;
		addsum_out3 <= '0;
	end 
	else if(stage_2_en) begin
		addsum_out0 <= addsum_in0;
		addsum_out1 <= addsum_in1;
		addsum_out2 <= addsum_in2;
		addsum_out3 <= addsum_in3;
	end 
	else begin 
		addsum_out0 <= addsum_out0;
		addsum_out1 <= addsum_out1;
		addsum_out2 <= addsum_out2;
		addsum_out3 <= addsum_out3;
	end 
end 

//Stage 3 Registers
always_ff @ (posedge clk, posedge reset) begin 
	if(reset) begin 
		sumacc_out0 <= '0;
		sumacc_out1 <= '0;
	end 
	else if(stage_3_en) begin 
		sumacc_out0 <= sumacc_in0;
		sumacc_out1 <= sumacc_in1;
	end 
	else begin
		sumacc_out0 <= sumacc_out0;
		sumacc_out1 <= sumacc_out1;
	end 
end

//Stage 4 Registers
always_ff @ (posedge clk, posedge reset) begin 
	if(reset) begin 
		accres_out0 <= '0;
		accres_out1 <= '0;
	end 
	else if(accumulatorReset) begin
		accres_out0 <= accres_in0;
		accres_out1 <= '0;
	end 
	else if(stage_4_en) begin 
		accres_out0 <= accres_in0;
		accres_out1 <= accres_in1;
	end 
	else begin
		accres_out0 <= accres_out0;
		accres_out1 <= accres_out1;
	end 
end

endmodule
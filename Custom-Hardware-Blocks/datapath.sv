/*****************************************************************************
*  Datapath for the Accelerator				 			      _________      *
*  ECE 69500R SoC Architecture                                |       |	     *
*  Simple Neural Network Accelerator                          |   	  |	 	 *
*														      | 	  |	 	 *
*  Pipeline stages: MULTIPLY || ADDITION || SUM || ACCUMULATE |->|| RESULT	 *
*  Acronyms: MULTIPLY: mul, ADDITION: add, 								     *
*			 SUM: sum, ACCUMULATE: acc, RESULT: res				     	     *
*****************************************************************************/

module datapath (
	input logic clk,
	input logic reset,
	//Pipeline Register Enables
	input logic stage_1_en, stage_2_en, stage_3_en, stage_4_en,
	//MULTIPLY Stage Inputs
	input logic [31:0] mul0_in0, mul0_in1,
	input logic [31:0] mul1_in0, mul1_in1,
	input logic [31:0] mul2_in0, mul2_in1,
	input logic [31:0] mul3_in0, mul3_in1,
	input logic [31:0] mul4_in0, mul4_in1,
	input logic [31:0] mul5_in0, mul5_in1,
	input logic [31:0] mul6_in0, mul6_in1,
	input logic [31:0] mul7_in0, mul7_in1,
	input logic accumulatorReset,
	output logic [31:0] result
);
	
	//MULTIPLY Stage Outputs
	logic [31:0] mul0_out, mul1_out, mul2_out, mul3_out, mul4_out, mul5_out, mul6_out, mul7_out;
	//ADDITION Stage Inputs/Outputs
	logic [31:0] add0_in0, add0_in1, add1_in0, add1_in1, add2_in0, add2_in1, add3_in0, add3_in1;
	logic [31:0] add0_out, add1_out, add2_out, add3_out;
	//SUM Stage Inputs/Outputs
	logic [31:0] sum0_in0, sum0_in1, sum1_in0, sum1_in1;
	logic [31:0] sum0_out, sum1_out;
	//ACCUMULATION Stage Inputs/Outputs
	logic [31:0] acc0_in0, acc0_in1;
	logic[31:0] acc0_out;
	//RESULT Stage Inputs/Outputs
	logic [31:0] res0_in0, res0_in1;
	logic [31:0] res0_out;

	//MULTIPLY Stage Multipliers
	fp_multiplier FLOATING_POINT_MULTIPLY_0 (.dataa(mul0_in0), .datab(mul0_in1), .result(mul0_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_1 (.dataa(mul1_in0), .datab(mul1_in1), .result(mul1_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_2 (.dataa(mul2_in0), .datab(mul2_in1), .result(mul2_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_3 (.dataa(mul3_in0), .datab(mul3_in1), .result(mul3_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_4 (.dataa(mul4_in0), .datab(mul4_in1), .result(mul4_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_5 (.dataa(mul5_in0), .datab(mul5_in1), .result(mul5_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_6 (.dataa(mul6_in0), .datab(mul6_in1), .result(mul6_out));
	fp_multiplier FLOATING_POINT_MULTIPLY_7 (.dataa(mul7_in0), .datab(mul7_in1), .result(mul7_out));

	//ADDITION Stage Adders
	fp_adder FLOATING_POINT_ADDITION_0   (.dataa(add0_in0), .datab(add0_in1), .result(add0_out));
	fp_adder FLOATING_POINT_ADDITION_1   (.dataa(add1_in0), .datab(add1_in1), .result(add1_out));
	fp_adder FLOATING_POINT_ADDITION_3   (.dataa(add2_in0), .datab(add2_in1), .result(add2_out));
	fp_adder FLOATING_POINT_ADDITION_2   (.dataa(add3_in0), .datab(add3_in1), .result(add3_out));

	//SUM Stage Adders
	fp_adder FLOATING_POINT_SUM_0 	     (.dataa(sum0_in0), .datab(sum0_in1), .result(sum0_out));
	fp_adder FLOATING_POINT_SUM_1 	     (.dataa(sum1_in0), .datab(sum1_in1), .result(sum1_out));

	//ACCUMULATE Stage Adder
	fp_adder FLOATING_POINT_ACCUMULATE_0 (.dataa(acc0_in0), .datab(acc0_in1), .result(acc0_out));

	//RESULT Stage Adder
	fp_adder FLOATING_POINT_RESULT_0     (.dataa(res0_in0), .datab(res0_in1), .result(res0_out));

	//Pipeline Registers
	pipeline_registers PIPELINE_REGISTERS (
		.clk(clk), .reset(reset),
		//Stage 1 Registers
		.stage_1_en(stage_1_en), .muladd_in0(mul0_out), .muladd_in1(mul1_out), .muladd_in2(mul2_out), .muladd_in3(mul3_out), .muladd_in4(mul4_out), .muladd_in5(mul5_out), .muladd_in6(mul6_out), .muladd_in7(mul7_out),
		.muladd_out0(add0_in0), .muladd_out1(add0_in1), .muladd_out2(add1_in0), .muladd_out3(add1_in1), .muladd_out4(add2_in0), .muladd_out5(add2_in1), .muladd_out6(add3_in0), .muladd_out7(add3_in1),
		//Stage 2 Registers
		.stage_2_en(stage_2_en), .addsum_in0(add0_out), .addsum_in1(add1_out), .addsum_in2(add2_out), .addsum_in3(add3_out),
		.addsum_out0(sum0_in0), .addsum_out1(sum0_in1), .addsum_out2(sum1_in0), .addsum_out3(sum1_in1),
		//Stage 3 Registers
		.stage_3_en(stage_3_en), .sumacc_in0(sum0_out), .sumacc_in1(sum1_out),
		.sumacc_out0(acc0_in0), .sumacc_out1(acc0_in1),
		//Stage 4 Registers
		.stage_4_en(stage_4_en), .accres_in0(acc0_out), .accres_in1(res0_out),
		.accres_out0(res0_in0), .accres_out1(res0_in1),

		.accumulatorReset(accumulatorReset)
	);

	assign result = res0_out;	

endmodule

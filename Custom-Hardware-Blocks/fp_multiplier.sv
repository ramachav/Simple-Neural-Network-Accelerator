/***********************************************************************************  
*  Single Precision Floating Point Multiplier according to the IEEE754 Standards   *
*  ECE 69500R SoC Architecture                                                     *
*  Simple Neural Network Accelerator                                               *
***********************************************************************************/

module fp_multiplier (
	input logic [31:0] dataa,
	input logic [31:0] datab,
	output logic [31:0] result
);

	//Corner Case Block I/O signals
	logic O_sign;
	logic [7:0] O_exponent;
	logic [22:0] O_mantissa;

	//Multiplier Block I/O Signals
	logic [31:0] multiplier_in_A;
	logic [31:0] multiplier_in_B;
	logic multiplier_out_s;
	logic [7:0] multiplier_out_e;
	logic [22:0] multiplier_out_m;

	//Multiplier Block Internal Signals
	logic A_sign;
	logic [7:0] A_exponent;
	logic [23:0] A_mantissa;
	logic B_sign;
	logic [7:0] B_exponent;
	logic [23:0] B_mantissa;
	logic [8:0] intermediate_exponent;
	logic [8:0] A_plus_B_exponent;
	logic [47:0] intermediate_product;	//To hold A_mantissa * B_mantissa.
	logic [47:0] final_mantissa;		//Temp to hold intermediate _product shifted

	//Assign statements for the outputs/inputs
	assign result = {O_sign, O_exponent, O_mantissa};
	assign multiplier_in_A = dataa;
	assign multiplier_in_B = datab;

	always @ (dataa, datab) begin 
	//Multiplier Logic block (Block where the actual multiplication happens)
	//always @ (dataa, datab) begin
		A_sign = multiplier_in_A[31];
		A_exponent = (multiplier_in_A[30:23] == 8'h0)? 8'h1 : multiplier_in_A[30:23];
		A_mantissa = (multiplier_in_A[30:23] == 8'h0)? {1'b0, multiplier_in_A[22:0]} : {1'b1, multiplier_in_A[22:0]};

		B_sign = multiplier_in_B[31];
		B_exponent = (multiplier_in_B[30:23] == 8'h0)? 8'h1 : multiplier_in_B[30:23];
		B_mantissa = (multiplier_in_B[30:23] == 8'h0)? {1'b0, multiplier_in_B[22:0]} : {1'b1, multiplier_in_B[22:0]};

		intermediate_product = A_mantissa * B_mantissa;										//Simply multiply the mantissas. (Implementation up to the compiler)
		final_mantissa = intermediate_product[47]? intermediate_product : intermediate_product << 1;
		A_plus_B_exponent = A_exponent + B_exponent;
		intermediate_exponent = (A_plus_B_exponent - 127 + intermediate_product[47]);		//Biasing the final exponent.

		multiplier_out_s = A_sign ^ B_sign;													//XORing the input sign bits.
		multiplier_out_e = intermediate_exponent[7:0];
		multiplier_out_m = final_mantissa[46:24] + (final_mantissa[23] & final_mantissa[22] | (| final_mantissa[21:0]));

	//Exponent Overflow/Underflow Checks
		if(intermediate_exponent >= 255) begin 	//Overflow detected? Most likely because the result needed 9-bits instead of 8-bits.
			if(A_plus_B_exponent <= 127) begin //Underflow detected? Maybe since (A_exp + Bias + B_exp + Bias <= Bias -> A_exp + B_exp <= -Bias)
				multiplier_out_e = '0;
				multiplier_out_m = '0;
			end 
			else begin 
				multiplier_out_e = 8'hFF;
				multiplier_out_m = '0;
			end 
		end
		else if(A_plus_B_exponent <= 127) begin //Underflow detected? Maybe since (A_exp + Bias + B_exp + Bias <= Bias -> A_exp + B_exp <= -Bias)
			multiplier_out_e = '0;
			multiplier_out_m = '0;
		end  
	//end

	//Corner Case Block (Block where the corner cases are taken care of before actual multiplication takes place)
		if(dataa[30:23] == 8'hFF && dataa[22:0] != '0) begin		//A is NaN, output a NaN {A_sign, A_exp, A_mant} = {x, '1, x}.
			O_sign = dataa[31];
			O_exponent = dataa[30:23];
			O_mantissa = dataa[22:0];
		end 
		else if(datab[30:23] == 8'hFF && datab[22:0] != '0) begin 	//B is NaN, output a NaN {B_sign, B_exp, B_mant} = {x, '1, x}.
			O_sign = datab[31];
			O_exponent = datab[30:23];
			O_mantissa = datab[22:0];
		end 
		else if(dataa[30:0] == 31'h7F800000) begin	//A is inf, output an inf {A_sign, A_exp, A_mant} = {x, '1, '0}.
			O_sign = dataa[31];
			O_exponent = 8'hFF;
			O_mantissa = '0;
		end
		else if(datab[30:0] == 31'h7F800000) begin	//B is inf, output an inf {B_sign, B_exp, B_mant} = {x, '1, '0}.
			O_sign = datab[31];
			O_exponent = 8'hFF;
			O_mantissa = '0;
		end
		else if(dataa[30:0] == '0 || datab[30:0] == '0) begin		//A or B is zero, output a zero.
			O_sign = dataa[31] ^ datab[31];
			O_exponent = '0;
			O_mantissa = '0;
		end 
		else begin			//Passed all the corner cases. Pass the inputs to the multiplier block.
			O_sign = multiplier_out_s;
			O_exponent = multiplier_out_e;
			O_mantissa = multiplier_out_m;
		end 	
	end

endmodule // fp_multiplier

/***********************************************************************************  
*  Single Precision Floating Point Multiplier according to the IEEE754 Standards   *
*  ECE 69500R SoC Architecture                                                     *
*  Simple Neural Network Accelerator                                               *
***********************************************************************************/

module fp_multiplier (
	input logic [31:0] A,
	input logic [31:0] B,
	output logic [31:0] O
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
	logic [47:0] multiplier_out_m;

	//Multiplier Block Internal Signals
	logic A_sign;
	logic [7:0] A_exponent;
	logic [23:0] A_mantissa;
	logic B_sign;
	logic [7:0] B_exponent;
	logic [23:0] B_mantissa;
	logic [7:0] intermediate_exponent;
	logic [47:0] intermediate_product;	//To hold A_mantissa * B_mantissa.
	logic [47:0] final_mantissa;

	//Multiplier Normalizer I/O Signals
	logic [7:0] normalizer_in_e;
	logic [47:0] normalizer_in_m;		//normalizer_in_m[47] is a hidden bit. 
	logic [7:0] normalizer_out_e;
	logic [47:0] normalizer_out_m;		//normalizer_out_m[47] is a hidden bit. 

	//Assign statements for the outputs
	assign O = {O_sign, O_exponent, O_mantissa};

	//Corner Case Block (Block where the corner cases are taken care of before actual multiplication takes place)
	always_comb begin 
		if(A[30:23] == 8'hFF && A[22:0] != '0) begin		//A is NaN, output a NaN {A_sign, A_exp, A_mant} = {x, '1, x}.
			O_sign = A[31];
			O_exponent = A[30:23];
			O_mantissa = A[22:0];
		end 
		else if(B[30:23] == 8'hFF && B[22:0] != '0) begin 	//B is NaN, output a NaN {B_sign, B_exp, B_mant} = {x, '1, x}.
			O_sign = B[31];
			O_exponent = B[30:23];
			O_mantissa = B[22:0];
		end 
		else if(A[30:0] == 31'h7F800000) begin	//A is inf, output an inf {A_sign, A_exp, A_mant} = {x, '1, '0}.
			O_sign = A[31];
			O_exponent = 8'hFF;
			O_mantissa = '0;
		end
		else if(B[30:0] == 31'h7F800000) begin	//B is inf, output an inf {B_sign, B_exp, B_mant} = {x, '1, '0}.
			O_sign = B[31];
			O_exponent = 8'hFF;
			O_mantissa = '0;
		end
		else if(A[30:0] == '0 || B[30:0] == '0) begin		//A or B is zero, output a zero.
			O_sign = A[31] ^ B[31];
			O_exponent = '0;
			O_mantissa = '0;
		end 
		else begin			//Passed all the corner cases. Pass the inputs to the multiplier block.
			multiplier_in_A = A;
			multiplier_in_B = B;
			O_sign = multiplier_out_s;
			O_exponent = multiplier_out_e;
			O_mantissa = multiplier_out_m[46:24];
		end 
	end 

	//Multiplier Logic block (Block where the actual multiplication happens)
	always_comb begin
		A_sign = multiplier_in_A[31];
		A_exponent = (multiplier_in_A[30:23] == 8'h0)? 8'h1 : multiplier_in_A[30:23];
		A_mantissa = (multiplier_in_A[30:23] == 8'h0)? {1'b0, multiplier_in_A[22:0]} : {1'b1, multiplier_in_A[22:0]};

		B_sign = multiplier_in_B[31];
		B_exponent = (multiplier_in_B[30:23] == 8'h0)? 8'h1 : multiplier_in_B[30:23];
		B_mantissa = (multiplier_in_B[30:23] == 8'h0)? {1'b0, multiplier_in_B[22:0]} : {1'b1, multiplier_in_B[22:0]};

		multiplier_out_s = A_sign ^ B_sign;							//XORing the input sign bits.
		intermediate_exponent = A_exponent + B_exponent - 127;		//Biasing the final exponent.
		intermediate_product = A_mantissa * B_mantissa;				//Simply multiply the mantissas. (Implementation up to the compiler)

		if(intermediate_product[47]) begin 
			multiplier_out_e = intermediate_exponent + 1;
			final_mantissa = intermediate_product >> 1;
		end 
		else if(!intermediate_product[46] && (intermediate_exponent != '0)) begin 	//Use the normalizer block.
			normalizer_in_e = intermediate_exponent;
			normalizer_in_m = intermediate_product;
			multiplier_out_e = normalizer_out_e;
			final_mantissa = normalizer_out_m;
		end 
		multiplier_out_m = final_mantissa;
	end

	//Multiplier Normalizer block (This normalizer is for the case where the hidden bit is a 0 (And bit 46 is also a 0))
	always_comb begin
		if(normalizer_in_m[46:40] == 7'h1) begin
			normalizer_out_e = normalizer_in_e - 6;
			normalizer_out_m = normalizer_in_m << 6;
		end
		else if(normalizer_in_m[46:41] == 6'h1) begin
			normalizer_out_e = normalizer_in_e - 5;
			normalizer_out_m = normalizer_in_m << 5;
		end
		else if(normalizer_in_m[46:42] == 5'h1) begin
			normalizer_out_e = normalizer_in_e - 4;
			normalizer_out_m = normalizer_in_m << 4;
		end
		else if(normalizer_in_m[46:43] == 4'h1) begin
			normalizer_out_e = normalizer_in_e - 3;
			normalizer_out_m = normalizer_in_m << 3;
		end
		else if(normalizer_in_m[46:44] == 3'h1) begin
			normalizer_out_e = normalizer_in_e - 2;
			normalizer_out_m = normalizer_in_m << 2;
		end
		else if(normalizer_in_m[46:45] == 2'h1) begin
			normalizer_out_e = normalizer_in_e - 1;
			normalizer_out_m = normalizer_in_m << 1;
		end
	end 

endmodule // fp_multiplier

/*************************************************************  
*  Floating Point Adder according to the IEEE754 Standards   *
*  ECE 69500R SoC Architecture                               *
*  Simple Neural Network Accelerator                         *
*************************************************************/

module fp_adder (
	input logic [31:0] dataa,
	input logic [31:0] datab,
	output logic [31:0] result
);

	//Corner Case Block I/O signals
	logic O_sign;
	logic [7:0] O_exponent;
	logic [22:0] O_mantissa;

	//Adder Block I/O Signals
	logic [31:0] adder_in_A;
	logic [31:0] adder_in_B;
	logic adder_out_s;
	logic [7:0] adder_out_e;
	logic [24:0] adder_out_m;

	//Adder Block Internal Signals
	logic A_sign;
	logic [7:0] A_exponent;
	logic [23:0] A_mantissa;
	logic B_sign;
	logic [7:0] B_exponent;
	logic [23:0] B_mantissa;
	logic [7:0] exponent_diff;			//Diff between A_exponent and B_exponent. For shifting purposes. 
	logic [23:0] intermediate_mantissa;	//To hold shifted/aligned mantissa.

	//Adder Normalizer I/O Signals
	logic [7:0] normalizer_in_e;
	logic [24:0] normalizer_in_m;		//normalizer_in_m[47] is a hidden bit. 
	logic [7:0] normalizer_out_e;
	logic [24:0] normalizer_out_m;		//normalizer_out_m[47] is a hidden bit. 

	//Assign statements for the outputs/inputs
  	assign result = {O_sign, O_exponent, O_mantissa};
	assign adder_in_A = dataa;
	assign adder_in_B = datab;

	always @ (dataa, datab) begin
	//Adder Logic Block (Block where the actual addition happens)
		A_sign = adder_in_A[31];
		A_exponent = (adder_in_A[30:23] == 8'h0)? 8'h1 : adder_in_A[30:23];
		A_mantissa = (adder_in_A[30:23] == 8'h0)? {1'b0, adder_in_A[22:0]} : {1'b1, adder_in_A[22:0]};

		B_sign = adder_in_B[31];
		B_exponent = (adder_in_B[30:23] == 8'h0)? 8'h1 : adder_in_B[30:23];
		B_mantissa = (adder_in_B[30:23] == 8'h0)? {1'b0, adder_in_B[22:0]} : {1'b1, adder_in_B[22:0]};

		if(A_exponent == B_exponent) begin 				//Exponents are equal. Just add/subtract mantissas and align.
			adder_out_e = A_exponent;
			if(A_sign == B_sign) begin 					//Signs are the same. Just add mantissas and align.
				adder_out_m = A_mantissa + B_mantissa;
				adder_out_s = A_sign;
				adder_out_m[24] = 1'b1;					//Used later to decide how to align result. 
			end 
			else begin 									//Signs are opposite. Need to find which is greater. Subtract mantissas and align. 
				if(A_mantissa > B_mantissa) begin 		//A > B => A - B is easier to do.
					adder_out_m = A_mantissa - B_mantissa;
					adder_out_s = A_sign;
				end 
				else begin 								//A < B => B - A is easier to do. 
					adder_out_m = B_mantissa - A_mantissa;
					adder_out_s = B_sign;
				end 
			end 
		end
		else begin 										//Exponents not equal. Need to find which is greater. Subtract mantissas and align.
			if(A_exponent > B_exponent) begin 			//A > B => A - B is easier to do.
				adder_out_e = A_exponent;
				adder_out_s = A_sign;
				exponent_diff = A_exponent - B_exponent;
				intermediate_mantissa = B_mantissa >> exponent_diff;
				adder_out_m = (A_sign == B_sign)? (A_mantissa + intermediate_mantissa) : (A_mantissa - intermediate_mantissa);
			end 
			else begin 									//A < B => B - A is easier to do. 
				adder_out_e = B_exponent;
				adder_out_s = B_sign;
				exponent_diff = B_exponent - A_exponent;
				intermediate_mantissa = A_mantissa >> exponent_diff;
				adder_out_m = (A_sign == B_sign)? (B_mantissa + intermediate_mantissa) : (B_mantissa - intermediate_mantissa);
			end 
		end 
	//end 
	//Setting the inputs for the normalizer (In case needed)
		normalizer_in_m = adder_out_m;
		normalizer_in_e = adder_out_e;

	//Adder Normalizer block (This normalizer is for the case where the hidden bit is a 0 (And bit 24 is also a 0))
	//always @ (dataa, datab) begin 
		if(normalizer_in_m[23:3] == 21'h1) begin
			normalizer_out_e = normalizer_in_e - 20;
			normalizer_out_m = normalizer_in_m << 20;
		end 
		else if(normalizer_in_m[23:4] == 20'h1) begin
			normalizer_out_e = normalizer_in_e - 19;
			normalizer_out_m = normalizer_in_m << 19;
		end 
		else if(normalizer_in_m[23:5] == 19'h1) begin
			normalizer_out_e = normalizer_in_e - 18;
			normalizer_out_m = normalizer_in_m << 18;
		end 
		else if(normalizer_in_m[23:6] == 18'h1) begin
			normalizer_out_e = normalizer_in_e - 17;
			normalizer_out_m = normalizer_in_m << 17;
		end 
		else if(normalizer_in_m[23:7] == 17'h1) begin
			normalizer_out_e = normalizer_in_e - 16;
			normalizer_out_m = normalizer_in_m << 16;
		end 
		else if(normalizer_in_m[23:8] == 16'h1) begin
			normalizer_out_e = normalizer_in_e - 15;
			normalizer_out_m = normalizer_in_m << 15;
		end 
		else if(normalizer_in_m[23:9] == 15'h1) begin
			normalizer_out_e = normalizer_in_e - 14;
			normalizer_out_m = normalizer_in_m << 14;
		end 
		else if(normalizer_in_m[23:10] == 14'h1) begin
			normalizer_out_e = normalizer_in_e - 13;
			normalizer_out_m = normalizer_in_m << 13;
		end 
		else if(normalizer_in_m[23:11] == 13'h1) begin
			normalizer_out_e = normalizer_in_e - 12;
			normalizer_out_m = normalizer_in_m << 12;
		end 
		else if(normalizer_in_m[23:12] == 12'h1) begin
			normalizer_out_e = normalizer_in_e - 11;
			normalizer_out_m = normalizer_in_m << 11;
		end 
		else if(normalizer_in_m[23:13] == 11'h1) begin
			normalizer_out_e = normalizer_in_e - 10;
			normalizer_out_m = normalizer_in_m << 10;
		end 
		else if(normalizer_in_m[23:14] == 10'h1) begin
			normalizer_out_e = normalizer_in_e - 9;
			normalizer_out_m = normalizer_in_m << 9;
		end 
		else if(normalizer_in_m[23:15] == 9'h1) begin
			normalizer_out_e = normalizer_in_e - 8;
			normalizer_out_m = normalizer_in_m << 8;
		end 
		else if(normalizer_in_m[23:16] == 8'h1) begin
			normalizer_out_e = normalizer_in_e - 7;
			normalizer_out_m = normalizer_in_m << 7;
		end 
		else if(normalizer_in_m[23:17] == 7'h1) begin
			normalizer_out_e = normalizer_in_e - 6;
			normalizer_out_m = normalizer_in_m << 6;
		end 
		else if(normalizer_in_m[23:18] == 6'h1) begin
			normalizer_out_e = normalizer_in_e - 5;
			normalizer_out_m = normalizer_in_m << 5;
		end 
		else if(normalizer_in_m[23:19] == 5'h1) begin
			normalizer_out_e = normalizer_in_e - 4;
			normalizer_out_m = normalizer_in_m << 4;
		end 
		else if(normalizer_in_m[23:20] == 4'h1) begin
			normalizer_out_e = normalizer_in_e - 3;
			normalizer_out_m = normalizer_in_m << 3;
		end 
		else if(normalizer_in_m[23:21] == 3'h1) begin
			normalizer_out_e = normalizer_in_e - 2;
			normalizer_out_m = normalizer_in_m << 2;
		end 
		else if(normalizer_in_m[23:22] == 2'h1) begin
			normalizer_out_e = normalizer_in_e - 1;
			normalizer_out_m = normalizer_in_m << 1;
		end
	//end

	//Shifting/Alignment logic
		if(adder_out_m[24]) begin 								//Just need to align the bits by 1.
			adder_out_m = adder_out_m >> 1;
			adder_out_e = adder_out_e + 1;
		end 
		else if(!adder_out_m[23] && adder_out_e != '0) begin 	//Use the normalizer block.
			adder_out_m = normalizer_out_m;
			adder_out_e = normalizer_out_e;
		end 

	//Corner Case Block (Block where the corner cases are taken care of before actual addition takes place)
	//always @ (dataa, datab) begin 
		if((dataa[30:23] == 8'hFF && dataa[22:0] != '0) || (datab[30:0] == '0)) begin	//A + B = A if A = NaN or B = 0.
			O_sign = dataa[31];
			O_exponent = dataa[30:23];
			O_mantissa = dataa[22:0];
		end
		else if((datab[30:23] == 8'hFF && datab[22:0] != '0) || (dataa[30:0] == '0)) begin	//A + B = B if A = 0 or B = NaN.
			O_sign = datab[31];
			O_exponent = datab[30:23];
			O_mantissa = datab[22:0];
		end
		else if((dataa[30:23] == 8'hFF && dataa[22:0] == '0) || (datab[30:23] == 8'hFF && datab[22:0] == '0)) begin 	//A + B = inf if A = inf or B = inf.
			O_sign = dataa[31] ^ datab[31];
			O_exponent = 8'hFF;
			O_mantissa = '0;
		end 
		else begin 		//Passed all the corner cases. Pass the inputs to the adder block.
			O_sign = adder_out_s;
			O_exponent = adder_out_e;
			O_mantissa = adder_out_m[22:0];
		end
  	end

endmodule // fp_adder

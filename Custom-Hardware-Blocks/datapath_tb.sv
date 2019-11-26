/*************************************************************  
*  Datapath Testbench           			     		 	 *
*  ECE 69500R SoC Architecture                               *
*  Simple Neural Network Accelerator                         *
*************************************************************/

`timescale 1 ns / 1 ns

module datapath_tb();

	reg clk;
	reg n_rst;

	wire [31:0] A;
	wire [31:0]	B;
	wire [31:0] AddO;
	wire [31:0] MulO;

	datapath DATAPATH ();

	fp_test testAdd 
	(
		.A(A), .B(B), .AddO(AddO), .MulO(MulO), .clk(clk), .n_rst(n_rst)
	);

	initial begin
		$display( "Starting testbench" );
		clk = 0;
		n_rst = 0;
		#100
		n_rst = 1;
	end

	always #5 clk = ~clk;

endmodule // fp_tb 

program fp_test (
	input	logic 			clk,
	input	logic 			n_rst,
	output	logic [31:0]	A,
	output	logic [31:0]	B,
	input	logic [31:0]	AddO,
	input	logic [31:0]	MulO
);

	//	Wires and Registers 

		bit [31:0]	vectorA;
		bit [31:0]	vectorB;
		bit [31:0]	vectorAdd;
		bit [31:0]	vectorMul;

		real realA;
		real realB;
		real realAdd;
		real realMul;


	task automatic genRands;
	begin
		vectorA = $random();
		realA = $bitstoshortreal( vectorA );

		vectorB = $random();
		realB = $bitstoshortreal( vectorB );

		realAdd = realA + realB;
		vectorAdd = $shortrealtobits( realAdd );

		realMul = realA * realB;
		vectorMul = $shortrealtobits( realMul );
	end
	endtask //automatic

	initial begin
		forever begin
			genRands();
			#1;
			A = vectorA;
			B = vectorB;
			#5;
			if ( AddO != vectorAdd ) begin
				$display( "Add Mismatch : %08X + %08X = %08X --> %08X", vectorA, vectorB, vectorAdd, AddO );
			end
			else begin
				//$display( "Add Match    : %08X + %08X = %08X  =  %08X", vectorA, vectorB, vectorAdd, AddO );
			end
			if ( MulO != vectorMul ) begin
				$display( "Mul Mismatch : %08X x %08X = %08X --> %08X", vectorA, vectorB, vectorMul, MulO );
			end
			else begin
				//$display( "Mul Match    : %08X x %08X = %08X  =  %08X", vectorA, vectorB, vectorMul, MulO );
			end
			#4;
		end
	end

endprogram

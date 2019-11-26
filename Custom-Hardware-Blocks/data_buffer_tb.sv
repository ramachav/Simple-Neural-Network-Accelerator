/*************************************************************  
*  Data Buffer Testbench           			     		 	 *
*  ECE 69500R SoC Architecture                               *
*  Simple Neural Network Accelerator                         *
*************************************************************/

`timescale 1 ns / 1 ns

module data_buffer_tb();

	reg clk;
	reg reset;
	reg read_enable_tb, write_enable_tb, buffer_full_tb, buffer_empty_tb;
	reg [31:0] write_data_tb, read_data_tb;

	parameter BUFFER_SIZE = 12;

	data_buffer #(.BUFFER_SIZE(BUFFER_SIZE)) DATA_BUFFER (
		.clk(clk), 
		.reset(reset), 
		.read_enable(read_enable_tb), 
		.write_enable(write_enable_tb), 
		.read_data(read_data_tb), 
		.write_data(write_data_tb), 
		.buffer_full(buffer_full_tb),
		.buffer_empty(buffer_empty_tb)
	);

	initial begin 
		clk = 0;
	end 

	always #5 clk = ~clk;

	data_buffer_test #(.BUFFER_SIZE(BUFFER_SIZE)) DATA_BUFFER_TESTING 
	(
		.clk(clk), 
		.reset(reset), 
		.read_enable(read_enable_tb), 
		.write_enable(write_enable_tb), 
		.read_data(read_data_tb), 
		.write_data(write_data_tb), 
		.buffer_full(buffer_full_tb), 
		.buffer_empty(buffer_empty_tb)
	);

endmodule // data_buffer_tb 

program data_buffer_test (
	input logic clk,
	output logic reset, 
	input logic buffer_full,
	input logic buffer_empty,
	input logic [31:0] read_data,
	output logic [31:0] write_data,
	output logic read_enable,
	output logic write_enable 
);

	logic [31:0] data_to_write;
	logic [31:0] data_being_read;
	parameter BUFFER_SIZE = 12;

	task automatic genRands;
	begin
		data_to_write = $random();
	end
	endtask //automatic

	initial begin
		$display( "Starting testbench" );
		@(posedge clk);
		@(posedge clk);
		reset = 1;
		@(posedge clk);
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		@(posedge clk);
		genRands();
		@(posedge clk);
		write_enable = 1;
		for(int i = 0; i < BUFFER_SIZE + 2; i++) begin 
			write_data = data_to_write;
			@(posedge clk);
			genRands();
		end 
		write_enable = 0;
		assert(buffer_full)
			 $display("Passed the first test case. (Checking if buffer full signal gets asserted properly");
		else $display("Error. Buffer full signal needs to be asserted");

		@(posedge clk);
		read_enable = 1;
		for(int i = 0; i < BUFFER_SIZE + 2; i++) begin
			data_being_read = read_data;
			@(posedge clk);
		end 
		read_enable = 0;
		assert(buffer_empty)
			 $display("Passed the second test case. (Checking if buffer empty signal gets asserted properly");
		else $display("Error. Buffer empty signal needs to be asserted");

		@(posedge clk);
		@(posedge clk);
	end
endprogram


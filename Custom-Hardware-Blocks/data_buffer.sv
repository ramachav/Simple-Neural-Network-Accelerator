/*******************************************  
*  Parameterized Data buffer 			   *
*  ECE 69500R SoC Architecture             *
*  Simple Neural Network Accelerator       *
*******************************************/

module data_buffer (
	input logic clk,
	input logic reset,
	input logic read_enable,
	input logic write_enable,
	input logic [31:0] write_data,
	output logic [31:0] read_data,
	output logic buffer_full,
	output logic buffer_empty
);

	parameter BUFFER_SIZE = 32;

	logic [$clog2(BUFFER_SIZE):0] write_ptr, nextstate_write_ptr;
	logic [$clog2(BUFFER_SIZE):0] read_ptr, nextstate_read_ptr;
	logic [31:0] data_buffer_array [0:BUFFER_SIZE-1];	//Buffer to store incoming data. (32 32-bit registers)

	always_ff @ (posedge clk, posedge reset) begin
		if(reset) begin
			write_ptr <= '0;
			data_buffer_array <= '{default:'0};
		end
		else if(write_enable) begin
			data_buffer_array[write_ptr[$clog2(BUFFER_SIZE)-1:0]] <= write_data;
			write_ptr <= nextstate_write_ptr;
		end
		else begin
			write_ptr <= write_ptr;
		end
	end

	always_ff @ (posedge clk, posedge reset) begin 
		if(reset) begin 
			read_ptr <= '0;
		end 
		else if(read_enable) begin 
			read_ptr <= nextstate_read_ptr;
		end 
		else begin 
			read_ptr <= read_ptr;
		end 
	end

	assign nextstate_read_ptr = (read_ptr[$clog2(BUFFER_SIZE)-1:0] == (BUFFER_SIZE-1))? { ~read_ptr[$clog2(BUFFER_SIZE)], {$clog2(BUFFER_SIZE){1'b0}} } : (read_ptr + 1);
	assign nextstate_write_ptr = (write_ptr[$clog2(BUFFER_SIZE)-1:0] == (BUFFER_SIZE-1))? { ~write_ptr[$clog2(BUFFER_SIZE)], {$clog2(BUFFER_SIZE){1'b0}} } : (write_ptr + 1);
	assign buffer_full = (read_ptr[$clog2(BUFFER_SIZE)-1:0] == write_ptr[$clog2(BUFFER_SIZE)-1:0]) & (write_ptr[$clog2(BUFFER_SIZE)] != read_ptr[$clog2(BUFFER_SIZE)]);
	assign buffer_empty = (read_ptr == write_ptr);

	assign read_data = data_buffer_array[read_ptr[$clog2(BUFFER_SIZE)-1:0]];

endmodule //data_buffer

/*************************************************************
*  Single Multiply Accumulate Accelerator Design Testbench   *
*  ECE 69500R SoC Architecture             					 *
*  Simple Neural Network Accelerator       					 *
*************************************************************/

`timescale 1 ns / 1 ns

module nn_acc_single_tb();

	logic clk, reset;
	logic read_tb, write_tb;
	logic [7:0] address_tb;
	logic [31:0] readdata_tb, writedata_tb;

	parameter WEIGHT_BUFFER_SIZE = 8;
	parameter IMAGE_BUFFER_SIZE = 8; //8;
	parameter RESULT_BUFFER_SIZE = 24; //24;

	nn_acc_single_non_burst #(.WEIGHT_BUFFER_SIZE(WEIGHT_BUFFER_SIZE), .IMAGE_BUFFER_SIZE(IMAGE_BUFFER_SIZE), .RESULT_BUFFER_SIZE(RESULT_BUFFER_SIZE)) 
	SINGLE_MAC_NN_ACCELERATOR (
		.clk(clk),
		.reset(reset),
		.address(address_tb),
		.read(read_tb),
		.write(write_tb),
		.writedata(writedata_tb),
		.readdata(readdata_tb)
	);

	initial begin 
		clk = 0;
	end 

	always #5 clk = ~clk;

	nn_acc_single_test #(.WEIGHT_BUFFER_SIZE(WEIGHT_BUFFER_SIZE), .IMAGE_BUFFER_SIZE(IMAGE_BUFFER_SIZE), .RESULT_BUFFER_SIZE(RESULT_BUFFER_SIZE))
	SINGLE_MAC_NN_ACCELERATOR_TESTING (
		.clk(clk),
		.reset(reset),
		.address(address_tb),
		.read(read_tb),
		.write(write_tb),
		.writedata(writedata_tb),
		.readdata(readdata_tb)
	);

endmodule

program nn_acc_single_test (
	input logic clk,
	output logic reset,
	output logic read,
	output logic write, 
	output logic [7:0] address,
	output logic [31:0] writedata,
	input logic [31:0] readdata
);

	logic [31:0] data_to_write;
	logic [7:0] exponent_to_write;
	logic sign_to_write;
	logic [22:0] mantissa_to_write;
	logic [31:0] data_being_read;
	logic [7:0] temp_address;

	parameter WEIGHT_BUFFER_SIZE = 8;
	parameter IMAGE_BUFFER_SIZE = 8; //8;
	parameter RESULT_BUFFER_SIZE = 24; //24;

	task automatic genRands;
	begin
		mantissa_to_write = $random() % 23;
		sign_to_write = $random() % 1;
		exponent_to_write = 8'h80;
		data_to_write = {sign_to_write, exponent_to_write, mantissa_to_write};
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
		read = 0;
		write = 0;
		address = '0;
		writedata = '0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

		for(int k = 0; k < 10; k++) begin 
			//Fill in the weight buffer with values
			/*address = 8'h1;
			genRands();
			writedata = data_to_write;
			write = 1;
			@(posedge clk);*/

			for(int i = 0; i < WEIGHT_BUFFER_SIZE; i++) begin	
				/*if(!waitrequest) begin 
					genRands();
					temp_address = address;
				end
				else if(waitrequest) begin 
					if(i == 1) begin 
						temp_address = address;
					end 
					else begin 
						temp_address = address;
					end 
					i--;
				end*/
				genRands();
				writedata = data_to_write;
				write = 1;
				address = 8'h1;
				@(posedge clk);
			end 

			read = 0;
			write = 0;
			writedata = '0;
			address = '0;

			@(posedge clk);
			@(posedge clk);

			for(int j = 0; j < 1; j++) begin 
			
				//Fill in the image buffer with values
				@(posedge clk);
				@(posedge clk);
				address = 8'h61;
				//genRands();
				//writedata = data_to_write;
				//write = 1;
				//@(posedge clk);

				for(int i = 0; i < WEIGHT_BUFFER_SIZE; i++) begin	
					/*if(!waitrequest) begin 
						if(i == 0) begin 
							genRands();
							temp_address = 8'h61;
						end 
						else begin 
							genRands();
							temp_address = address;
						end 
					end
					else begin 
						if(i == 0) begin 
							temp_address = address;
						end 
						else begin 
							temp_address = address;
						end 
						i--;
					end*/
					genRands();
					temp_address = address;
					writedata = data_to_write;
					write = 1;
					address = temp_address;
					@(posedge clk);
				end 

				read = 0;
				write = 0;
				writedata = '0;
				address = '0;
				
				@(posedge clk);
				@(posedge clk);
			end 

			#1500;
			@(posedge clk);
			@(posedge clk);

			//Read out the result buffer values
			@(posedge clk);
			@(posedge clk);
			/*read = 1;
			write = 0;
			writedata = '0;
			address = 8'hC1;*/
			@(posedge clk);

			for(int i = 0; i < 1; i++) begin 
				/*if(!waitrequest) begin 
					$display("0x%08X", readdata);
					temp_address = address;
				end 
				else begin 
					if(i == 1) begin 
						temp_address = address;
					end 
					else begin 
						temp_address = address;
					end 
					i--;
				end*/
				read = 1;
				address = 8'hC1;
				@(posedge clk);
				$display("0x%08X", readdata);
			end

			@(posedge clk);


			read = 0;
			write = 0;
			address = '0;
			writedata = '0;

			@(posedge clk);
			@(posedge clk);
		end 
	end 

endprogram
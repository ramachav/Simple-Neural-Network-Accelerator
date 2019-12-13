/*************************************************************************************************
*  Single Multiply Accumulate Accelerator Design with 96 element deep weight and image buffers   *
*  ECE 69500R SoC Architecture             														 *
*  Simple Neural Network Accelerator       														 *
*************************************************************************************************/

module nn_acc_single_non_burst (
	input logic clk,
	input logic reset,
	input logic [7:0] address,	//Just to keep enough addresses for all the registers in the buffers
	input logic read,
	input logic write, 
	input logic [31:0] writedata,
	output logic [31:0] readdata
);

	parameter WEIGHT_BUFFER_SIZE = 96;
	parameter IMAGE_BUFFER_SIZE = 96;

	//Weight buffer signals		(Weight addresses: 8'h01 - 8'h60)
	logic weight_write_enable, weight_read_enable, weight_buffer_empty, weight_buffer_full;
	logic weight_read_en_reg;
	logic [31:0] weight_write_data, weight_read_data;
	//Image buffer signals 		(Image addresses: 8'h61 - 8'hC0)
	logic image_write_enable, image_read_enable, image_buffer_empty, image_buffer_full;
	logic image_read_en_reg;
	logic [31:0] image_write_data, image_read_data;
	//Result buffer signals 	(Result addresses: 8'hC1 - 8'hD8)
	logic result_write_enable, result_read_enable;
	logic [31:0] result_register;
	logic [10:0] calccount, nextstate_calccount;
	//Floating point adder signals
	logic [31:0] adder_input_a, adder_input_b, adder_output;
	//Floating point multiplier signals
	logic [31:0] multiplier_input_a, multiplier_input_b, multiplier_output;
	//Pipeline register control signals 
	logic adder_enable, adder_en_reg;

	data_buffer #(.BUFFER_SIZE(WEIGHT_BUFFER_SIZE)) WEIGHT_BUFFER (.clk(clk), .reset(reset), .write_enable(weight_write_enable), .read_enable(weight_read_enable), .write_data(weight_write_data), .read_data(weight_read_data), .buffer_empty(weight_buffer_empty), .buffer_full(weight_buffer_full));
	data_buffer #(.BUFFER_SIZE(IMAGE_BUFFER_SIZE))  IMAGE_BUFFER  (.clk(clk), .reset(reset), .write_enable(image_write_enable), .read_enable(image_read_enable), .write_data(image_write_data), .read_data(image_read_data), .buffer_empty(image_buffer_empty), .buffer_full(image_buffer_full));
	
	fp_adder FLOATING_POINT_ADDER (.dataa(adder_input_a), .datab(adder_input_b), .result(adder_output));
	fp_multiplier FLOATING_POINT_MULTIPLIER (.dataa(multiplier_input_a), .datab(multiplier_input_b), .result(multiplier_output));

	always_ff @ (posedge clk, posedge reset) begin 
		if(reset) begin 
			adder_input_a <= '0;
			adder_input_b <= '0;
		end 
		else if(result_write_enable) begin
			adder_input_a <= '0;
			adder_input_b <= '0;
		end 
		else if(adder_enable) begin
			adder_input_a <= adder_output;
			adder_input_b <= multiplier_output;
		end 
		else begin 
			adder_input_a <= adder_input_a; 
			adder_input_b <= adder_input_b;
		end 
	end 

	always_ff @ (posedge clk, posedge reset) begin 
		if(reset) begin 
			weight_read_en_reg <= '0;
			image_read_en_reg <= '0;
			adder_en_reg <= '0;
			calccount <= '0;
		end 
		else begin 
			weight_read_en_reg <= weight_read_enable;
			image_read_en_reg <= image_read_enable;
			adder_en_reg <= adder_enable;
			calccount <= nextstate_calccount;
		end 
	end   

	//Internal Accelerator Control Signals and Slave Interface Control Signals
	assign multiplier_input_a = weight_read_data;
	assign multiplier_input_b = image_read_data;

	assign adder_enable = (!image_buffer_empty && (calccount != WEIGHT_BUFFER_SIZE))? '1 : (((calccount == WEIGHT_BUFFER_SIZE) || image_buffer_empty)? '0 : adder_en_reg);

	assign weight_write_enable = (write && (address > 8'h00) && (address < 8'h61));
	assign weight_read_enable = (!image_buffer_empty && (calccount != WEIGHT_BUFFER_SIZE))? '1 : (((calccount == WEIGHT_BUFFER_SIZE) || image_buffer_empty)? '0 : weight_read_en_reg);
	assign weight_write_data = writedata;
	
	assign image_write_enable = (write && (address > 8'h60) && (address < 8'hC1));
	assign image_read_enable = (!image_buffer_empty && (calccount != WEIGHT_BUFFER_SIZE))? '1 : (((calccount == WEIGHT_BUFFER_SIZE) || image_buffer_empty)? '0 : image_read_en_reg);
	assign image_write_data = writedata;
	
	assign result_write_enable = (calccount == (WEIGHT_BUFFER_SIZE))? '1 : '0;
	assign result_read_enable = (read && (address > 8'hC0) && (address < 8'hD9));
	
	assign nextstate_calccount = (calccount == (WEIGHT_BUFFER_SIZE))? '0 : (adder_enable? calccount + 1 : calccount);

	always_ff @ (posedge clk, posedge reset) begin 
		if(reset) begin 
			readdata <= '0;
		end
		else if(result_read_enable) begin 
			readdata <= result_register; 
		end 
		else begin
			readdata <= '0;
		end
	end 

	always_ff @ (posedge clk, posedge reset) begin 
		if(reset) begin 
			result_register <= '0;
		end 
		else if(result_write_enable) begin 
			result_register <= adder_output;
		end 
		else begin 
			result_register <= result_register;
		end 
	end

endmodule 
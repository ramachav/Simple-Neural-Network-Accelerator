/**
 *	AcceleratorTopMod.sv
 *
 * 	Created	:	26 Nov 2019, 12:44 PM EST
 * 	Author	:	Abhishek Bhaumick
 * 	
 */

import AcceleratorPackage::*;


module AcceleratorTopMod (

	input  logic	clk,		// Clock
	input  logic	rst,		// Synchronous reset active low

	input  logic	ReadEnIn,
	input  logic	WriteEnIn,

	input  logic [AddressBitWidth-1:0]	AddressIn,
	input  logic [DataBitWidth-1:0]		DataIn,
	output logic [DataBitWidth-1:0]		DataOut
	
);

	localparam PxBfrCount = PixelBufferCount;
	localparam PxBfrDepth = PixelBufferDepth;

	//	Wires and Registers
		reg [AddressBitWidth-2:0] controlReg;
		AcclDataType [NumFilterCoeffs-1:0] coeffBuffer;

		AcclDataType [PxBfrCount-1:0][PxBfrDepth-1:0] pxBuffer;
		reg [4:0] pxBfrWrCounter;
		// reg [PxBfrCount-1:0] pxBfrWrSelect;

		wire [AddrRoutingBits-1:0] addrRoute;

		reg cmdRst;

	assign addrRoute	= AddressIn[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits-1];

	always_ff @(posedge clk) begin	:	wrCoeff
		if (rst == 1 || cmdRst == 1) begin
			coeffBuffer <= '{default:32'h0};
		end else begin
			if (WriteEnIn == 1) begin
				if (addrRoute == routeCoeff) begin
					coeffBuffer[AddressIn[3:0]] <= DataIn;	//	Upto 16 Locations
				end
			end
		end
	end

	always_ff @(posedge clk) begin	:	wrControl
		if (rst == 1) begin
			cmdRst <= 0;
		end else begin
			if (WriteEnIn == 1) begin
				case (AddressIn)
					'h00 :
						cmdRst <= 1;
					default : 
						cmdRst <= 0;
				endcase
			end else begin
				cmdRst <= 0;
			end
		end
	end

	wire [1:0] pxBfrOffset = pxBfrWrCounter[4:3];
	wire [2:0] pxBfrSelect = pxBfrWrCounter[2:0];
	
	always_ff @(posedge clk) begin	:	wrData
		if (rst == 1 || cmdRst == 1) begin
			pxBuffer <= '{default:32'h0};
			pxBfrWrCounter <= 'h0;
		end else begin
			if (WriteEnIn == 1) begin
				if (addrRoute == routeData) begin
					//LSH with MSB append
					pxBuffer[pxBfrSelect][pxBfrOffset] <= DataIn;
					pxBfrWrCounter <= pxBfrWrCounter + 1;
				end
			end
		end
	end


endmodule
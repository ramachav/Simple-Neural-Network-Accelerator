// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// THIS FILE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THIS FILE OR THE USE OR OTHER DEALINGS
// IN THIS FILE.

/******************************************************************************
 *                                                                            *
 * This module chipselects reads and writes to the sram, with 2-cycle         *
 *  read latency and one cycle write latency.                                 *
 *                                                                            *
 ******************************************************************************/


module nios_system_sram_0 (
	// Inputs
	clk,
	reset,

	address,
	byteenable,
	read,
	write,
	writedata,

	// Bi-Directional
	SRAM_DQ,

	// Outputs
	readdata,
	readdatavalid,

	SRAM_ADDR,
	SRAM_LB_N,
	SRAM_UB_N,
	SRAM_CE_N,
	SRAM_OE_N,
	SRAM_WE_N	
);


/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input						clk;
input						reset;

input			[19: 0]	address;
input			[ 1: 0]	byteenable;
input						read;
input						write;
input			[15: 0]	writedata;

// Bi-Directional
inout			[15: 0]	SRAM_DQ;		// SRAM Data bus 16 Bits

// Outputs
output reg	[15: 0]	readdata;
output reg				readdatavalid;

output reg	[19: 0]	SRAM_ADDR;		// SRAM Address bus 18 Bits
output reg				SRAM_LB_N;		// SRAM Low-byte Data Mask 
output reg				SRAM_UB_N;		// SRAM High-byte Data Mask 
output reg				SRAM_CE_N;		// SRAM Chip chipselect
output reg				SRAM_OE_N;		// SRAM Output chipselect
output reg				SRAM_WE_N;		// SRAM Write chipselect

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires

// Internal Registers
reg						is_read;
reg						is_write;
reg			[15: 0]	writedata_reg;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

// Output Registers
always @(posedge clk)
begin
	readdata			<= SRAM_DQ;
	readdatavalid	<= is_read;
	
	SRAM_ADDR		<= address;
	SRAM_LB_N		<= ~(byteenable[0] & (read | write));
	SRAM_UB_N		<= ~(byteenable[1] & (read | write));
	SRAM_CE_N		<= ~(read | write);
	SRAM_OE_N		<= ~read;
	SRAM_WE_N		<= ~write;
end

// Internal Registers
always @(posedge clk)
begin
	if (reset)
		is_read		<= 1'b0;
	else
		is_read		<= read;
end

always @(posedge clk)
begin
	if (reset)
		is_write		<= 1'b0;
	else
		is_write		<= write;
end

always @(posedge clk)
begin
	writedata_reg	<= writedata;
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output Assignments
assign SRAM_DQ	= (is_write) ? writedata_reg : 16'hzzzz;

// Internal Assignments

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule


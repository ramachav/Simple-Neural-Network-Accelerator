/**
 * 	AcceleratorPackage.vhd
 *
 * 	Created	:	26 Nov 2019, 12:44 PM EST
 * 	Author	:	Abhishek Bhaumick
 * 	
 */


package AcceleratorPackage;

	parameter AddressBitWidth = 8;
	parameter DataBitWidth = 32;

	typedef logic [DataBitWidth-1:0] float32b;
	typedef logic [DataBitWidth-1:0] AcclDataType;




	parameter FilterRowSize = 3;
	parameter FilterColSize = 3;
	parameter NumFilterCoeffs = FilterRowSize * FilterColSize;

	typedef logic [DataBitWidth-1:0] AcclAddrType;

	const integer NumPartitionBits = 2;
	
	parameter AddrRoutingBits = 2;

	const AcclAddrType AddrOffsetControl	= 8'h00;
	const AcclAddrType AddrOffsetCoeff		= 8'h40;
	const AcclAddrType AddrOffsetData		= 8'h80;
	const AcclAddrType AddrOffsetResult		= 8'hC0;

	const logic [AddrRoutingBits-1:0] routeControl	= AddrOffsetControl[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits-1];
	const logic [AddrRoutingBits-1:0] routeCoeff	= AddrOffsetCoeff[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits-1];
	const logic [AddrRoutingBits-1:0] routeData		= AddrOffsetData[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits-1];
	const logic [AddrRoutingBits-1:0] routeResult	= AddrOffsetResult[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits-1];

	parameter PixelBufferDepth = 4;
	parameter PixelBufferCount = 8;

endpackage
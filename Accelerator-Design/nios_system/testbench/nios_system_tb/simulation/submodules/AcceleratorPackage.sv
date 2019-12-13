/**
 * 	AcceleratorPackage.vhd
 *
 * 	Created	:	26 Nov 2019, 12:44 PM EST
 * 	Author	:	Abhishek Bhaumick
 * 	
 */


package AcceleratorPackage;

	parameter AddressBitWidth = 10;
	parameter DataBitWidth = 32;

	typedef logic [DataBitWidth-1:0] float32b;
	typedef logic [DataBitWidth-1:0] AcclDataType;

	function integer clog2;
		input integer value;
	begin
		value = value-1;
		for (clog2=0; value>0; clog2=clog2+1)
			value = value>>1;
	end
	endfunction


	parameter FilterRowSize		= 3;
	parameter FilterColSize		= 3;
	parameter FilterLayerSize	= 32;
	parameter NumFilterCoeffs	= FilterRowSize * FilterColSize;

	typedef logic [DataBitWidth-1:0] AcclAddrType;

	const integer NumPartitionBits = 2;
	
	parameter AddrRoutingBits = 2;

	const AcclAddrType AddrOffsetControl	= 10'h000;
	const AcclAddrType AddrOffsetCoeff		= 10'h100;
	const AcclAddrType AddrOffsetData		= 10'h200;
	const AcclAddrType AddrOffsetResult		= 10'h300;

	const logic [AddrRoutingBits-1:0] routeControl	= AddrOffsetControl[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits];
	const logic [AddrRoutingBits-1:0] routeCoeff	= AddrOffsetCoeff[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits];
	const logic [AddrRoutingBits-1:0] routeData		= AddrOffsetData[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits];
	const logic [AddrRoutingBits-1:0] routeResult	= AddrOffsetResult[AddressBitWidth-1:AddressBitWidth-AddrRoutingBits];

	parameter PixelBufferDepth	= 16;
	parameter PixelBufferCount	= 8;
	parameter BlockCount		= FilterLayerSize / PixelBufferCount;

	typedef enum {
		s_Idle,
		s_ReadInput,
		s_WaitForCalc,
		s_ReadResult
	} MacStateType;

	parameter MacEngineLatency = 5;

	const AcclDataType FloatValue_1_0 = 'h3f800000;

	parameter ResultBufferSize = 24;

endpackage
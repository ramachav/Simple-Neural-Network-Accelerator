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


// $File: //acds/rel/17.0std/ip/sopc/components/verification/altera_external_memory_bfm/altera_external_memory_bfm.sv $
// $Revision: #1 $
// $Date: 2017/01/22 $
// $Author: swbranch $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_external_memory
// =head1 SYNOPSIS
// External Memory BFM with Avalon Conduit
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a simple one port external memory model having an Avalon Conduit 
// interface. The interface models an asynchronous tristate I/O bus.
//-----------------------------------------------------------------------------

`timescale 1ns / 1ns

module altera_external_memory_bfm (
                                   clk,
                                   cdt_address,
                                   cdt_data_io,
                                   cdt_write,
                                   cdt_byteenable,
                                   cdt_chipselect,
                                   cdt_read,
                                   cdt_outputenable,
                                   cdt_begintransfer,
                                   cdt_reset
                                  );

   function integer clog2;
      input [31:0] Depth;
      integer i;
      begin
         i = Depth;        
         for(clog2 = 0; i > 0; clog2 = clog2 + 1)
           i = i >> 1;
      end
 
   endfunction // clog2
   
   // =head1 PARAMETERS
   parameter CDT_ADDRESS_W           = 8;  // address width
   parameter CDT_NUMSYMBOLS          = 4;  // number of symbols i.e. bytes
   parameter CDT_SYMBOL_W            = 8;  // symbol width    
   parameter CDT_READ_LATENCY        = 0;
   parameter INIT_FILE               = "altera_external_memory_bfm.hex";
   
   parameter USE_CHIPSELECT          = 1;
   parameter USE_READ                = 1;
   parameter USE_WRITE               = 1;
   parameter USE_OUTPUTENABLE        = 1;
   parameter USE_BEGINTRANSFER       = 1;
   
   parameter ACTIVE_LOW_CHIPSELECT   = 0;
   parameter ACTIVE_LOW_READ         = 0;
   parameter ACTIVE_LOW_WRITE        = 0;
   parameter ACTIVE_LOW_BYTEENABLE   = 0;
   parameter ACTIVE_LOW_OUTPUTENABLE = 0;
   parameter ACTIVE_LOW_BEGINTRANSFER = 0;
   parameter ACTIVE_LOW_RESET         = 0;
   parameter VHDL_ID                  = 0;   // VHDL BFM ID number
   

   localparam DATA_W         = CDT_SYMBOL_W * CDT_NUMSYMBOLS;
   localparam WORD_ADDR_W    = CDT_ADDRESS_W - clog2(CDT_NUMSYMBOLS) + 1;
   localparam NUM_WORDS      = 2 ** WORD_ADDR_W;
   
   // =head1 PINS
   // =head2 Clock Interface
   input                        clk;
   // =head2 Conduit Interface
   input  [CDT_ADDRESS_W-1:0]   cdt_address;
   inout  [DATA_W-1:0]          cdt_data_io;
   input                        cdt_write;
   input  [CDT_NUMSYMBOLS-1:0]  cdt_byteenable;
   input                        cdt_chipselect;
   input                        cdt_read;
   input                        cdt_outputenable;
   input                        cdt_begintransfer;
   input                        cdt_reset;
      
   logic                        corrected_read;
   logic                        corrected_write;
   logic [CDT_NUMSYMBOLS-1:0]   corrected_byteenable;
   logic                        corrected_chipselect;
   logic                        corrected_outputenable;
   logic                        corrected_reset;
   
   

   //Negation Correction
   always@* begin      
      if(ACTIVE_LOW_READ == 1)
         corrected_read = ~cdt_read;
      else
         corrected_read = cdt_read;

      if(ACTIVE_LOW_WRITE == 1)
         corrected_write = ~cdt_write;
      else
         corrected_write = cdt_write;

      if(ACTIVE_LOW_BYTEENABLE == 1)
         corrected_byteenable = ~cdt_byteenable;
      else
         corrected_byteenable = cdt_byteenable;

      if(ACTIVE_LOW_CHIPSELECT == 1)
         corrected_chipselect = ~cdt_chipselect;
      else
         corrected_chipselect = cdt_chipselect;

      if(ACTIVE_LOW_OUTPUTENABLE == 1)
         corrected_outputenable = ~cdt_outputenable;
      else
         corrected_outputenable = cdt_outputenable;

      if(ACTIVE_LOW_RESET == 1)
         corrected_reset  = ~ cdt_reset;
      else
         corrected_reset = cdt_reset;
      
      
   end // always@ *

   logic [WORD_ADDR_W -1 : 0 ]   internal_address;
   logic                         internal_read;
   logic                         internal_write;
   logic                         internal_chipselect;
   logic                         internal_outputenable;
   logic [CDT_NUMSYMBOLS-1:0]    internal_byteenable;
   logic                         internal_reset;

   //Create internal signals... some are synthesized based off configuration
   always@* begin
      internal_outputenable = corrected_outputenable;
      internal_byteenable   = corrected_byteenable;
      internal_reset  = corrected_reset;
                  
      internal_read         = corrected_chipselect & corrected_read;
      internal_write        = corrected_chipselect & corrected_write;
      internal_chipselect   = corrected_chipselect;

      internal_address      = cdt_address >> ( clog2(CDT_NUMSYMBOLS) - 1 );
   
      if(USE_CHIPSELECT && USE_READ & !USE_WRITE)
         internal_write = corrected_chipselect & ~corrected_read;

      if(USE_CHIPSELECT && USE_WRITE & !USE_READ)
         internal_read = corrected_chipselect & ~corrected_write;

      if(USE_READ & USE_WRITE & ! USE_CHIPSELECT) begin
         internal_chipselect = corrected_read | corrected_write;
         internal_write     = corrected_write;
         internal_read      = corrected_read;
      end
      
      if(USE_OUTPUTENABLE == 0 )
         internal_outputenable = internal_read;

   end
   

   //--------------------------------------------------------------------------   
   // Read Datapath
   //--------------------------------------------------------------------------   
   logic [DATA_W-1:0] mem [0:NUM_WORDS-1];     

   wire  [DATA_W-1:0]  cdt_data_io;
   logic [DATA_W-1:0] cdt_data_io_pre;
   
   logic [DATA_W-1:0] internal_read_data;
   logic [DATA_W-1:0] internal_read_mask, internal_read_mask_inv;
   
   logic [DATA_W:0]   read_latency_shift_reg_top;
   logic [DATA_W:0]   read_latency_shift_reg [(CDT_READ_LATENCY > 0 ? CDT_READ_LATENCY-1 : 0) : 0 ];
   

   //Initialization of shift register
   initial begin
      for(int i = 0 ; i < CDT_READ_LATENCY ; ++i) begin
         read_latency_shift_reg[i] = '0;
      end
   end
   
   assign cdt_data_io = cdt_data_io_pre;

   //Select between memory or delayed read value
   assign internal_read_data = CDT_READ_LATENCY > 0 ? read_latency_shift_reg_top :  mem[internal_address];
   
   always@* begin
      read_latency_shift_reg_top = read_latency_shift_reg[(CDT_READ_LATENCY > 1 ? CDT_READ_LATENCY-1 : 0)];
   end
   
   always@(posedge clk, posedge internal_reset) begin
      if(internal_reset) begin
         for(int i = 0 ; i < CDT_READ_LATENCY; ++i) begin
            read_latency_shift_reg[i] = '0;
         end
         for(int i = 0 ; i < NUM_WORDS ; ++i) begin
            mem[i] = '0;
         end 
      end
      else begin
          //Store whether or not we were allowed to drive the bus... 
          //TODO: needs to eventually be changed to respect chipselect/outputenable thru readlatency parameterization
          read_latency_shift_reg[0] <= { (internal_chipselect & internal_read & internal_outputenable), mem[internal_address] };
          
          for (int i=0; i+1 < CDT_READ_LATENCY ; i+=1 ) begin
             read_latency_shift_reg[i+1] <= read_latency_shift_reg[i];
          end
      end
   end
   
   assign internal_read_mask = data_mask(internal_byteenable);
   assign internal_read_mask_inv = ~internal_read_mask;

   //Select Output based off top bit in read_latency_shift_reg or if no latency current values
   always@* begin
      if(CDT_READ_LATENCY > 0) begin
         cdt_data_io_pre = read_latency_shift_reg_top[DATA_W] ? internal_read_data : 'z;
      end
      else begin
         cdt_data_io_pre = (internal_read & internal_chipselect & !internal_write & internal_outputenable) ? (internal_read_data & internal_read_mask) : 'z;
      end
   end
   
   //--------------------------------------------------------------------------      
   // Write Datapath
   //--------------------------------------------------------------------------      

   logic  [DATA_W-1:0]     internal_write_data, internal_write_data_masked;
   logic  [DATA_W-1:0]     cdt_mem_data, cdt_mem_data_masked;      
   logic  [DATA_W-1:0]     internal_write_mask, internal_write_mask_inv;
   
   always @(*) begin
      // Delay is require to avoid race condition
      #0;
      #0;
      internal_write_mask        = data_mask(internal_byteenable);
      internal_write_mask_inv    = ~internal_write_mask;
      internal_write_data_masked = internal_write_mask & cdt_data_io;
      cdt_mem_data               = mem[internal_address];
      cdt_mem_data_masked        = cdt_mem_data & internal_write_mask_inv;
      internal_write_data        = cdt_mem_data_masked | internal_write_data_masked;
      
      if (internal_chipselect && internal_write) begin
         mem[internal_address] = internal_write_data;
      end
   end


   //--------------------------------------------------------------------------

   function automatic bit [DATA_W-1:0] data_mask(
      bit [CDT_NUMSYMBOLS-1:0] byteenable
   );
      bit [DATA_W-1:0] mask = '1;

      for (int i=0; i<CDT_NUMSYMBOLS; i=i+1) begin
         for (int k=0; k<CDT_SYMBOL_W; k=k+1) begin
            mask[i*CDT_SYMBOL_W + k] = byteenable[i];
         end
      end
      return mask;
   endfunction 



   
   //==========================================================================    
   // synthesis translate_off

   typedef enum int {VERBOSITY_NONE, 
            VERBOSITY_FAILURE, 
            VERBOSITY_ERROR, 
            VERBOSITY_WARNING, 
            VERBOSITY_INFO,
            VERBOSITY_DEBUG} Verbosity_t;
   Verbosity_t  verbosity = VERBOSITY_INFO;
   string   message = "";
   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). In this case the application program is the test bench
   // which instantiates and controls and queries state in this BFM component.
   // Test programs must only use these public access methods and events to 
   // communicate with this BFM component. The API and the module pins
   // are the only interfaces in this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------

   event signal_api_call; // public
   // This event signals that a client made an API call

   function automatic void write ( // public
      bit   [CDT_ADDRESS_W-1:0] address = 0,
      logic [DATA_W-1:0]        data = 0
   );
      string message;
      $sformat(message, "%m: Write Address: %0h Data: %0h", address, data);
      print(VERBOSITY_DEBUG, message);                  
      mem[address] = data;
      ->signal_api_call;      
   endfunction 

   function automatic logic [DATA_W-1:0] read ( // public
      bit   [CDT_ADDRESS_W-1:0] address = 0
   );
      string message;
      logic [DATA_W-1:0] data = 'x;
      
      $sformat(message, "%m: Read Address: %0h", address);
      print(VERBOSITY_DEBUG, message);                  
      data = mem[address];
      ->signal_api_call;      
      return data;
   endfunction 

   function automatic void fill ( // public
      logic [DATA_W-1:0] data = 'x,
      bit   [DATA_W-1:0] increment = 0,
      bit   [CDT_ADDRESS_W-1:0] address_low = 0,
      bit   [CDT_ADDRESS_W-1:0] address_high = NUM_WORDS-1  
   );
      string message;
      $sformat(message, 
               "%m: Fill Data: %0h Increment: %0h Address Range: %0h - %0h", 
               data, increment, address_low, address_high);
      print(VERBOSITY_DEBUG, message);

      for (int i=address_low; i<=address_high; i++) begin
         mem[i] = data+(i-address_low)*increment;
      end
      ->signal_api_call;      
   endfunction 
   
   //=cut      
   //--------------------------------------------------------------------------
   // Private Methods
   //--------------------------------------------------------------------------

   function automatic void __hello();
      // Introduction Message to console      
      $sformat(message, "%m: - Hello from altera_external_memory_bfm");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Revision: #1 $");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Date: 2017/01/22 $");
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   CDT_ADDRESS_W=%0d", CDT_ADDRESS_W);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   CDT_SYMBOL_W=%0d", CDT_SYMBOL_W);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   CDT_NUMSYMBOLS=%0d", CDT_NUMSYMBOLS);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   INIT_FILE=%s", INIT_FILE);
      print(VERBOSITY_INFO, message);
      print_divider(VERBOSITY_INFO);
   endfunction

   function automatic void print( // public
      Verbosity_t level, 
      string message
   );
      // Print a message to the console if the verbosity argument
      // is less than or equal to the global verbosity setting.
      string level_str;

      if (level <= verbosity) begin
         case(level)
            VERBOSITY_NONE:      level_str = "";
            VERBOSITY_FAILURE:   level_str = "FAILURE:";
            VERBOSITY_ERROR:     level_str = "ERROR:";
            VERBOSITY_WARNING:   level_str = "WARNING:";
            VERBOSITY_INFO:      level_str = "INFO:";
            VERBOSITY_DEBUG:     level_str = "DEBUG:";
            default:             level_str = "UNKNOWN:";
         endcase 
       
      $display("%t: %s %s",$time, level_str, message);

      end
   endfunction
   
   function automatic void print_divider( // public
      Verbosity_t level
   );
      // Prints a divider line to the console to make a block of related text
      // easier to identify and read.
      string message;
      $sformat(message, 
               "------------------------------------------------------------");
      print(level, message);
   endfunction
   
   int file;
   
   initial begin
      __hello();

      // handle presence or absence of memory intialization file
      file = $fopen(INIT_FILE, "r");
      if (file != 0) begin
      $fclose(file);
      $sformat(message, "%m: Initializing memory with file: %s", 
      INIT_FILE);
      print(VERBOSITY_INFO, message);	 
      $readmemh(INIT_FILE, mem);
      end else begin
         $fclose(file);
         $sformat(message, "%m: Cannot open memory initialization file: %s", 
         INIT_FILE);
         print(VERBOSITY_WARNING, message);	 
      end
   end

   // synthesis translate_on  
   //==========================================================================    
   
endmodule
   




 

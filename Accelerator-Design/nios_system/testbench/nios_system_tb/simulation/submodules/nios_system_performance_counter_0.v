//Legal Notice: (C)2019 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_performance_counter_0 (
                                           // inputs:
                                            address,
                                            begintransfer,
                                            clk,
                                            reset_n,
                                            write,
                                            writedata,

                                           // outputs:
                                            readdata
                                         )
;

  output  [ 31: 0] readdata;
  input   [  4: 0] address;
  input            begintransfer;
  input            clk;
  input            reset_n;
  input            write;
  input   [ 31: 0] writedata;


wire             clk_en;
reg     [ 63: 0] event_counter_0;
reg     [ 63: 0] event_counter_1;
reg     [ 63: 0] event_counter_2;
reg     [ 63: 0] event_counter_3;
reg     [ 63: 0] event_counter_4;
reg     [ 63: 0] event_counter_5;
reg     [ 63: 0] event_counter_6;
reg     [ 63: 0] event_counter_7;
wire             global_enable;
wire             global_reset;
wire             go_strobe_0;
wire             go_strobe_1;
wire             go_strobe_2;
wire             go_strobe_3;
wire             go_strobe_4;
wire             go_strobe_5;
wire             go_strobe_6;
wire             go_strobe_7;
wire    [ 31: 0] read_mux_out;
reg     [ 31: 0] readdata;
wire             stop_strobe_0;
wire             stop_strobe_1;
wire             stop_strobe_2;
wire             stop_strobe_3;
wire             stop_strobe_4;
wire             stop_strobe_5;
wire             stop_strobe_6;
wire             stop_strobe_7;
reg     [ 63: 0] time_counter_0;
reg     [ 63: 0] time_counter_1;
reg     [ 63: 0] time_counter_2;
reg     [ 63: 0] time_counter_3;
reg     [ 63: 0] time_counter_4;
reg     [ 63: 0] time_counter_5;
reg     [ 63: 0] time_counter_6;
reg     [ 63: 0] time_counter_7;
reg              time_counter_enable_0;
reg              time_counter_enable_1;
reg              time_counter_enable_2;
reg              time_counter_enable_3;
reg              time_counter_enable_4;
reg              time_counter_enable_5;
reg              time_counter_enable_6;
reg              time_counter_enable_7;
wire             write_strobe;
  //control_slave, which is an e_avalon_slave
  assign clk_en = -1;
  assign write_strobe = write & begintransfer;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_0 <= 0;
      else if ((time_counter_enable_0 & global_enable) | global_reset)
          if (global_reset)
              time_counter_0 <= 0;
          else 
            time_counter_0 <= time_counter_0 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_0 <= 0;
      else if ((go_strobe_0 & global_enable) | global_reset)
          if (global_reset)
              event_counter_0 <= 0;
          else 
            event_counter_0 <= event_counter_0 + 1;
    end


  assign stop_strobe_0 = (address == 0) && write_strobe;
  assign go_strobe_0 = (address == 1) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_0 <= 0;
      else if (clk_en)
          if (stop_strobe_0 | global_reset)
              time_counter_enable_0 <= 0;
          else if (go_strobe_0)
              time_counter_enable_0 <= -1;
    end


  assign global_enable = time_counter_enable_0 | go_strobe_0;
  assign global_reset = stop_strobe_0 && writedata[0];
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_1 <= 0;
      else if ((time_counter_enable_1 & global_enable) | global_reset)
          if (global_reset)
              time_counter_1 <= 0;
          else 
            time_counter_1 <= time_counter_1 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_1 <= 0;
      else if ((go_strobe_1 & global_enable) | global_reset)
          if (global_reset)
              event_counter_1 <= 0;
          else 
            event_counter_1 <= event_counter_1 + 1;
    end


  assign stop_strobe_1 = (address == 4) && write_strobe;
  assign go_strobe_1 = (address == 5) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_1 <= 0;
      else if (clk_en)
          if (stop_strobe_1 | global_reset)
              time_counter_enable_1 <= 0;
          else if (go_strobe_1)
              time_counter_enable_1 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_2 <= 0;
      else if ((time_counter_enable_2 & global_enable) | global_reset)
          if (global_reset)
              time_counter_2 <= 0;
          else 
            time_counter_2 <= time_counter_2 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_2 <= 0;
      else if ((go_strobe_2 & global_enable) | global_reset)
          if (global_reset)
              event_counter_2 <= 0;
          else 
            event_counter_2 <= event_counter_2 + 1;
    end


  assign stop_strobe_2 = (address == 8) && write_strobe;
  assign go_strobe_2 = (address == 9) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_2 <= 0;
      else if (clk_en)
          if (stop_strobe_2 | global_reset)
              time_counter_enable_2 <= 0;
          else if (go_strobe_2)
              time_counter_enable_2 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_3 <= 0;
      else if ((time_counter_enable_3 & global_enable) | global_reset)
          if (global_reset)
              time_counter_3 <= 0;
          else 
            time_counter_3 <= time_counter_3 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_3 <= 0;
      else if ((go_strobe_3 & global_enable) | global_reset)
          if (global_reset)
              event_counter_3 <= 0;
          else 
            event_counter_3 <= event_counter_3 + 1;
    end


  assign stop_strobe_3 = (address == 12) && write_strobe;
  assign go_strobe_3 = (address == 13) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_3 <= 0;
      else if (clk_en)
          if (stop_strobe_3 | global_reset)
              time_counter_enable_3 <= 0;
          else if (go_strobe_3)
              time_counter_enable_3 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_4 <= 0;
      else if ((time_counter_enable_4 & global_enable) | global_reset)
          if (global_reset)
              time_counter_4 <= 0;
          else 
            time_counter_4 <= time_counter_4 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_4 <= 0;
      else if ((go_strobe_4 & global_enable) | global_reset)
          if (global_reset)
              event_counter_4 <= 0;
          else 
            event_counter_4 <= event_counter_4 + 1;
    end


  assign stop_strobe_4 = (address == 16) && write_strobe;
  assign go_strobe_4 = (address == 17) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_4 <= 0;
      else if (clk_en)
          if (stop_strobe_4 | global_reset)
              time_counter_enable_4 <= 0;
          else if (go_strobe_4)
              time_counter_enable_4 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_5 <= 0;
      else if ((time_counter_enable_5 & global_enable) | global_reset)
          if (global_reset)
              time_counter_5 <= 0;
          else 
            time_counter_5 <= time_counter_5 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_5 <= 0;
      else if ((go_strobe_5 & global_enable) | global_reset)
          if (global_reset)
              event_counter_5 <= 0;
          else 
            event_counter_5 <= event_counter_5 + 1;
    end


  assign stop_strobe_5 = (address == 20) && write_strobe;
  assign go_strobe_5 = (address == 21) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_5 <= 0;
      else if (clk_en)
          if (stop_strobe_5 | global_reset)
              time_counter_enable_5 <= 0;
          else if (go_strobe_5)
              time_counter_enable_5 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_6 <= 0;
      else if ((time_counter_enable_6 & global_enable) | global_reset)
          if (global_reset)
              time_counter_6 <= 0;
          else 
            time_counter_6 <= time_counter_6 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_6 <= 0;
      else if ((go_strobe_6 & global_enable) | global_reset)
          if (global_reset)
              event_counter_6 <= 0;
          else 
            event_counter_6 <= event_counter_6 + 1;
    end


  assign stop_strobe_6 = (address == 24) && write_strobe;
  assign go_strobe_6 = (address == 25) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_6 <= 0;
      else if (clk_en)
          if (stop_strobe_6 | global_reset)
              time_counter_enable_6 <= 0;
          else if (go_strobe_6)
              time_counter_enable_6 <= -1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_7 <= 0;
      else if ((time_counter_enable_7 & global_enable) | global_reset)
          if (global_reset)
              time_counter_7 <= 0;
          else 
            time_counter_7 <= time_counter_7 + 1;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          event_counter_7 <= 0;
      else if ((go_strobe_7 & global_enable) | global_reset)
          if (global_reset)
              event_counter_7 <= 0;
          else 
            event_counter_7 <= event_counter_7 + 1;
    end


  assign stop_strobe_7 = (address == 28) && write_strobe;
  assign go_strobe_7 = (address == 29) && write_strobe;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          time_counter_enable_7 <= 0;
      else if (clk_en)
          if (stop_strobe_7 | global_reset)
              time_counter_enable_7 <= 0;
          else if (go_strobe_7)
              time_counter_enable_7 <= -1;
    end


  assign read_mux_out = ({32 {(address == 0)}} & time_counter_0[31 : 0]) |
    ({32 {(address == 1)}} & time_counter_0[63 : 32]) |
    ({32 {(address == 2)}} & event_counter_0) |
    ({32 {(address == 4)}} & time_counter_1[31 : 0]) |
    ({32 {(address == 5)}} & time_counter_1[63 : 32]) |
    ({32 {(address == 6)}} & event_counter_1) |
    ({32 {(address == 8)}} & time_counter_2[31 : 0]) |
    ({32 {(address == 9)}} & time_counter_2[63 : 32]) |
    ({32 {(address == 10)}} & event_counter_2) |
    ({32 {(address == 12)}} & time_counter_3[31 : 0]) |
    ({32 {(address == 13)}} & time_counter_3[63 : 32]) |
    ({32 {(address == 14)}} & event_counter_3) |
    ({32 {(address == 16)}} & time_counter_4[31 : 0]) |
    ({32 {(address == 17)}} & time_counter_4[63 : 32]) |
    ({32 {(address == 18)}} & event_counter_4) |
    ({32 {(address == 20)}} & time_counter_5[31 : 0]) |
    ({32 {(address == 21)}} & time_counter_5[63 : 32]) |
    ({32 {(address == 22)}} & event_counter_5) |
    ({32 {(address == 24)}} & time_counter_6[31 : 0]) |
    ({32 {(address == 25)}} & time_counter_6[63 : 32]) |
    ({32 {(address == 26)}} & event_counter_6) |
    ({32 {(address == 28)}} & time_counter_7[31 : 0]) |
    ({32 {(address == 29)}} & time_counter_7[63 : 32]) |
    ({32 {(address == 30)}} & event_counter_7);

  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= read_mux_out;
    end



endmodule


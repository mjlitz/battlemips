`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
// Matt Litzsinger
// 4/9/2017
//////////////////////////////////////////////////////////////////////////////////

//clk,screen_addr,char_code,smem_wr,mem_addr[12:2],mem_writedata,smem_readdata
module screenmem (
    input wire clk,
    input wire [10:0] screen_addr,
    output wire [7:0] char_code,
    input wire wr,
    input wire [10:0] mips_addr,
    input wire [31:0] mips_writedata,
    output wire [31:0] mips_readdata
    );
     
     logic [7:0] mem [1199:0];     // The actual storage where data resides
     initial $readmemh("map.mem", mem, 0, 1199); // Initialize memory contents from a file
      always_ff @(posedge clk)                // Memory write: only when wr==1, and only at posedge clock
         if(wr)
            mem[mips_addr] <= mips_writedata;
      assign char_code = mem[screen_addr];                  // Memory read: read continuously, no clock involved
      assign mips_readdata = mem[mips_addr];
endmodule

//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/22/2016 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module imem #(
   parameter Nloc = 4096,                      // Number of memory locations
   parameter Dbits = 32                      // Number of bits in data
)(
    input wire clk,
    input wire wr_enable,
    input wire [31:0] wr_address, wr_data,
    input wire [Dbits-1:0] pc,
    output wire [Dbits-1:0] instr
   );

   localparam initfile = "battleship.mem";       // Name of file with initial values   
   //wire word_aligned_pc = {pc[Dbits-1:0],2'b00};
   logic [Dbits-1 : 0] mem [Nloc-1 : 0];     // The actual storage where data resides
   initial $readmemh(initfile, mem, 0, Nloc-1); // Initialize memory contents from a file
   assign instr = mem[pc[11:0]>>2];                  // Memory read: read continuously, no clock involved

       always_ff @(posedge clk) begin
        if (wr_enable) begin
            mem[wr_address[$clog2(Nloc)+1:2]] <= wr_data;
        end
    end
endmodule
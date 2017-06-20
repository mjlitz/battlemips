//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/22/2016 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module imem #(
   parameter Nloc = 64,                      // Number of memory locations
   parameter Dbits = 32,                      // Number of bits in data
   parameter initfile = "instr_init.txt"       // Name of file with initial values
)(
    input wire [Dbits-1:0] pc,
    output wire [Dbits-1:0] instr
   );
   
   //wire word_aligned_pc = {pc[Dbits-1:0],2'b00};
   logic [Dbits-1 : 0] mem [Nloc-1 : 0];     // The actual storage where data resides
   initial $readmemh(initfile, mem, 0, Nloc-1); // Initialize memory contents from a file
   assign instr = mem[pc[Dbits-1:0]>>2];                  // Memory read: read continuously, no clock involved

endmodule
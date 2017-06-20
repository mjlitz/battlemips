//////////////////////////////////////////////////////////////////////////////////
//
// Matt Litzsinger
// 3/29/2017 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module dmem #(
   parameter Nloc = 256,                      // Number of memory locations
   parameter Dbits = 32,                      // Number of bits in data
   parameter initfile = "dmem.mem"       // Name of file with initial values
)(
   input wire clock,
   input wire wr,                            // WriteEnable:  if wr==1, data is written into mem
   input wire [5:0] addr,     // Address for specifying memory location
                                             //   num of bits in addr is ceiling(log2(number of locations))
   input wire [31:0] din,             // Data for writing into memory (if wr==1)
   output wire [31:0] dout           // Data read from memory (asynchronously, i.e., continuously)
   );

   //wire [5:0] word_addr = 0;
   //assign word_addr = {addr[7:2]};

   logic [Dbits-1 : 0] mem [255 : 0];     // The actual storage where data resides
   initial $readmemh(initfile, mem, 0, 255); // Initialize memory contents from a file

   always_ff @(posedge clock)                // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         mem[addr] <= din;
   assign dout = mem[addr];                  // Memory read: read continuously, no clock involved

endmodule
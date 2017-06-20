//////////////////////////////////////////////////////////////////////////////////
//
// Matt Litzsinger
// 4/9/17
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"

module bitmapmem #(
   /*parameter charx = 16,
   parameter chary = 16,*/
   parameter initfile = "sprites.mem"       // Name of file with initial values
)(
   input wire [15 : 0] bitaddr,     // Address for specifying character
   output wire [11:0] rgbout      // Data read from memory (asynchronously, i.e., continuously)
   );

   logic [11:0] mem [(`chary*`charx*`nchar)-1 : 0];     // The actual storage where data resides
   initial $readmemh(initfile, mem, 0,(`chary*`charx*`nchar)-1); // Initialize memory contents from a file

   assign rgbout = mem[bitaddr];

endmodule
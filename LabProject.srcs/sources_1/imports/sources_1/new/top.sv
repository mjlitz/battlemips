//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/29/2017 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module top #(
    parameter imem_init="sqr_imem.mem",		// correct filename inherited from parent/tester
    parameter dmem_init="sqr_dmem.mem"		// correct filename inherited from parent/tester
)(
    input wire clk, reset
);
   
   wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
   wire mem_wr;

   mips mips(clk, reset, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);
   imem #(.Nloc(64), .Dbits(32), .initfile(imem_init)) imem(pc[31:0], instr);
   dmem #(.Nloc(64), .Dbits(32), .initfile(dmem_init)) dmem(clk, mem_wr, mem_addr, mem_writedata, mem_readdata);

endmodule
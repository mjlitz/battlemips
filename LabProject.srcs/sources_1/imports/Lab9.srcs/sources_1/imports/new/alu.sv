`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Matt Litzsinger
// 
// Create Date: 01/28/2017 05:02:50 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU # (parameter N = 8)(
    input wire [N-1:0] A, B,
    output wire [N-1:0] R,
    input wire [4:0] ALUfn,
    output wire FlagZ
    );
   
   wire subtract, bool1, bool0, shft, math;
   wire [N-1:0] addsubResult, shiftResult, logicalResult, compResult;
   wire FlagN, FlagC, FlagV;
   assign {subtract, bool1, bool0, shft, math} = ALUfn[4:0];
   
   addsub  #(N) AS(A,B,subtract,addsubResult,FlagN,FlagC,FlagV);
   shifter #(N) S(B,A[$clog2(N)-1:0],bool1,bool0,shiftResult);
   logical #(N) L(A,B,ALUfn[3:2],logicalResult);
   comparator   C(FlagN,FlagV,FlagC,bool0,compResult);
   
   assign R = (shft  &  math) ? {{(N-1){1'b0}}, compResult}:
              (~shft &  math) ? addsubResult :
              (shft  & ~math) ? shiftResult  :
              (~shft & ~math) ? logicalResult: 0;
   assign FlagZ = ~|R; 
    
endmodule

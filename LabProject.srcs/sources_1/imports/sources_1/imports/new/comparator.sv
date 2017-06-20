`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Matt Litzsinger
// 
// Create Date: 01/30/2017 08:27:09 PM
// Design Name: 
// Module Name: comparator
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


module comparator #(parameter N = 32) (
    input wire FlagN, FlagV, FlagC, bool0,
    output wire [N-1:0] comparison
    );
    //                          LTU       LT
    assign comparison[0] = bool0? ~FlagC : FlagN ^ FlagV;
    assign comparison[N-1:1] = {N-1{1'b0}};
endmodule

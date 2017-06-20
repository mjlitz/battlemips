`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Matt Litzsinger
// 
// Create Date: 01/28/2017 02:36:41 PM
// Design Name: 
// Module Name: logical
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


module logical #(parameter N=32)(
    input wire [N-1:0] A, B,
    input wire [1:0] op,
    output wire [N-1:0] R
    );
    
    assign R = (op == 2'b00) ? A & B:
               (op == 2'b01) ? A | B:
               (op == 2'b10) ? A ^ B:
               (op == 2'b11) ? ~A & ~B: {N{1'b1}};//since there is no NOR binary op, just use demorgan's law, AND the complements.
endmodule

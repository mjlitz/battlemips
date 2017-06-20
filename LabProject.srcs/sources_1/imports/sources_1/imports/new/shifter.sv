`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Matt Litzsinger
// 
// Create Date: 01/28/2017 04:29:40 PM
// Design Name: 
// Module Name: shifter
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


module shifter #(parameter N=32)(
    input wire signed [N-1:0] IN,
    input wire [$clog2(N)-1:0] shamt,
    input wire right, arithmetic,
    output wire [N-1:0] OUT
    );
    //                                  sra             srl
    assign OUT = right ? (arithmetic ? IN >>> shamt : IN >> shamt):
                         (IN << shamt);//sll
endmodule

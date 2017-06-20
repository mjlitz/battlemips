`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Matt Litzsinger
// Create Date: 02/12/2017 03:00:08 PM
// 
//////////////////////////////////////////////////////////////////////////////////

module vgadisplaydriver(
    input wire clk,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [`xbits-1:0] x,
    output wire [`ybits-1:0] y,
    input wire char_code
    );
    
    wire activevideo;
    
    vgatimer myvgatimer (clk, hsync, vsync, activevideo, x, y);
    /*bitmapmem mem (bitmapaddr,color);*/
    
    assign red[3:0]   = (activevideo == 1) ? x[5:2] : 4'b0;
    assign green[3:0] = (activevideo == 1) ? y[5:2] : 4'b0;
    assign blue[3:0]  = (activevideo == 1) ? x[5:2] + y[5:2] : 4'b0;
endmodule

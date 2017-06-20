`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Matt Litzsinger
// Create Date: 02/12/2017 03:00:08 PM
// 
//////////////////////////////////////////////////////////////////////////////////
//clk,red,green,blue,hsync,vsync,smem_addr,charcode
module vgadisplaydriver(
    input wire clock,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [10:0] screen_addr,
    input wire [7:0] char_code
    );
    
    
    wire activevideo;
    
    wire [`ybits+1:0] ytile;
    
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire [11:0] rgb;
     wire [15:0] bmem_addr;
    
    logic [`xbits-5:0] screen_x;
    logic [10:0] screen_y;
    
    vgatimer myvgatimer (clock, hsync, vsync, activevideo, x, y);
    bitmapmem mem (bmem_addr,rgb);
    
    assign bmem_addr = {char_code,y[3:0],x[3:0]};
    
    assign ytile = {6'b0,y[`ybits-1:4]};
    assign screen_x = x[`xbits-1:4];
    assign screen_y = (ytile<<5) + (ytile<<3);
    assign screen_addr = screen_x+screen_y;
    
    assign red[3:0]   = (activevideo == 1) ? rgb[11:8]: 4'b0;
    assign green[3:0] = (activevideo == 1) ? rgb[7:4] : 4'b0;
    assign blue[3:0]  = (activevideo == 1) ? rgb[3:0] : 4'b0;
endmodule

`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
// Matt Litzsinger 
// 4/9/2017
//////////////////////////////////////////////////////////////////////////////////

module display (
    input wire clk,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [10:0] screen_addr,
    input wire [7:0] char_code
    );
    
    vgadisplaydriver vga(clk,red,green,blue,hsync,vsync,screen_addr, char_code);
    //screenmem mem(screen_addr,char_code);
    
    //assign wr = 0;
    //assign charin = 0;
endmodule

`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Matt Litzsinger 
// Create Date: 02/12/2017 02:22:28 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module vgatimer(
    input wire clk,
    output wire hsync, vsync, activevideo,
    output wire [`xbits-1:0] x,
    output wire [`ybits-1:0] y
    );
    
    //Count every 2nd & 4th clock tick. depending on the display mode, we may need to count @ 25 or 50 MHz.
    logic [1:0] clk_count = 0;
    always_ff @(posedge clk)
        clk_count <= clk_count + 2'b 01;
    logic Every2ndTick, Every4thTick;
    assign Every2ndTick = (clk_count[0] == 1'b 1);
    assign Every4thTick = (clk_count[1:0] == 2'b 11);
    
    //Instantiate an xy-counter with the right clock counter
    xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y);
    
    //Generate the monitor sync signals
    assign hsync = (x < `hSyncStart || x > `hSyncEnd)? `hSyncPolarity : ~`hSyncPolarity;
    assign vsync = (y < `vSyncStart || y > `vSyncEnd)? `vSyncPolarity : ~`vSyncPolarity;
    assign activevideo = x < `hVisible && y < `vVisible; 
    
endmodule

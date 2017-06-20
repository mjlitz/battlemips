`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Matt Litzsinger 
// Create Date: 02/04/2017 05:23:44 PM

//////////////////////////////////////////////////////////////////////////////////


module xycounter #(parameter width=2,height=2)(
    input wire clock,
    input wire enable,
    output logic [$clog2(width)-1:0] x = 0,
    output logic [$clog2(height)-1:0] y = 0
    );
    
    always_ff @ (posedge clock) begin
        if (enable)
            begin
            x <= (x == width-1)? 0 : x+1;
            y <= (y == height-1 && x == width-1)? 0 : y+(x == width-1);
            end
        else
            begin
            x <= x;
            y <= y;
            end
    end
endmodule


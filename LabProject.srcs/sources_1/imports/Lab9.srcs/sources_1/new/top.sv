//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/29/2017 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module top #(
    parameter imem_sim="imem_sim.mem",		// correct filename inherited from parent/tester
    parameter imem_board="imem_board.mem",
    parameter dmem_init="dmem.mem"		// correct filename inherited from parent/tester
)(
    input wire clk,
    //Keyboard
    input wire ps2_data,
    input wire ps2_clk,
    input wire switch, UART_RX, UART_CTS,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [7:0] segments, digitselect,
    output wire UART_TX,UART_RTR
);
   
   wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
   wire [31:0] accel,keyboard;
   wire mem_wr;
   wire clk100, clk50, clk25, clk12;
   
      // Uncomment *only* one of the following two lines:
   //    when synthesizing, use the first line
   //    when simulating, get rid of the clock divider, and use the second line
   //
   clockdivider_Nexys4 clkdv(clk, clk100, clk50, clk25, clk12);   // use this line for synthesis/board deployment
   //assign clk100=clk; assign clk50=clk; assign clk25=clk; assign clk12=clk;  // use this line for simulation/testing

   // For synthesis:  use an appropriate clock frequency(ies) below
   //   clk100 will work for hardly anyone
   //   clk50 or clk 25 should work for the vast majority
   //   clk12 should work for everyone!  I'd say use this!
   // Use the same clock frequency for the MIPS and data memory/memIO modules
   // The VGA display and 8-digit display should keep the 100 MHz clock.

//internal wires
   wire [7:0] charcode;
   wire [10:0] smem_addr;
   logic wr_imem;
   logic [31:0] addr_imem,data_imem;
   logic [2:0] state;
   wire [31:0] keyb_char;

   mips mips(clk12, switch, pc, instr, mem_wr,mem_addr, mem_writedata, mem_readdata);
   programloader pl (clk12,switch,UART_RX,UART_TX,UART_CTS,UART_RTR,wr_imem,addr_imem,data_imem);
   imem imem (clk12,wr_imem,addr_imem,data_imem,pc, instr);
   memIO memIO (clk12,mem_wr,mem_addr,mem_writedata,mem_readdata, smem_addr, charcode,keyb_char);
   display display(clk,red,green,blue,hsync,vsync,smem_addr,charcode);
   display8digit d8d(keyb_char,clk,segments,digitselect);
   keyboard k(clk, ps2_clk, ps2_data, keyb_char);

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2017 05:27:26 PM
// Design Name: 
// Module Name: memIO
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


module memIO #(
    parameter dmem_init="dmem.mem"		// correct filename inherited from parent/tester
)(   
    input wire clk,
    //dmem
    input wire mem_wr,
    input wire [31:0] mem_addr, mem_writedata, 
    output wire [31:0] mem_readdata,
   //vga
    input wire [10:0] screen_addr,
    output wire [7:0] char_code,
    input wire [31:0] keyb_char,
   //various I/O
   
    /*output wire [15:0] led, 
    output wire audEn,
    output wire [31:0] period,
    input wire [31:0] accel, keyboard,*/
    
    output wire smem_wr, dmem_wr, lights_wr, sound_wr
   
    );
    //wire [`char_code_bits-1:0] charin;
    
    wire [31:0] dmem_readdata, smem_readdata;
    //wire [31:0] keyboard, accel;//put in input!
    reg [31:0] sound;
        
    assign smem_wr   = (mem_addr[17:16] == 2'b10) & mem_wr;
    assign dmem_wr   = (mem_addr[17:16] == 2'b01) & mem_wr;
    assign lights_wr = (mem_addr[17:16] == 2'b11  & mem_addr[3:2] == 2'b11)&mem_wr;
    assign sound_wr  = (mem_addr[17:16] == 2'b11  & mem_addr[3:2] == 2'b10)&mem_wr;
    
    assign mem_readdata = (mem_addr[17:16] == 2'b01)? dmem_readdata :
                          (mem_addr[17:16] == 2'b10)? smem_readdata : 
                          (mem_addr[17:16] == 2'b11)? 
                          ((mem_addr[3:2] == 2'b00)? keyb_char : 32'h00000000) : 32'h00000000;   
    
   /*assign sound = sound_wr?mem_writedata:8'h00000000;
   assign led[7:0] = lights_wr?mem_writedata[11:4]:2'h00;
   assign led[15:8]= lights_wr?mem_writedata[27:20]:2'h00;*/
    
    dmem  dmem(clk, dmem_wr, mem_addr[7:2], mem_writedata, dmem_readdata);
    //first port for VGA driver, second for MIPS
    screenmem smem(clk,screen_addr,char_code,smem_wr,mem_addr[12:2],mem_writedata,smem_readdata);

endmodule

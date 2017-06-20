`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2017 03:31:01 PM
// Design Name: 
// Module Name: datapath
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


module datapath #(

   parameter Abits = 5,        // Number of bits in register address
   parameter Dbits = 32,       // Number of bits in data (regs, ALU)
   parameter Nloc = 32        // Number of registers
   )( 
   
   // Inputs
   input wire clock,
   input wire reset,
   output logic [Dbits-1:0] pc = 0,
   input wire [Dbits-1:0] instr,
   input wire [1:0] pcsel, wasel,
   input wire sext, bsel,
   input wire [1:0] wdsel,
   input wire [4:0] alufn,
   input wire werf,
   input wire [1:0] asel,
   output wire Z, 
   output wire [Dbits-1:0] mem_addr,
   output wire [Dbits-1:0] mem_writedata,
   input  wire [Dbits-1:0] mem_readdata
    );
    
    //Program Counter wires
    //wire [Dbits-1:0] pcPlus4;
    wire [Dbits-1:0] newPC, BT;
    //Register wires
    wire [Dbits-1:0] reg_writedata;
    wire [Dbits-1:0] ReadData1, ReadData2;
    wire [Abits-1:0] ReadAddr1, ReadAddr2;
    wire [Abits-1:0] reg_writeaddr;
    //ALU wires
    wire [Dbits-1:0] alu_result;
    wire [Dbits-1:0] signImm;
    wire [Dbits-1:0] aluA, aluB;

    //Program Counter wiring and logic
    always_ff @(posedge clock) begin
        if (reset)
            pc <= 0;
        else if (pcsel[1:0] == 2'b00)
            pc <= pc+4;
        else if (pcsel[1:0] == 2'b01)
            pc <= (signImm << 2) + pc+4;
        else if (pcsel[1:0] == 2'b10)
            pc <= {pc[31:28],instr[25:0],2'b00};
        else
            pc <= ReadData1;
    end
    
    //register file wiring logic
    assign ReadAddr1 = instr[25:21];
    assign ReadAddr2 = instr[20:16];
                                    //31 literal              Rt           Rd           
    assign reg_writeaddr = wasel[1]? 8'h0000001f  : wasel[0]? instr[20:16] : instr[15:11];
    assign reg_writedata = wdsel[1]? mem_readdata : wdsel[0]? alu_result   : pc+4;
    
    //ALU wiring logic
    assign mem_addr = alu_result;
    assign mem_writedata = ReadData2;
    assign signImm = {{16{instr[15] & sext}},instr[15:0]};
                          //16 literal            shamt         data from reg 1       
    assign aluA = asel[1]? 8'h00000010 : asel[0]? instr[10:6] : ReadData1;
    assign aluB = bsel? signImm : ReadData2;
    
    //Modules
    register_file #(Nloc, Dbits) rf (clock, werf, ReadAddr1, ReadAddr2, reg_writeaddr, reg_writedata, ReadData1, ReadData2);
    ALU #(Dbits) alu (aluA, aluB, alu_result, alufn, Z);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2020 01:04:48 PM
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


module datapath(
    input wire clk,
    input wire pcWriteCond,
    input wire pcWrite,
    input wire iOrD,
    input wire memRead,
    input wire memWrite,
    input wire memToReg,
    input wire irWrite,
    input wire [1:0] pcSource,
    input wire [2:0] aluControl,
    input wire [1:0] aluSrcB,
    input wire aluSrcA,
    input wire regWrite,
    input wire regDst,
    output wire [5:0] op,
    output wire [5:0] funct
    );
    
    wire [31:0] memData;
    wire zero;
    wire [31:0] aluResult;
    reg [31:0] aluOut;
    reg [31:0] pc;
    reg[31:0] instructionRegister;
    
    wire [31:0] registerA;
    wire [31:0] registerB;
    reg [31:0] aluInputB;
    reg [31:0] mdr;
    
    initial begin
        $display("Initial setup");
        pc = 32'b0;
    end
    
    // Memory
    memory memory(
        clk,
        iOrD? aluOut: pc,
        registerB,
        memRead,
        memWrite,
        memData
    );
    
    // Registers
    registers registers(
        clk,
        regWrite,
        instructionRegister[25:21],
        instructionRegister[20:16],
        regDst? instructionRegister[15:11]: instructionRegister[20:16],
        memToReg? mdr: aluOut,
        registerA,
        registerB
    );
    
    // ALU
    alu alu(
        aluSrcA? registerA: pc,
        aluInputB,
        aluControl,
        zero,
        aluResult
    );
    
    // OP Code
    assign op = instructionRegister[31:26];
    
    //Funct
    assign funct = instructionRegister[5:0];
    
    // Assign input B for ALU
    always @ * begin
        case(aluSrcB)
            2'b00: aluInputB <= registerB;
            2'b01: aluInputB <= 4;
            2'b10: aluInputB <= {{(16){instructionRegister[15]}},instructionRegister[15:0]};
        endcase
    end
    
    // Assign ALUOut
    always @(posedge clk) begin
        aluOut = aluResult;
    end
    
    // Instruction Register
    always @(posedge clk) begin
        mdr <= memData;
        
        if(irWrite)
            instructionRegister <= memData;
    end
    
    //Pc Logic
    always @(posedge clk) begin
        if((zero && pcWriteCond) || pcWrite) begin
            case(pcSource)
                2'b00: pc = aluResult;
                2'b01: pc = aluOut;
                2'b10: pc = {pc[31:28], instructionRegister[25:0] << 2};
             endcase
        end
    end
    
endmodule

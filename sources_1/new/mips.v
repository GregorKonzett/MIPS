`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2020 04:12:49 PM
// Design Name: 
// Module Name: mips
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


module mips(
    input wire clk
);

reg[31:0] pc;
wire pcWriteCond;
wire pcWrite;
wire IorD;
wire memRead;
wire memWrite;
wire memToReg;
wire irWrite;
wire[1:0] pcSource;
wire[1:0] aluOp;
wire aluSrcA;
wire[1:0] aluSrcB;
wire regWrite;
wire regDst;
wire[5:0] funct;
reg[2:0] aluControl;
reg[31:0] aluOut;
reg[31:0] registerB;
reg[31:0] registerA;
wire[31:0] memData;
reg[31:0] instructionRegister;
reg[31:0] mdr;
reg zero;
wire[31:0] aluResult;

assign funct = instructionRegister[5:0];

// Generating the control signal for the ALU
alucontrol alucontrol(aluOp, funct, aluControl);

reg[31:0] aluB;

// ALU
alu alu(clk, aluSrcA? pc: registerA, aluB, aluControl, aluOut, zero);

// Control Signals
control control(clk, instructionRegister[31:26], pcWriteCond, pcWrite, IorD, memRead, memWrite, memToReg, irWrite, pcSource, aluOp, aluSrcB, aluSrcA, regWrite, regDst);

// Memory
memory memory(clk, IorD? aluOut: pc, registerB, memRead, memWrite, memData);

// Instruction Register
instruction_register ir(clk, memData, instructionRegister);

always @(posedge clk) begin
    mdr <= memData;
    
    // PC Logic
    if((zero & pcWriteCond) | pcWrite) begin
        case(pcSource)
            2'b00: pc <= aluResult;
            2'b01: pc <= aluOut;
            2'b11: pc <= {pc[31:28], instructionRegister[25:0] << 2};
        endcase
    end
    
    // ALU Src B
    case(aluSrcB)
        2'b00: aluB = registerB;
        2'b01: aluB = 32'd4;
        2'b10: aluB = { {16{instructionRegister[15]}}, instructionRegister[15:0] };
        2'b11: aluB = { {16{instructionRegister[15]}}, instructionRegister[15:0] } << 2;
    endcase
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2020 06:32:07 PM
// Design Name: 
// Module Name: control
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


module control(
    input wire clk,
    input wire [5:0] op,
    input wire [5:0] funct,
    output wire pcWriteCond,
    output wire pcWrite,
    output wire iOrD,
    output wire memRead,
    output wire memWrite,
    output wire memToReg,
    output wire irWrite,
    output wire [1:0] pcSource,
    output wire [1:0] aluSrcB,
    output wire aluSrcA,
    output wire regWrite,
    output wire regDst,
    output wire [2:0] aluControl
    );
    
    reg [2:0] aluOp;
    
    // ALU Control
    alucontrol alucontrol(
        clk,
        aluOp,
        funct,
        aluControl
    );
endmodule

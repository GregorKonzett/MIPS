`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2020 12:59:55 PM
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
    input clk
    );
    
    wire pcWrite;
    wire pcWriteCond;
    wire iOrD;
    wire memRead;
    wire memWrite;
    wire memToReg;
    wire irWrite;
    wire [1:0] pcSource;
    wire [2:0] aluControl;
    wire [1:0] aluSrcB;
    wire aluSrcA;
    wire regWrite;
    wire regDst;
    wire [5:0] op;
    wire [5:0] funct;
    
    control control(
        clk,
        op,
        funct,
        pcWriteCond,
        pcWrite,
        iOrD,
        memRead,
        memWrite,
        memToReg,
        irWrite,
        pcSource,
        aluSrcB,
        aluSrcA,
        regWrite,
        regDst,
        aluControl
    );
    
    // Datapath
    datapath datapath(
        clk,
        pcWriteCond,
        pcWrite,
        iOrD,
        memRead,
        memWrite,
        memToReg,
        irWrite,
        pcSource,
        aluControl,
        aluSrcB,
        aluSrcA,
        regWrite,
        regDst,
        op,
        funct
    );
endmodule

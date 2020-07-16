`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2020 03:14:55 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] aluControl,
    output wire zero,
    output reg [31:0] aluResult
    );
    
    always @ * begin
        case(aluControl)
            3'b000: aluResult = a & b;
            3'b001: aluResult = a | b;
            3'b010: aluResult = a + b;
            3'b110: aluResult = a - b;
            3'b111: aluResult = a<b? 1: 0;
        endcase
    end
    
    assign zero = (aluResult == 0? 0: 1);
endmodule

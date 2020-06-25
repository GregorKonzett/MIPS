`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2020 08:35:19 PM
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
    input clk,
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] aluControl,
    output reg [31:0] aluOut,
    output reg zero
    );
    
    always @(posedge clk) begin
        case(aluControl)
            3'b000: aluOut = a & b;
            3'b001: aluOut = a | b;
            3'b010: aluOut = a + b;
            3'b110: aluOut = a - b;
            3'b111: aluOut = a>b? 1: 0;
        endcase
        
        zero <= (aluOut == 0);
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/25/2020 08:57:00 PM
// Design Name: 
// Module Name: intsruction_register
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


module instruction_register(
    input wire clk,
    input wire[31:0] memData,
    output reg[31:0] instructionRegister
    );
    
    always @(posedge clk) begin
        instructionRegister <= memData;
    end
    
endmodule

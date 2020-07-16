`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2020 03:08:42 PM
// Design Name: 
// Module Name: registers
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


module registers(
    input wire clk,
    input wire regWrite,
    input wire readRegister1,
    input wire readRegister2,
    input wire [31:0] address,
    input wire [31:0] data,
    output reg [31:0] readData1,
    output reg[31:0] readData2
    );
    
    reg [31:0] registers [31:0];
    
     // Registers
    always @(posedge clk) begin
        readData1 <= registers[readRegister1];
        readData2 <= registers[readRegister2];
        
        if(regWrite) begin
            registers[address] <= data;
        end
    end
    
endmodule

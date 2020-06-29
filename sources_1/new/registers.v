`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2020 09:21:06 PM
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
    input wire regWrite,
    input wire [4:0] readRegister1,
    input wire [4:0] readRegister2,
    input wire [4:0] writeRegister,
    input wire [31:0] writeData,
    output reg [31:0] a,
    output reg [31:0] b
    );
    
    reg[31:0] register[31:0];
    
    always @(*) begin
        a = register[readRegister1];
        b = register[readRegister2];
        
        if (regWrite)
            register[writeRegister] = writeData;
    end
endmodule

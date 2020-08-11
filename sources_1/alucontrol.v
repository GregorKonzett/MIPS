`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2020 03:26:46 PM
// Design Name: 
// Module Name: alucontrol
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


module alucontrol(
    input wire clk,
    input wire [2:0] aluOp,
    input wire [5:0] funct,
    output reg [2:0] aluControl
    );
    
    always @* begin
        casex ({aluOp, funct})
            8'b00_xxxxxx: aluControl = 3'b010;            // (addi, lw, sw)
            8'b01_xxxxxx: aluControl = 3'b110;            //  - (beq, bne)
            8'b01_100000: aluControl = 3'b110;            // add
            8'b01_100010: aluControl = 3'b110;            // sub
            8'b01_100100: aluControl = 3'b110;            // and
            8'b01_100101: aluControl = 3'b110;            // or
            8'b01_101010: aluControl = 3'b110;            // slt
        endcase
    end
endmodule

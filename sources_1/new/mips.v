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

wire[1:0] aluOp;
wire[5:0] funct;
reg[2:0] aluControl;

// Generating the control signal for the ALU
alucontrol alucontrol(aluOp, funct, aluControl);

endmodule

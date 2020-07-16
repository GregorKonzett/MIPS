`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2020 08:43:34 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;

    reg clk;
    reg[31:0] a;
    reg[31:0] b;
    reg[2:0] aluControl;
    wire[31:0] aluOut;
    wire zero;
    
    alu UUT(clk, a, b, aluControl, aluOut, zero);
    
    initial begin
        clk = 0;
        a = 32'd2;
        b = 32'd3;
        aluControl = 3'b000;
        
        #2 aluControl = 3'b001;
        #10 aluControl = 3'b000;
        
        #10 $finish;
    end
    
    always begin
        #2 clk = !clk;
    end

endmodule

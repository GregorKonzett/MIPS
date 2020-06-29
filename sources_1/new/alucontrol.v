`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2020 04:12:28 PM
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
// http://fourier.eng.hmc.edu/e85_old/lectures/processor/node5.html

module alucontrol(
    input wire[1:0] aluOp,
    input wire[5:0] funct,
    output reg[2:0] aluControl
    );
   
    always @(aluOp, funct)
    begin
        case (aluOp)
            2'b00: aluControl = 3'b010;            // (addi, lw, sw)
            2'b01: aluControl = 3'b110;            //  - (beq, bne)
            2'b1x: begin
                case (funct)
                    32: aluControl = 3'b010;       // add
                    34: aluControl = 3'b110;       // sub
                    36: aluControl = 3'b000;       // and
                    37: aluControl = 3'b001;       // or
                    42: aluControl = 3'b111;       // slt
                    default: aluControl = 3'bxxx;  // undefined
                endcase
            end
            default: aluControl = 3'bxxx;          // undefined
        endcase
    end
endmodule

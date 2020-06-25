`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/25/2020 08:40:41 PM
// Design Name: 
// Module Name: memory
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


module memory(
    input wire clk,
    input wire[31:0] address,
    input wire[31:0] writeData,
    input wire memRead,
    input wire memWrite,
    output wire[31:0] memData
    );
    
    reg[31:0] dataMemory[255:0];
    
    initial begin
        $readmemb("instructions.mem", dataMemory);
    end
    assign memData = memRead? dataMemory[address] : 32'bx;
    
    always @(posedge clk) begin
        if(memWrite) begin
            dataMemory[address] <= memData;
        end
    end 
    
endmodule

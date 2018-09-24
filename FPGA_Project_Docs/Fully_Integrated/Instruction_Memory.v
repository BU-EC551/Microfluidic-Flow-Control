`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2018 05:02:06 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(instruction, Address, ReadData, start, i, clk);
input [12:0] instruction;
input [7:0] Address;
input [7:0] i;
input start, clk;
output reg [12:0] ReadData;

reg [12:0] memory [0:100];

always@(start, Address, memory[Address]) begin
    if(start)
        ReadData <= memory[Address];
end
always @(posedge clk) begin
    if(start == 0)
        memory[i] <= instruction;
end
endmodule

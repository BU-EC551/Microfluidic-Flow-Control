`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2018 11:41:46 PM
// Design Name: 
// Module Name: Latch
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


module Latch(clk, rst, D, Q);
input clk, rst;
input D;
output reg Q;

always @(*)
    if(rst)
        Q <= 1'b0;
    else if (~clk)
        Q <= D;
endmodule

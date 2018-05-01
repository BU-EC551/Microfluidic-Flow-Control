`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2018 09:05:39 PM
// Design Name: 
// Module Name: top_mod_test
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


//This is the testbench for the whole processor

module top_mod_test;
reg clk;
reg rst;
wire PWM;

Top_mod uut (.clk(clk), .rst(rst),.PWM(PWM));

initial begin

clk=0;
rst=1;     // Reset
#20;
rst=0;
#20;
end

always #5 clk=~clk; // Simulate 100MHz board clock

endmodule

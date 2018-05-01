`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 09:12:09 PM
// Design Name: 
// Module Name: Servo_TB
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


module Servo_TB;
reg [7:0] sw;
reg clr;
reg clk;
wire PWM;

Servo_interface uut(
.sw(sw),
 .clr(clr), .clk(
clk), .PWM(PWM));

always
begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
clr = 1; #1 clr = 0;
sw = 2;
end

endmodule

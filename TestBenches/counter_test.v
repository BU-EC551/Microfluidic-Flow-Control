`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 06:35:11 PM
// Design Name: 
// Module Name: counter_test
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


module counter_test;
wire count_done;
reg [9:0] manual_delay;
reg [9:0] delay;
reg [2:0] delay_unit;
reg clk, rst, start;
reg debug_flag;
counter uut (.manual_delay(manual_delay), .debug_flag(debug_flag), .delay(delay), .delay_unit(delay_unit), .count_done(count_done), .clk(clk), .rst(rst));

initial begin

/*#10;

rst = 0;
manual_delay = 0;
delay_unit = 3'b000;
delay = 9'b00000_00000;
debug_flag = 0;
start = 0;

#10;

rst = 1;
clk = 0;

#10;*/

/*rst = 0;
start = 1;
manual_delay = 0;
delay_unit = 3'b000;
delay = 9'b00011_00100;
debug_flag = 0;


#10;*/

rst = 0;
start = 1;
manual_delay = 0;
delay_unit = 3'b000;
delay = 9'b00000_01010;
debug_flag = 0;
end
parameter clk_period = 10;
 initial 
     clk = 0;
     always #5 
         clk = ~clk;
endmodule

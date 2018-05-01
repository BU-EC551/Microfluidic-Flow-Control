`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2018 07:16:49 PM
// Design Name: 
// Module Name: testpc
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


module testpc;
reg clk, rst, set, delay, set_done, count_done;
wire [7:0] pcout;
pc uut(.clk(clk), .rst(rst), .set(set),.delay(delay),.set_done(set_done),.count_done(count_done),.pcout(pcout));
initial begin
#10;
clk <= 0;
set <= 0;
delay <= 0;
set_done <= 0;
count_done <= 0;

#10;
set <= 1;
#10;
set_done <= 1;
set <= 0;
#10;
delay <= 1;
set_done <= 0;
#10;
count_done <= 1;
delay <= 0;
#10
count_done <= 0;
end
always #5 clk=~clk;
endmodule

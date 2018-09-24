`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2018 12:16:39 PM
// Design Name: 
// Module Name: Test_bench
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


module Test_bench;
    
    reg clk, rst, start;
    reg [7:0] i;
    reg [12:0] instruction;
    wire PWM_0, PWM_1, PWM_2, PWM_3;
    wire demux_out0, demux_out1, demux_out2, demux_out3;
    wire count_done, rst_flag, delay_start;
    Top_mod uut (.clk(clk), .rst(rst), .count_done(count_done), .i(i),.start(start), .instruction(instruction), .PWM_0(PWM_0), .PWM_1(PWM_1), .PWM_2(PWM_2), .PWM_3(PWM_3), .delay_start(delay_start), .rst_flag(rst_flag), .demux_out0(demux_out0), .demux_out1(demux_out1), .demux_out2(demux_out2), .demux_out3(demux_out3)); //Top level Module
 
    initial begin
    #100;
    clk = 0;
    rst = 1;     // Reset
    #10;
    rst=0;
    start = 0;
    instruction = 13'b0010001000010;
    i= 8'b00000001;
    
    #10;
    rst=0;
    start = 0;
    instruction = 13'b0100001000000;
    i= 8'b00000010;  
    
    #10
    rst = 0;
    start = 0;
    instruction = 13'b0010001000000;
    i= 8'b00000011;
    
    #10
    rst = 0;
    start = 0;
    instruction = 13'b0100001110000;
    i= 8'b00000100;    
    
    #10;
    rst=0;
    start = 0;
    instruction = 13'b0010010000010;
    i= 8'b0000_0101;
        
    #10;
    rst=0;
    start = 0;
    instruction = 13'b0100001000000;
    i= 8'b0000_0110;  
        
    #10
    rst = 0;
    start = 0;
    instruction = 13'b0010010000000;
    i= 8'b0000_0111;  
        
         
    #10
    rst = 0;
    start = 0;
    instruction = 13'b0110000000000;
    i= 8'b0000_1000;
     
    #10
    rst = 0;
    start = 1;
    end      
    always #5 clk=~clk; // Simulate 100MHz board clock
    
endmodule



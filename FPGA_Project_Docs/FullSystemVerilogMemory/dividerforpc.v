`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 04:35:38 PM
// Design Name: 
// Module Name: dividerforpc
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


module dividerforpc (clk_100mega,  rst , clk_1kHz);

    input clk_100mega;  //Board clock input (100MHz)
    input rst;
    output reg clk_1kHz;    
    reg [16:0] count_reg;   //Counter
    
   
    initial begin
        clk_1kHz = 0;
        count_reg = 0;
    end    
    always @(posedge clk_100mega) 
    begin
        if (rst) 
        begin
            count_reg <= 0;
            clk_1kHz <= 0;
        end 
        else 
        begin
            if (count_reg < 49999)  // 49999999 for 1Hz
                count_reg <= count_reg + 1;
            else 
            begin
                count_reg <= 0;
                clk_1kHz <= ~clk_1kHz;
            end // end else
        end
    end
endmodule

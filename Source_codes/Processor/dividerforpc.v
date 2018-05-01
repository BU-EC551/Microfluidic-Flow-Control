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


module dividerforpc(clk_100m,  rst , clk_50Hz);

    input clk_100m; // 100MHz board clock
    input rst;  
    
    output reg clk_50Hz= 0; // 50Hz clock
        
    reg [19:0] count_reg = 0; // 20 bit register for count
    
    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            count_reg <= 0;
            clk_50Hz <= 0;
        end else begin
            if (count_reg < 999999) begin
                count_reg <= count_reg + 1;
            end 
            else begin
                count_reg <= 0;
                clk_50Hz <= ~clk_50Hz;
            end
        end
    end
endmodule

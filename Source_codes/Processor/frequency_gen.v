`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2018 07:34:02 AM
// Design Name: 
// Module Name: frequency_gen
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


module frequency_gen( clk_100m,  rst , clk_1k
    );
    input clk_100m;
    input rst;
    
    reg [15:0] count_reg = 0;
    output reg clk_1k= 0;
    
    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            count_reg <= 0;
            clk_1k <= 0;
        end else begin
            if (count_reg < 49999) begin
                count_reg <= count_reg + 1;
            end else begin
                count_reg <= 0;
                clk_1k <= ~clk_1k;
            end
        end
    end 
endmodule


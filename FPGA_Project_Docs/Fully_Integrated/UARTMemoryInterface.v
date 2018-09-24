`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2018 06:02:54 PM
// Design Name: 
// Module Name: UARTMemoryInterface
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


module UARTMemoryInterface(clk, rst, atob, instruction, rx_done_tick, start, i);

input clk, rst;
input rx_done_tick;
input [1:0] atob;
output reg [12:0] instruction;
output reg [7:0] i;
output reg start;
reg [1:0] state;
reg [12:0] tempInstruction;


integer j;

initial begin
//instruction = 0;
state <= 0;
i <= 1;
j <= 12;
start <= 0;
end

always @(posedge clk)
begin
    if (rst) begin
        state <= 0;
        //instruction <= 13'b0000_0000_0000_0;
        j <= 12;
        i <= 1;
        start <= 0;
    end
    else if (rx_done_tick) begin
    case(state)
    2'b00: begin
            if((atob == 2'b00 || atob == 2'b01)) begin
                tempInstruction[j] = atob[0];
                j = j - 1;
                if (j < 0) begin
                    instruction = tempInstruction;
                    i = i + 1;
                    j = 12;
                    state = 2'b00;
                end    
                else 
                    state = 2'b00; 
            end
            else /*if (atob == 2'b11)*/begin
                state <= 2'b01;
                start <= 1;
            end
            end
    2'b01: begin
            //start = 1;
            if(atob == 2'b10) begin
                state <= 2'b00;
                start <= 0;
            end
            else
                state = 2'b01;
           end
    2'b10: begin  end
    endcase    
 
end

end
endmodule

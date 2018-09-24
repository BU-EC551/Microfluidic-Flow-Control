`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2018 06:23:34 PM
// Design Name: 
// Module Name: memory
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


module memory (clk, rst, atob, instruction, rx_done_tick);

input clk, rst;
input rx_done_tick;
input [1:0] atob;
output reg [12:0] instruction;

reg [1:0] state;
reg [12:0] memory_file [0:99];

integer i;
integer j;

initial begin
//instruction = 0;
state = 0;
i = 0;
j = 0;

end

always @(posedge clk)
begin
    if (rst) begin
        state <= 0;
        instruction <= 13'b0000_0000_0000_0;
        j <= 0;
        i <= 0;
    end
    else if (rx_done_tick) begin
    case(state)
    2'b00: begin
            if(atob[0] == 0 || atob[0] == 1) /*&& rx_done_tick == 1)*/ begin
                instruction[j] = atob[0];
                j = j + 1;
                if (j > 12) begin
                    memory_file[i] = instruction;
                    i = i + 1;
                    j = 0;
                    state = 2'b00;
                end    
                else begin
                    //j <= j + 1;
                    state = 2'b00;
                end
            end
      else /*if((atob == 2) && rx_done_tick == 1)*/
                state <= 2'b00;
      end
    2'b01: begin
            
           end
    2'b10: begin  end
    endcase        
end
end
endmodule

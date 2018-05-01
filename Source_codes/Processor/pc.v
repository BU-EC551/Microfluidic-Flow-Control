`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2018 07:08:36 PM
// Design Name: 
// Module Name: pc
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


module pc(
input rst,
input clk,
input pchalt,
input delay,
input count_done, 
output reg [7:0] pcout
    );

initial
begin

pcout <= 8'b0000_0000;  //Initially set program counter to zero

end
    
always@(posedge clk)
begin
   if(rst || pchalt)  //If reset or halt is encountered set the program counter to zero
      pcout <= 0;
   else begin
      if (delay==1&& count_done==0) begin //If delay instruction is encountered and required delay has not been achieved,
                                          //Program counter will continue to hold its state
         pcout <= pcout;
         
      end
      else if(delay==1&& count_done==1) begin //If delay is achieved and count is completed, increment the program counter
         pcout <= pcout + 1;
      end
      else
         pcout <= pcout + 1;
    end //else
  end  //always
endmodule

    

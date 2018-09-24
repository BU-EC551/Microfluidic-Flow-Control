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
        pcout = 8'b0000_0000;   //Program counter starts from 0th location in instruction memory
    end
        
    always@(posedge clk)    //100MHz clock
    begin
        if (rst)
            pcout <= 0;
        else if(pchalt)       //new
            pcout <= pcout;       //new
        else if(delay==1&& count_done==0) //Program counter cannot be incremented
        begin                       //until delay counter reaches desired value
            pcout <= pcout;
        end
        
        else if(delay==1&& count_done==1)   //Increment the program counter 
        begin                               //when delay is achieved
            pcout <= pcout + 1;
        end
        
        else if(delay==0&& count_done==1)   //??
        begin // new
            pcout <= pcout;        //new
        end
  
        else 
            pcout <= pcout + 1;
    end // end always    
endmodule

    

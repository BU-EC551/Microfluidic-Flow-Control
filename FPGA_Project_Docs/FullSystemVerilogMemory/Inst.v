`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2018 07:40:57 PM
// Design Name: 
// Module Name: Inst
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


module Inst(clk, Address, ReadData1);

    input [7:0] Address;
    input clk;
    output reg [12:0] ReadData1;
    
    reg [12:0] memory_file [0:99];	// Memory list
    integer i;
    // Asyncronous read of memory.
    
    always @(*) 
    begin
    
        ReadData1 = memory_file[Address];
    end

initial begin    
i = 0;
                memory_file[i] = 13'b001_0001_00000_1; //Set Valve 1
                i=i+1;
                memory_file[i] = 13'b010_000011_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0001_00000_0; //UnSet Valve 1
                i=i+1;
                memory_file[i] = 13'b010_010000_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0011_00000_1; //Set Valve 3
                i=i+1;
                memory_file[i] = 13'b010_001000_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0011_00000_0; //UnSet Valve 3
                i=i+1;
                memory_file[i] = 13'b010_000100_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0000_00000_1; //Set Valve 0
                i=i+1;
                memory_file[i] = 13'b010_000001_010_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0000_00000_0; //UnSet Valve 0
                i=i+1;
                memory_file[i] = 13'b010_000100_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0010_00000_1; //Set Valve 2
                i=i+1;
                memory_file[i] = 13'b010_000001_010_0; //Delay
                i=i+1;
                memory_file[i] = 13'b001_0010_00000_0; //UnSet Valve 2
                i=i+1;
                memory_file[i] = 13'b010_000100_001_0; //Delay
                i=i+1;
                memory_file[i] = 13'b000_0000_00000_0; //Halt
end
endmodule

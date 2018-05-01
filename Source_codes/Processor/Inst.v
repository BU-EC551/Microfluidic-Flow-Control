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


module Inst(Address, ReadData1);
input [7:0] Address;   //8 bit address
output reg [20:0] ReadData1;  //To read 21 bit instruction

reg [20:0] memory_file [0:255];	// Entire list of memory

// Asyncronous read of memory
always @(Address, memory_file[Address])
begin
	ReadData1 = memory_file[Address];
end

integer i;

//Instructions are loaded in the instruction memory using an initial block.

initial
	begin
	
	    i = 1;
		memory_file[i] = 21'b001_0001_0000_0000_00000_1; //set valve 1 (Opcode 001)
		i=i+1;
		memory_file[i] = 21'b010_0001_00000_00010_001_0; //delay valve 1 by two miliseconds (Opcode 010)
		i=i+1;
		memory_file[i] = 21'b001_0001_0000_0000_00000_0; //Unset valve 1 (Opcode 001)
		i=i+1;
		memory_file[i] = 21'b000_0000_0000_0000_00000_0; //halt (Opcode 000)
    end

endmodule

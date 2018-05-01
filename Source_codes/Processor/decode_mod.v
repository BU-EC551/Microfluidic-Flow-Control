`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2018 07:57:34 PM
// Design Name: 
// Module Name: decode_mod
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


module decode_mod(Ins, valve, set_bit, debug, delay, delay_start, time_unit, pchalt);

input [20:0] Ins;

output reg [3:0] valve;
output reg set_bit;
output reg [9:0] delay;
output reg delay_start;
output reg [2:0] time_unit;
output reg pchalt;
output reg debug;

//Set all decode signals to zero initially

initial begin
valve <= 0;
set_bit <= 0;
delay <= 0;
delay_start<=0;
pchalt<=0;
//debug <= 0;
end

always@(Ins)
begin
case (Ins[20:18])

3'b000: begin  // HALT instruction
     valve <= Ins[17:14]; // Set to zero
     set_bit <= Ins[0]; // Set to zero
     delay <= 0; // Set to zero
     delay_start<=0; // Set to zero
     pchalt <= 1; // Halt the program counter
     end

3'b001: begin  // SET instruction
     valve <= Ins[17:14]; // 4 bit valve 
     set_bit <= Ins[0]; // Set bit = 1 sets the value , set bit = 0 unsets it
     delay <= 0; // Delay is irrevelant for set instruction
     delay_start <= 0; // No Delay 
     end
     
3'b010: begin // DELAY instruction
     delay <= Ins[13:4]; // 4 bit valve
     time_unit <= Ins[3:1]; // 3 bit time unit
     delay_start <= 1; // Set delay_start high to avoid program counter from incrementing
     valve <= Ins[17:14]; // 4 bit valve
     debug <= Ins[0]; // For manual delay
     end
default:  begin
     delay <= 0;
     time_unit <= 0;
     delay_start <= 0;
     set_bit <= 0;
     valve <= 0;

end 
endcase

end
endmodule

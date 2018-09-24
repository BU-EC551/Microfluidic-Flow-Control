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


module decode_mod(/*clk,*/ Ins, valve, set_bit, debug, delay, delay_start, time_unit, pchalt, enable);

    input [12:0] Ins;   //Instruction from Instruction memory
    //input clk;
    output reg [3:0] valve; 
    output reg set_bit, enable;
    output reg [5:0] delay;
    output reg delay_start;
    output reg [2:0] time_unit;
    output reg pchalt;
    output reg debug;
    reg donotcare;
    initial 
    begin
        valve = 4'bx;
        time_unit = 0;
        set_bit = 0;
        delay = 0;
        enable = 0;
        delay_start = 0;
        pchalt = 0;
        debug = 0; //When debug is set, delay is gven manually (in milliseconds)
    end
    
    always@(Ins)
    begin
        case (Ins[12:10])
        
            3'b000: //Opcode for Halt instruction 
                 begin
                 pchalt = 1;
                 delay = 0;
                 enable = 0;
                 delay_start=0;
                 valve = 4'bx;
                 set_bit = 1'bx;
                 time_unit = 3'bx;
                 debug = 1'bx;
                 end
            
            3'b001: //Opcode for Set/Unset instruction 
                 begin
                 valve = Ins[9:6];
                 set_bit = Ins[0];
                 enable = 1;
                 donotcare = Ins[5:1];
                 delay = 0;
                 pchalt = 0;
                 delay_start=0;
                 debug = 1'bx;
                 end
                 
            3'b010: //Opcode for Delay instruction
                 begin
                 delay = Ins[9:4];
                 time_unit = Ins[3:1];
                 delay_start = 1;
                 pchalt = 0;
                 enable = 0;
                 debug = Ins[0];
                 valve = 4'bx;
                 set_bit = 1'bx;
                 end
                 
            default:
                 begin
                 delay = 0;
                 time_unit = 1;
                 pchalt = 0;
                 delay_start = 0;
                 valve = 4'bx;
                 debug = 0;
                 end 
        endcase
    end
endmodule

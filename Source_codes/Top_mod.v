`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2018 08:10:51 PM
// Design Name: 
// Module Name: Top_mod
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


module Top_mod (clk, rst,PWM);
input clk;   //100MHz
input rst;   
output PWM;


wire [7:0] pcout;   //Program Counter Output
wire [20:0] Instruction;  // 21 bit instruction
wire [3:0] valve;  // Valve
wire set_bit;   // Goes high when valve is set 
wire [9:0] delay;   // 10 bit delay to be given to valve
wire [2:0] time_unit; // time_unit gives delay in miliseconds, seconds, minutes, hours or days
wire count_done;   // count_done goes high when required delay is achieved by the counter
wire delay_start;  // delay_start goes high when delay instruction is encountered
wire pchalt;    //  pchalt goes high when halt instruction is encountered
wire pcclock;   // pcclock is a 50Hz clock
wire debug;   // debug flag is set high when manual delay is to be given. 


dividerforpc div(.clk_100m(clk),  .rst(rst) , .clk_50Hz(pcclock));  //Clock divider used to get 50Hz clock from 100MHz board clock

pc pc1(.rst(rst), .clk(pcclock),.pchalt(pchalt), .delay(delay_start), .count_done(count_done), .pcout(pcout));  //Program Counter

Inst inst1(.Address(pcout), .ReadData1(Instruction));  //Instruction Memory

decode_mod dec1(.Ins(Instruction),.debug(debug), .valve(valve), .set_bit(set_bit), .delay(delay),.pchalt(pchalt), .delay_start(delay_start) , .time_unit(time_unit));  //Decode unit

counter cnt1(.manual_delay(0), .debug_flag(debug), .delay(delay), .delay_unit(time_unit), .count_done(count_done), .clk(clk), .rst(rst), .start(delay_start), .clk_50Hz(pcclock)); //Counter for delays

Servo_interface si(.set_bit(set_bit), .delay_start(delay_start), .count_done(count_done), .clk(clk), .PWM(PWM)); //PWM for motor control

endmodule

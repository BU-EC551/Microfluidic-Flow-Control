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


module Top_mod (clk, rst, count_done, PWM_0, PWM_1, PWM_2, PWM_3, delay_start, rst_flag, demux_out0, demux_out1, demux_out2, demux_out3); //Top level Module

    input clk;  //100MHz board clock
    input rst;  //reset
    
    output wire demux_out0, demux_out1, demux_out2, demux_out3;

    output wire count_done;  //Set when delay is achieved
    output wire PWM_0;
    output wire PWM_1;
    output wire PWM_2;
    output wire PWM_3;

    output wire delay_start; //High when delay instruction is encountered
    output wire rst_flag;    //High when delay is achieved (used to reset the delay counter)

    wire [3:0] valve;   //Valve number
    wire set_bit_reg;
    wire clk_1Hz;
    wire [7:0] pcout;   //Program counter
    wire [12:0] Instruction;        
    wire enable;
    wire [5:0] delay;   //Desired delay
    wire [2:0] time_unit;   //milliseconds, seconds, minutes, hours or days
    //wire delay_start;   //High when delay instruction is encountered
    wire pchalt;    //Halt the program counter
    wire debug; //Bit to indicate if manual delay is given

    dividerforpc d1(.clk_100mega(clk), .rst(rst) , .clk_1kHz(clk_1Hz));
    pc pc_instance(.rst(rst), .clk(clk), .pchalt(pchalt), .delay(delay_start), .count_done(count_done), .pcout(pcout)); //Program Counter
    Inst instmem_instance(.Address(pcout), .ReadData1(Instruction), .clk(clk));    //Instruction Memory
    decode_mod decode_instance(.Ins(Instruction), .enable(enable), .debug(debug), .valve(valve), .set_bit(set_bit_reg), .delay(delay), .pchalt(pchalt), .delay_start(delay_start), .time_unit(time_unit));   //Decode Module
    Demux demux_instance (.in(set_bit_reg), .enable(enable), .out0(demux_out0), .out1(demux_out1), .out2(demux_out2), .out3(demux_out3), .select(valve));
    counter cnt_instance(.delay(delay), .delay_unit(time_unit), .count_done(count_done), .delay_start(delay_start), .clk(clk_1Hz), .rst(rst), .rst_flag(rst_flag)); //Delay Counter
    Servo_interface servo_instance_0(.set_bit(demux_out0), /*.delay_start(delay_start), .count_done(count_done),*/ .clk(clk), .PWM(PWM_0));    //Servo Motor Interface
    Servo_interface servo_instance_1(.set_bit(demux_out1), /*.delay_start(delay_start), .count_done(count_done),*/ .clk(clk), .PWM(PWM_1));    //Servo Motor Interface
    Servo_interface servo_instance_2(.set_bit(demux_out2), /*.delay_start(delay_start), .count_done(count_done),*/ .clk(clk), .PWM(PWM_2));    //Servo Motor Interface
    Servo_interface servo_instance_3(.set_bit(demux_out3), /*.delay_start(delay_start), .count_done(count_done),*/ .clk(clk), .PWM(PWM_3));    //Servo Motor Interface
endmodule

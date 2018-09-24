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


module Top_mod (clk, rst, count_done, rx, PWM_0, PWM_1, PWM_2, PWM_3, delay_start, rst_flag, demux_out0, demux_out1, demux_out2/*, demux_out3*/, set_bit_reg); //Top level Module

    input clk;  //100MHz board clock
    input rst;  //reset
    input rx;
    output wire demux_out0, demux_out1, demux_out2;
    wire demux_out3;
    output wire count_done;  //Set when delay is achieved
    output wire PWM_0;
    output wire PWM_1;
    output wire PWM_2;
    output wire PWM_3;
    output wire delay_start; //High when delay instruction is encountered
    output wire rst_flag;    //High when delay is achieved (used to reset the delay counter)
   
    
    wire start;
    wire [3:0] valve;   //Valve number
    output wire set_bit_reg;
    wire clk_1Hz;
    wire [7:0] pcout;   //Program counter
    wire [12:0] ReadData;        
    wire enable;
    wire [5:0] delay;   //Desired delay
    wire [2:0] time_unit;   //milliseconds, seconds, minutes, hours or days
    wire pchalt;    //Halt the program counter
    wire debug; //Bit to indicate if manual delay is given
    wire rx_done_tick;
    wire ascii2bin_done;
    wire [1:0] ascii2bin;
    wire baud_tick;
    wire [7:0] i;
    wire [7:0] rx_data;
    reg  [8:0] r_reg;                       // baud rate generator register
    wire [8:0] r_next;
    wire [12:0] instruction;
    wire gated_clk;
    wire latch_start;
    
    
    and a1(gated_clk, clk, latch_start);
    dividerforpc d1(.clk_100mega(gated_clk), .rst(rst) , .clk_1kHz(clk_1Hz));
    Latch latch1(.clk(clk), .rst(rst), .D(start), .Q(latch_start));
    pc pc_instance(.rst(rst), .clk(gated_clk), .pchalt(pchalt), .delay(delay_start), .count_done(count_done), .pcout(pcout), .start(start)); //Program Counter
    UARTMemoryInterface interface1(.clk(clk), .rst(rst), .atob(ascii2bin), .instruction(instruction), .rx_done_tick(ascii2bin_done), .start(start), .i(i));
    Instruction_Memory memory(.instruction(instruction), .Address(pcout), .ReadData(ReadData), .start(latch_start), .i(i), .clk(clk));
    decode_mod decode_instance(.Ins(ReadData), .enable(enable), .debug(debug), .valve(valve), .set_bit(set_bit_reg), .delay(delay), .pchalt(pchalt), .delay_start(delay_start), .time_unit(time_unit));   //Decode Module
    Demux demux_instance(.in(set_bit_reg), .enable(enable), .out0(demux_out0), .out1(demux_out1), .out2(demux_out2), .out3(demux_out3), .select(valve));
    counter cnt_instance(.delay(delay), .delay_unit(time_unit), .count_done(count_done), .delay_start(delay_start), .clk(gated_clk), .rst(rst), .rst_flag(rst_flag)); //Delay Counter
    Servo_interface servo_instance_0(.set_bit(demux_out0), .clk(gated_clk), .PWM(PWM_0));    //Servo Motor Interface
    Servo_interface servo_instance_1(.set_bit(demux_out1), .clk(gated_clk), .PWM(PWM_1));    //Servo Motor Interface
    Servo_interface servo_instance_2(.set_bit(demux_out2), .clk(gated_clk), .PWM(PWM_2));    //Servo Motor Interface
    Servo_interface servo_instance_3(.set_bit(demux_out3), .clk(gated_clk), .PWM(PWM_3));    //Servo Motor Interface
    Receiver recs(.clk(clk), .reset(rst), .rx(rx), .baud_tick(baud_tick), .rx_done_tick(rx_done_tick), .rx_data(rx_data));
    asciitobin a2b(.rx_data(rx_data),.ascii_code(ascii2bin), .enable(rx_done_tick), .a2bdone(ascii2bin_done));
    	
    	always @(posedge clk, posedge rst)
            if(rst)
                r_reg <= 0;
            else
                r_reg <= r_next;
        
        // next state logic, mod 163 counter
        assign r_next = r_reg == 326 ? 0 : r_reg + 1;
        
        // tick high once every 163 clock cycles, for 19200 baud
        assign baud_tick = r_reg == 326 ? 1 : 0;
endmodule

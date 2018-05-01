`timescale 1ns / 1ps

//Reference:  https://blog.digilentinc.com/how-to-control-a-servo-with-fpga/

module Servo_interface (
    input set_bit,
    input delay_start,
    input count_done,
    input clk,
    output PWM
    );
    
    reg [15:0] sw;
    reg clr;
    wire [19:0] A_net;
    wire [19:0] value_net;
    wire [8:0] angle_net;
    
    always@(set_bit,delay_start,count_done)begin
    
    if(set_bit==0)
    begin
        sw<=1;
        clr<=0;
    end
    else if (set_bit ==1)
    begin
        sw<=128;
        clr<=0;
    end
    else if (delay_start==1/*&&count_done==0*/)
    begin
        clr<=1;
    end
    else if (/*delay_start==1&&*/count_done==1)
    begin
        clr<=0;
    end
    end
    // Convert the incoming switch value
    // to an angle.
    sw_to_angle converter(
        .sw(sw),
        .angle(angle_net)
        );
    
    // Convert the angle value to 
    // the constant value needed for the PWM.
    angle_decoder decode(
        .angle(angle_net),
        .value(value_net)
        );
    
    // Compare the count value from the
    // counter, with the constant value set by
    // the switches.
    comparator compare(
        .A(A_net),
        .B(value_net),
        .PWM(PWM)
        );
      
    // Counts up to a certain value and then resets.
    // This module creates the refresh rate of 20ms.   
   pwmcounter count(
        .clr(clr),
        .clk(clk),
        .count(A_net)
        );
        
endmodule

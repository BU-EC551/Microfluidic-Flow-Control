`timescale 1ns / 1ps

module comparator (
	input [19:0] A,
	input [19:0] B,
	output reg PWM
);

    // Run when A or B change
	always @ (A,B)
	begin
        // If A is less than B
        // output is 1.
        if (A < B)
        begin
            PWM <= 1'b1;
        end
        // If A is greater than B
        // output is 0.
        else 
        begin
            PWM <= 1'b0;
        end
	end
endmodule
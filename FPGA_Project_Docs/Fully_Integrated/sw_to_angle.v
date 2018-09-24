`timescale 1ns / 1ps

// Convert from switch value to angle
// Each switch provides a different angle in degrees, starting
// at 0, incrementing by 24 degrees each time. 
module sw_to_angle(
    input [15:0] sw,
    output reg [8:0] angle
    );
    
    // Run when the value of the switches
    // changes
    always @ (sw)
    begin
        case (sw)
        // Switch 0
        1:
        angle = 9'd0;
        // Switch 1
        2:
        angle = 9'd24;
        // Switch 2
        4:
        angle = 9'd48;
        // Switch 3
        8:
        angle = 9'd72;
        // Switch 4
        16:
        angle = 9'd96;
        // Switch 5
        32:
        angle = 9'd120;
        // Switch 6
        64:
        angle = 9'd144;
        // Switch 7
        128:
        angle = 9'd168;
        // Switch 8
        256:
        angle = 9'd192;
        // Switch 9
        512:
        angle = 9'd216;
        // Switch 10
        1024:
        angle = 9'd240;
        // Switch 11
        2048:
        angle = 9'd264;
        // Switch 12
        4096:
        angle = 9'd288;
        // Switch 13
        8192:
        angle = 9'd312;
        // Switch 14
        16384:
        angle = 9'd336;
        // Switch 15
        32768:
        angle = 9'd360;
        default:
        angle = 9'd0;
        endcase                 
    end
endmodule

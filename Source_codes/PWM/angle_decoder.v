`timescale 1ns / 1ps

// Reference:  https://blog.digilentinc.com/how-to-control-a-servo-with-fpga/

module angle_decoder(
    input [8:0] angle,
    output reg [19:0] value
    );
    
    // Run when angle changes
    always @ (angle)
    begin
        // The angle gets converted to the 
        // constant value.  
        value = (10'd944)*(angle)+ 16'd60000;
    end
endmodule

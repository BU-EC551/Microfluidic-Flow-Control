`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2018 07:00:46 PM
// Design Name: 
// Module Name: asciitobin
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


module asciitobin(

		input wire [7:0] rx_data,
		input enable,
		output reg [1:0] ascii_code,
		output reg a2bdone
	);
initial begin
a2bdone = 0;
//ascii_code = 0;
end	
	
always @(*) begin
        if (enable)
		begin
		case(rx_data)

			8'h30: begin ascii_code = 2'b00; a2bdone = 1; end  // 0 
			8'h31: begin ascii_code = 2'b01; a2bdone = 1; end  // 1
			8'h6D: begin ascii_code = 2'b10; a2bdone = 1; end  //m
			default : begin ascii_code = 2'b11; a2bdone = 1; end
		endcase
		end
		else begin
		  a2bdone = 0;
		  ascii_code = 2'b00;
		end
		end
endmodule

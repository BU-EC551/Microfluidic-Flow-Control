`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2018 04:44:34 PM
// Design Name: 
// Module Name: demux
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

    
    module Demux(in, out0, out1, out2, out3, select, enable);
  
        input in;
        input enable;
        input [3:0] select;
            
        output out0, out1, out2, out3;
        reg out0, out1, out2, out3;

            
        always @(*)//select or in 
        
        begin
        if (enable) begin
            case(select)
            
                4'b0000:  begin out0 = in; end
                4'b0001:  begin out1 = in; end
                4'b0010:  begin out2 = in; end 
                4'b0011:  begin out3 = in; end
                //default: begin out0 = in; end
            endcase              
        end
        end

    endmodule
    
     

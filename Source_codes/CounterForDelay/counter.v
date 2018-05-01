`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 04:57:23 PM
// Design Name: 
// Module Name: counter
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


module counter(manual_delay, debug_flag, delay, delay_unit, count_done, clk, rst,start, clk_50Hz);

input [9:0] manual_delay;
input [9:0] delay;
input [2:0] delay_unit;
input clk_50Hz;
input clk, rst, start;
input debug_flag;

output reg count_done;

reg [9:0] day_count;
reg [4:0] hour_count;
reg [5:0] min_count;
reg [5:0] sec_count;
reg [9:0] msec_count;
reg [9:0] debug_count;
reg sec_flag, min_flag, hour_flag, day_flag, rst_flag, count_flag;

wire clk_1k;

frequency_gen f1(.clk_100m(clk), .rst(rst), .clk_1k(clk_1k));

initial 
begin
day_count <= 0;
hour_count <= 0;
min_count <= 0;
sec_count <= 0;
msec_count <= 0;
sec_flag <= 0;
min_flag <= 0;
hour_flag <= 0;
day_flag <= 0;
rst_flag <= 0;
count_flag <= 0;
debug_count <= 0;
count_done <= 0;
end

always@(posedge clk_50Hz) // Trigger the counter with the positive edge of 50Hz clock                  
begin

if (rst || rst_flag) begin // Check for reset and reset flag
    day_count <= 0;
    hour_count <= 0;
    min_count <= 0;
    sec_count <= 0;
    msec_count <= 0;
    sec_flag <= 0;
    min_flag <= 0;
    hour_flag <= 0;
    day_flag <= 0;
    count_flag <= 0;
    debug_count <= 0;
    count_done <= 0;
end

else 
    begin
   
   // milisecond counter
   
    if (msec_count < 10'b00001_10010) begin //50 Hz clock = 20 ms period
                                           //So max count for milisecond counter
                                           //is 20ms * 50 = 1000ms
        msec_count <= msec_count + 1;  //increment counter
        sec_flag <= 0;
        end
    else
    begin
        sec_flag <= 1;   
    end
   
   // second counter
   
   if(sec_flag == 1) begin
        if ((sec_count < 6'b111_100)&&(sec_flag == 1)) begin //max count = 60
             sec_count <= sec_count + 1;
             msec_count <= 0;
             min_flag <= 0;
             sec_flag<=0;
         end
        else
        begin
            min_flag <= 1;
        end
     end
     
     //minute counter
     
     if(min_flag == 1) begin
             if ((min_count < 6'b111_100)&&(min_flag == 1)) begin //max count = 60
                 min_count <= min_count + 1;
                 sec_count <= 0;
                 hour_flag <= 0;
                 min_flag <= 0;
                 msec_count <= 0; 
             end
             else
             begin
                 hour_flag <= 1;
             end
      end
      
      //hour counter
      
      if(hour_flag == 1) begin
              if ((hour_count < 5'b11000)&&(hour_flag == 1)) begin //max count = 24
                  hour_count <= hour_count + 1;
                  min_count <= 0;
                  day_flag <= 0;
                  hour_flag <= 0;
                  msec_count <= 0; 
                  sec_count <= 0; 
              end
              else
              begin
                  day_flag <= 1;
              end
      end
      
      //day counter
      
      if(day_flag == 1) begin
              if ((day_count < 10'b11111_01000)&&(day_flag == 1)) begin //max days = 1000
                  day_count <= day_count + 1;
                  hour_count <= 0;
                  day_flag <= 0;
              end
              else
              begin
                  day_count <= 0;
              end
       end
end//else
end//always

// Case statement according to time unit

always@(posedge clk_50Hz)
begin
    case(delay_unit)
    
    3'b001: //Time unit is miliseconds
    begin
    if(msec_count == delay) begin
        rst_flag <= 1;
        count_flag <= 1;    // If count is reached, set count_flag and reset
    end
    end
    
    3'b010: //Time unit is seconds 
    begin
    if(sec_count == delay) begin
        rst_flag <= 1;
        count_flag <= 1;   // If count is reached, set count_flag and reset
    end
    end
    
    3'b011: //Time unit is minutes
    begin
    if(min_count == delay) begin
        rst_flag <= 1;
        count_flag <= 1;  // If count is reached, set count_flag and reset
    end
    end
    
    3'b100: //Time unit is hours
    begin
    if(hour_count == delay) begin   
        rst_flag <= 1;
        count_flag <= 1; // If count is reached, set count_flag and reset
    end
    end
    
    3'b101: ////Time unit is days
    begin
    if(day_count == delay) begin
        rst_flag <= 1;
        count_flag <= 1; // If count is reached, set count_flag and reset
    end
    end
    default: begin
    msec_count <= 0;
    sec_count <= 0;
    min_count <= 0;
    hour_count <= 0;
    day_count <= 0;
    end
    endcase
    
if ((debug_flag == 0) && (count_flag == 1)) // If no manual delay is given and count flag is high
                                            // counting is done. Set count_done to 1
    count_done <= 1;
    
else if ((debug_flag == 1) && (count_flag == 1)) //Manual delay is in miliseconds only
                                                 //If counting is done and debug_flag is set,
                                                 //Count up to the manual delay
                                                 //When manual delay is achieved
                                                 //set count_done to 1.
    begin
    debug_count <= 0;
    if(debug_count < manual_delay) begin
        debug_count <= debug_count + 1;
        count_flag <=1;
        end
    else
        begin
        debug_count <= 0;
        count_done <= 1;
        end 
    end
end // always 2
endmodule

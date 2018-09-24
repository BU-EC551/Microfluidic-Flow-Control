module counter(delay, delay_unit, count_done, clk, rst, delay_start, rst_flag);
input [5:0] delay;
input [2:0] delay_unit;
wire clk_1Hz;
input clk, rst, delay_start;
output reg count_done;
reg [44:0] count;
output reg rst_flag;
reg [9:0] ms2sec;
reg [15:0] ms2min;
reg [21:0] ms2hrs;
reg [26:0] sec2days;
//dividerforpc d1(.clk_100mega(clk), .rst(rst) , .clk_1kHz(clk_1Hz));

initial
begin

    count = 0;
    count_done = 0;
    rst_flag = 0;
    ms2sec = 1000;
    ms2min = 60000;
    ms2hrs = 3600000;
    sec2days = 86400000;
    
end
    
always@(posedge clk)    
begin    
    if (delay_start == 1)
    rst_flag <= 0;
//    else 
//    rst_flag <= 1;
    if(rst | rst_flag)
    begin
        count <= 0;
        count_done <= 0;
      //  rst_flag <= 0;
    end

    else begin    
    case(delay_unit)
    3'b000:
    begin
    if(count < delay) 
        count <= count + 1;
    else begin
        count_done <= 1;
        rst_flag <= 1;
     //   first_delay <= 1;
    end //else   
    end //end case 1
    
    3'b001:
    begin
    if(count < (ms2sec * delay)) 
        count <= count + 1;
    else begin
        count_done <= 1;
        rst_flag <= 1;
    end //else
    end //end case 2
    
    3'b010:
    begin
    if(count < (ms2min * delay)) 
        count <= count + 1;
    else begin
        count_done <= 1;
        rst_flag <= 1;
    end   
    end
    
    3'b011:
    begin
    if(count < (ms2hrs * delay)) 
        count <= count + 1;
    else begin
        count_done <= 1;
        rst_flag <= 1;
    end   
    end

    3'b100:
    begin
    if(count < (sec2days * delay)) 
        count <= count + 1;
    else begin
        count_done <= 1;
        rst_flag <= 1;
    end   
    end
endcase
end //else
//end // end if delay_start
end //always
endmodule
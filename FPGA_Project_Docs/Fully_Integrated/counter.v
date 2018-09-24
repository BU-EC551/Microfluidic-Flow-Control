module counter(delay, delay_unit, count_done, clk, rst, delay_start, rst_flag);
input [5:0] delay;
input [2:0] delay_unit;
input clk, rst, delay_start;
output reg count_done;

output reg rst_flag;
//input rst_flag;

reg [2:0] state;
reg [9:0] ms_counter;
reg [5:0] sec_counter;
reg [5:0] mins_counter;
reg [4:0] hrs_counter;
reg [5:0] days_counter;

reg [16:0] counter;
reg [16:0] MHz2ms;
reg [9:0] ms2sec;
reg [5:0] sec2mins;
reg [5:0] mins2hrs;
reg [4:0] hrs2day;

//dividerforpc d1(.clk_100mega(clk), .rst(rst) , .clk_1kHz(clk_1Hz));

initial
begin
    counter <= 0;
    ms_counter <= 0;
    sec_counter <= 0;
    mins_counter <= 0;
    hrs_counter <= 0;
    days_counter <= 0;
    MHz2ms <= 100000;
    ms2sec <= 1000;
    sec2mins <= 60;
    mins2hrs <= 60;
    hrs2day <= 24;
    count_done <= 0;
    state <= 3'b001;

end
 

always @(posedge clk) begin

    if (delay_start == 1) begin
        case (state)          
         
        3'b001 : begin
                    if (delay_unit == 3'b000)
                        state <= 3'b010;//ms
                    else if (delay_unit == 3'b001)
                        state <= 3'b011;//s
                    else if (delay_unit == 3'b010)
                        state <= 3'b100;//mins
                    else if (delay_unit == 3'b011)
                        state <= 3'b101;//hrs
                    else if (delay_unit == 3'b100)
                        state <= 3'b110;//days
                    else begin
                        state <= 3'b001;
                    end
                 end
        
        3'b010 : begin
                    counter <= counter + 1;
                    if(counter == MHz2ms-1) begin
                        counter <= 0;
                        ms_counter <= ms_counter + 1;
                        if(ms_counter == delay-1) begin
                            count_done <= 1;
                            counter <= 0;
                            ms_counter <= 0;
                            state <= 3'b001; 
                        end
                        else begin
                            state <= 3'b010;
                        end
                    end
                    else begin
                        state <= 3'b010;    
                    end //else   
                 end

        3'b011 : begin
                    counter <= counter + 1;
                    if(counter == MHz2ms-1) begin
                        counter <= 0;
                        ms_counter <= ms_counter + 1;
                        if(ms_counter == ms2sec-1) begin
                            ms_counter <= 0;
                            sec_counter <= sec_counter + 1;
                                if(sec_counter == delay-1) begin
                                    count_done <= 1;
                                    sec_counter <= 0;
                                    //ms_counter <= 0;
                                    state <= 3'b001;
                                end
                                else begin
                                    state <= 3'b011;
                                end
                        end//second if
                        else begin
                            state <= 3'b011;
                        end
                    end//first if
                    else begin
                        state <= 3'b011;    
                    end
                 end

        3'b100 : begin
                    counter <= counter + 1;
                    if(counter == MHz2ms-1) begin
                        counter <= 0;
                        ms_counter <= ms_counter + 1;
                        if(ms_counter == ms2sec-1) begin
                            ms_counter  <= 0;
                            sec_counter <= sec_counter + 1;
                            if(sec_counter == sec2mins-1) begin
                                sec_counter <= 0;
                                mins_counter <= mins_counter + 1;
                                if(mins_counter == delay-1) begin
                                    count_done <= 1;
                                    ms_counter <= 0;
                                    sec_counter <= 0;
                                    mins_counter <= 0;
                                    state <= 3'b001;
                                end
                                else begin
                                    state <= 3'b100;
                                end
                            end//third if
                            else begin
                                state <= 3'b100;
                            end    
                        end //second if
                        else begin
                        state <= 3'b100;
                        end
                    end//first if
                    else begin
                        state <= 3'b100;
                    end
                 end

        3'b101 : begin
                    counter <= counter + 1;
                    if(counter == MHz2ms-1) begin
                        counter <= 0;
                        ms_counter <= ms_counter + 1;
                        if(ms_counter == ms2sec-1) begin
                            ms_counter <= ms_counter + 1;
                            sec_counter <= sec_counter + 1;
                            if(sec_counter == sec2mins-1) begin
                                sec_counter <= 0;
                                mins_counter <= mins_counter + 1;
                                if(mins_counter == mins2hrs-1) begin
                                    mins_counter <= 0;
                                    hrs_counter <= hrs_counter + 1;
                                    if(hrs_counter == delay-1) begin
                                        count_done <= 1;
                                        ms_counter <= 0;
                                        sec_counter <= 0;
                                        mins_counter <= 0;
                                        hrs_counter <= 0;
                                        state <= 3'b001;
                                    end
                                    else begin
                                        state <= 3'b101;
                                    end
                                end//fourth if
                                else begin
                                    state <= 3'b101;
                                end    
                            end //third if
                            else begin
                                state <= 3'b101;
                            end
                        end//second if
                        else begin
                            state <= 3'b101;
                        end  
                    end//first if         
                    else begin
                        state <= 3'b101;
                    end      
                 end
                 

        3'b110 : begin
                    counter <= counter + 1;
                    if(counter == MHz2ms-1) begin
                        counter <= 0;
                        ms_counter <= ms_counter + 1;
                        if(ms_counter == ms2sec-1) begin
                            ms_counter <= 0;
                            sec_counter <= sec_counter + 1;
                            if(sec_counter == sec2mins-1) begin
                                sec_counter <= 0;
                                mins_counter <= mins_counter + 1;
                                if(mins_counter == mins2hrs-1) begin
                                    mins_counter <= 0;
                                    hrs_counter <= hrs_counter + 1;
                                    if(hrs_counter == hrs2day-1) begin
                                        hrs_counter <= 0;
                                        days_counter <= days_counter + 1;
                                        if(days_counter == delay-1) begin
                                            count_done <= 1;
                                            ms_counter <= 0;
                                            sec_counter <= 0;
                                            mins_counter <= 0;
                                            hrs_counter <= 0;
                                            days_counter <= 0;
                                            state <= 3'b001;
                                        end
                                        else begin
                                            state <= 3'b110;
                                        end
                                    end//fifth if    
                                    else begin
                                        state <= 3'b110;
                                    end
                                end//fourth if    
                                else begin
                                    state <= 3'b110;
                                end
                            end //third if    
                            else begin
                                state <= 3'b110;
                            end   
                        end//second if
                        else begin
                            state <= 3'b110;
                        end
                    end //first if
                    else begin
                        state <= 3'b110;
                    end
                 end
    endcase
end
        else if(delay_start == 0) begin
            counter <= 0;
            ms_counter <= 0;
            sec_counter <= 0;
            mins_counter <= 0;
            hrs_counter <= 0;
            days_counter <= 0;
            count_done <= 0;
       end
end //always
endmodule
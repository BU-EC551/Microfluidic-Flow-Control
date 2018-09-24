`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2018 05:34:01 PM
// Design Name: 
// Module Name: Loopback_Top
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


module Loopback_Top(clk, reset, rx, instruction);
input clk, reset;
input rx;
output [12:0] instruction;

wire a2bdone;
wire atob;
reg  [8:0] r_reg;                       // baud rate generator register
wire [8:0] r_next;
wire [7:0] rx_data;
wire rx_done_tick;
wire baud_tick;

Receiver recs(
.clk(clk), 
.reset(),
.rx(rx), 
.baud_tick(baud_tick),   // input rx line, and 16*baudrate tick 
.rx_done_tick(rx_done_tick),    // receiver done tick
.rx_data(rx_data)   // received data
);

asciitobin a2b(.rx_data(rx_data),.ascii_code(atob), .enable(rx_done_tick), .a2bdone(a2bdone));

memory mem(.atob(atob), .instruction(instruction), .clk(clk), .rx_done_tick(a2bdone), .rst(reset));

//Transmitter transmitter
//	(
//		.clk(clk), 
//		.reset(),
//		.tx_start(rx_done_tick),
//		.baud_tick(baud_tick),   // input to start transmitter, and 16*baudrate tick
//		.tx_data(rx_data),         // data to transmit
//		.tx_done_tick(),          // transmit done tick
//		.tx(tx)                    // output tx line
//	);
	
	always @(posedge clk, posedge reset)
            if(reset)
                r_reg <= 0;
            else
                r_reg <= r_next;
        
        // next state logic, mod 163 counter
        assign r_next = r_reg == 326 ? 0 : r_reg + 1;
        
        // tick high once every 163 clock cycles, for 19200 baud
        assign baud_tick = r_reg == 326 ? 1 : 0;
endmodule

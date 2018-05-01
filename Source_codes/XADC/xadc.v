`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 11:17:48 PM
// Design Name: 
// Module Name: Top_Module
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


// Reference: //https://www.xilinx.com/support/documentation/ip_documentation/xa//dc_wiz/v3_0/pg091-xadc-wiz.pdf


module Top_Module(
input DCLK, // Clock input for DRP
 input RESET,
 input [3:0] VAUXP, VAUXN, // Auxiliary analog channel inputs
 input VP, VN,

 output reg [15:0] MEASURED_TEMP,
 output reg [15:0] MEASURED_AUX0, MEASURED_AUX1,
 output reg [15:0] MEASURED_AUX2, MEASURED_AUX3,
 output wire [4:0] CHANNEL,
 output wire OT,
 output wire XADC_EOC,
 output wire XADC_EOS   
    );
//xadc_wiz_0 XADC
//              (
//              .daddr_in(daddr),            // Address bus for the dynamic reconfiguration port
//              .dclk_in(DCLK),             // Clock input for the dynamic reconfiguration port
//              .den_in(den_reg[0]),              // Enable Signal for the dynamic reconfiguration port
//              .di_in(di_drp),               // Input data bus for the dynamic reconfiguration port
//              .dwe_in(dwe_reg[0]),              // Write Enable for the dynamic reconfiguration port
//              .reset_in(RESET),            // Reset signal for the System Monitor control logic
//              .vauxp0(vauxp_active[0]),              // Auxiliary channel 0
//              .vauxn0(vauxn_active[0]),
//              .vauxp1(vauxp_active[1]),              // Auxiliary channel 1
//              .vauxn1(vauxn_active[1]),
//              .vauxp2(vauxp_active[2]),              // Auxiliary channel 2
//              .vauxn2(vauxn_active[2]),
//              .vauxp3(vauxp_active[3]),              // Auxiliary channel 3
//              .vauxn3(vauxn_active[3]),
//              .busy_out(busy),            // ADC Busy signal
//              .channel_out(CHANNEL),         // Channel Selection Outputs
//              .do_out(do_drp),              // Output data bus for dynamic reconfiguration port
//              .drdy_out(drdy),            // Data ready signal for the dynamic reconfiguration port
//              .eoc_out(eoc),             // End of Conversion Signal
//              .eos_out(eos),             // End of Sequence Signal
//              .alarm_out(),           // OR'ed output of all the Alarms    
//              .vp_in(VP),               // Dedicated Analog Input Pair
//              .vn_in(VN));
    
wire busy;
wire [5:0] channel;
wire drdy;    
reg [6:0] daddr;
reg [15:0] di_drp;
wire [15:0] do_drp;
wire [15:0] vauxp_active;
wire [15:0] vauxn_active;
reg [1:0] den_reg;
reg [1:0] dwe_reg;
reg [7:0] state = init_read;

parameter init_read = 8'h00,
          read_waitdrdy = 8'h01,
          write_waitdrdy = 8'h03,
          read_reg00 = 8'h04,
          reg00_waitdrdy = 8'h05,
          //read_reg01 = 8'h06,
          //reg01_waitdrdy = 8'h07,
          //read_reg02 = 8'h08,
          //reg02_waitdrdy = 8'h09,
          //read_reg06 = 8'h0a,
          //reg06_waitdrdy = 8'h0b,
          read_reg10 = 8'h0c,
          reg10_waitdrdy = 8'h0d,
          read_reg11 = 8'h0e,
          reg11_waitdrdy = 8'h0f,
          read_reg12 = 8'h10,
          reg12_waitdrdy = 8'h11,
          read_reg13 = 8'h12,
          reg13_waitdrdy = 8'h13;

always @(posedge DCLK)
 if (RESET) begin
    state <= init_read;
    den_reg <= 2'h0;
    dwe_reg <= 2'h0;
    di_drp <= 16'h0000;
 end
 else
 case (state)
    init_read : begin
                daddr = 7'h40;
                den_reg = 2'h2; // performing read
                if (busy == 0 ) state <= read_waitdrdy;
                end
    read_waitdrdy :
              if (drdy ==1) begin
                di_drp = do_drp & 16'h03_FF; //Clearing AVG bits for Configreg0
                daddr = 7'h40;
                den_reg = 2'h2;
                dwe_reg = 2'h2; // performing write
                state = write_waitdrdy;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
    write_waitdrdy :
              if (drdy ==1) begin          
                state = read_reg00;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
    read_reg00 : begin
                daddr = 7'h00;
                den_reg = 2'h2; // performing read
                if (eos == 1) state <=reg00_waitdrdy;
                end
    reg00_waitdrdy :
              if (drdy ==1) begin
                MEASURED_TEMP = do_drp;
                state <=read_reg10;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end          
    read_reg10 : begin
                daddr = 7'h10;
                den_reg = 2'h2; // performing read
                state <= reg10_waitdrdy;
              end
    reg10_waitdrdy :
              if (drdy ==1) begin
                MEASURED_AUX0 = do_drp;
                state <= read_reg11;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
    read_reg11 : begin
                daddr = 7'h11;
                den_reg = 2'h2; // performing read
                state <= reg11_waitdrdy;
              end
    reg11_waitdrdy :
              if (drdy ==1) begin
                MEASURED_AUX1 = do_drp;
                state <= read_reg12;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
    read_reg12 : begin
                daddr = 7'h12;
                den_reg = 2'h2; // performing read
                state <= reg12_waitdrdy;
              end
    reg12_waitdrdy :
              if (drdy ==1) begin
                MEASURED_AUX2= do_drp;
                state <= read_reg13;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
     read_reg13 : begin
                daddr = 7'h13;
                den_reg = 2'h2; // performing read
                state <= reg13_waitdrdy;
              end
     reg13_waitdrdy :
              if (drdy ==1) begin
                MEASURED_AUX3= do_drp;
                state <=read_reg00;
                daddr = 7'h00;
              end
              else begin
                den_reg = { 1'b0, den_reg[1] } ;
                dwe_reg = { 1'b0, dwe_reg[1] } ;
                state = state;
              end
 endcase                        


XADC #(
        .INIT_40(16'h0000), // config reg 0
        .INIT_41(16'h2101), // config reg 1
        .INIT_42(16'h0400), // config reg 2
        .INIT_48(16'h0100), // Sequencer channel selection
        .INIT_49(16'h000F), // Sequencer channel selection
        .INIT_4A(16'h0100), // Sequencer Average selection
        .INIT_4B(16'h000F), // Sequencer Average selection
        .INIT_4C(16'h0000), // Sequencer Bipolar selection
        .INIT_4D(16'h0000), // Sequencer Bipolar selection
        .INIT_4E(16'h0000), // Sequencer Acq time selection
        .INIT_4F(16'h0000), // Sequencer Acq time selection
        .INIT_50(16'hB5ED), // Temp alarm trigger
        .INIT_51(16'h57E4), // Vccint upper alarm limit
        .INIT_52(16'hA147), // Vccaux upper alarm limit
        .INIT_53(16'hCA33),  // Temp alarm OT upper
        .INIT_54(16'hA93A), // Temp alarm reset
        .INIT_55(16'h52C6), // Vccint lower alarm limit
        .INIT_56(16'h9555), // Vccaux lower alarm limit
        .INIT_57(16'hAE4E),  // Temp alarm OT reset
        .INIT_58(16'h5999), // VCCBRAM upper alarm limit
        .INIT_5C(16'h5111),  //  VCCBRAM lower alarm limit
        .INIT_59(16'h5555), // VCCPINT upper alarm limit
        .INIT_5D(16'h5111),  //  VCCPINT lower alarm limit
        .INIT_5A(16'h9999), // VCCPAUX upper alarm limit
        .INIT_5E(16'h91EB),  //  VCCPAUX lower alarm limit
        .INIT_5B(16'h6AAA), // VCCDdro upper alarm limit
        .INIT_5F(16'h6666),  //  VCCDdro lower alarm limit
        .SIM_DEVICE("ZYNQ"),
        .SIM_MONITOR_FILE("d:/Vivado/EC551Project_XADC_External/EC551Project_XADC_External.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0/simulation/functional/design.txt")
)

inst (
        .CONVST(1'b0),
        .CONVSTCLK(1'b0),
        .DADDR(daddr),
        .DCLK(DCLK),
        .DEN(den_reg[0]),
        .DI(di_drp),
        .DWE(dwe_reg[0]),
        .RESET(RESET),
        .VAUXN(vauxn_active),
        .VAUXP(vauxp_active),
        .ALM(),
        .BUSY(busy),
        .CHANNEL(CHANNEL),
        .DO(do_drp),
        .DRDY(drdy),
        .EOC(eoc),
        .EOS(eos),
        .JTAGBUSY(),
        .JTAGLOCKED(),
        .JTAGMODIFIED(),
        .OT(),
        .MUXADDR(),
        .VP(VP),
        .VN(VN)
          );
          
assign vauxp_active = {12'h000, VAUXP[3:0]};
assign vauxn_active = {12'h000, VAUXN[3:0]};
assign XADC_EOC = eoc;
assign XADC_EOS = eos;
          
          
          
          
endmodule
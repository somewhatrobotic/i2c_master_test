`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2018 07:36:28 PM
// Design Name: 
// Module Name: master_tb
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


module master_tb;

    //Inputs
    reg clk;
    reg reset_n;
    reg ena;
    reg[6:0] addr;
    reg[7:0] data_wr;
    reg[7:0] data_rd;
    reg ack_error;
    reg busy;
    //Outputs
    wire SDA;
    wire SCL;

    Main uut(
        .clk(clk),
        .reset_n(reset_n),
        .ena(ena),
        .addr(addr),
        .data_wr(data_wr),
        .data_rd(data_rd),
        .ack_error(ack_error),
        .busy(busy),
        .SDA(SDA),
        .SCL(SCL)
    );
    
   parameter PERIOD = 5;
 
    always begin
       clk = 1'b0;
       #(PERIOD/2) clk = 1'b1;
       #(PERIOD/2);
    end
    
    initial begin
    addr = 6'h27;
    data_wr = 8'h4A;
    data_rd = 0;
    ack_error = 0;
    busy = 0;
    ena = 1;
    #5
    reset_n = 1;
    #5; reset_n = 0;
    #150;
    $finish;
    end
endmodule

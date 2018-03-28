`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 06:17:01 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input wire clk,
    input wire reset_n,
    input wire ena,
    input wire[6:0] addr,
    input wire[7:0] data_wr, data_rd,
    input wire ack_error,
    input wire busy,
    output reg SCL, SDA
);

//Request = ena, addr, data_wr, data_rd, ack_error, busy
//Slave Address
reg [SIZE-2:0] SLAVE_ADR = 6'h27;
//-------------State Constants-----------------------
parameter SIZE = 7;
parameter RDY = 3'b000, START = 3'b001, ADR = 3'b010 ;
parameter ACK = 3'b011, WRITE = 3'b100, READ = 3'b101;
parameter STOP = 3'b110;
//-------------Internal Variables-----------------------
reg [SIZE-1:0]  state       ;//Seq part of FSM
reg [SIZE-1:0]  next_state  ;//Combo part of FSM
reg [2:0]  bit_cnt     ;//Counter for sending info
reg RWACK;
//----------Code starts here----------------------------
always@(posedge clk)
begin
    if((state == RDY)||(state == START)||(state == STOP))
        SCL <= 1'b1;
    else
        SCL <= ~SCL;
end
//Sequential Logic
always@(posedge clk)
begin
    if(reset_n == 1'b1)
    begin
        next_state <= RDY;
        SDA <= 1'b1;
        SCL <= 1'b1;
    end else begin
    state <= next_state;
    end
       case(state)
        RDY     : begin 
                    if(ena == 1'b1)
                        begin
                        next_state = START;
                        SDA <= 1'b1;
                        end    
                    else 
                        next_state = RDY; 
                  end
        START   : begin 
                    SDA <= 1'b0; 
                    next_state <= ADR;
                    bit_cnt <= 3'b110;
                  end
        ADR     : begin //Sequence for sending slave address
                     SDA <= addr[bit_cnt];
                     if(bit_cnt == 0) next_state <= ACK;
                     else bit_cnt <= bit_cnt - 1;
                  end     
        ACK     : begin
                    next_state <= WRITE;
                    bit_cnt <= 3'b111;
                    if(RWACK == 1'b1)
                        next_state <= STOP;
                  end
        WRITE   : begin //Sequence for sending data
                       SDA <= data_wr[bit_cnt];
                       if(bit_cnt == 0)
                       begin
                            next_state <= ACK;
                            RWACK <= 1;
                       end
                       else bit_cnt <= bit_cnt - 1;
                   end
        READ    : begin //Sequence for sending 
                 end
        STOP    : begin  
                    SDA = 1'b1;
                    next_state <= RDY;
                  end
       endcase 
end
endmodule

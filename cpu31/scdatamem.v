`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 01:16:57
// Design Name: 
// Module Name: scdatamem
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


module scdatamem(clk,addr,datain,we,dataout);
    input clk;             //时钟信号
    input [4:0] addr;     //数据存储器地址
    input [31:0] datain;   //数据存储器输入
    input we;              //数据存储器写使能，1为写，0为读
    output [31:0] dataout; //数据存储局输出
    
    reg [31:0] ram [0:31];
    
    assign dataout = ram[addr];
    
    always @(negedge clk)
    begin
        if(we)
            ram[addr] <= datain;
    end

endmodule

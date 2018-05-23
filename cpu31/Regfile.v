`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/24 10:16:36
// Design Name: 
// Module Name: Regfile
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


module Regfile(rna,rnb,d,wn,we,clk,clrn,jal,qa,qb);
    input clk;            //时钟信号
    input clrn;           //清零信号
    input we;             //写使能信号
    input [4:0] rna, rnb; //读端口a,b的寄存器地址
    input [4:0] wn;       //写端口的寄存器地址
    input [31:0] d;       //写端口的32位数据
    input jal;
    output [31:0] qa,qb;  //读端口a,b的32为数据
    
    reg [31:0] array_reg [31:0]; //32 * 32-bit regs
    integer i;
    
    //初始寄存器堆
    initial
    begin
        for(i = 0; i < 32; i = i + 1)
            array_reg[i] <= 0;
    end 

    //读寄存器
    assign qa = array_reg[rna];
    assign qb = array_reg[rnb];
    
    //写寄存器
    always @(posedge clk or posedge clrn)
    begin
        if(clrn == 1)
        begin
            for(i = 0; i < 32; i = i + 1)
                array_reg[i] <= 0;
        end  
        else if((wn != 0) && we)
        begin
            if(jal)
                array_reg[wn] <= d + 32'h00400000;
            else
                array_reg[wn] <= d;
        end            
    end
endmodule

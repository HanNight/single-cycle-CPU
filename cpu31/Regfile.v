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
    input clk;            //ʱ���ź�
    input clrn;           //�����ź�
    input we;             //дʹ���ź�
    input [4:0] rna, rnb; //���˿�a,b�ļĴ�����ַ
    input [4:0] wn;       //д�˿ڵļĴ�����ַ
    input [31:0] d;       //д�˿ڵ�32λ����
    input jal;
    output [31:0] qa,qb;  //���˿�a,b��32Ϊ����
    
    reg [31:0] array_reg [31:0]; //32 * 32-bit regs
    integer i;
    
    //��ʼ�Ĵ�����
    initial
    begin
        for(i = 0; i < 32; i = i + 1)
            array_reg[i] <= 0;
    end 

    //���Ĵ���
    assign qa = array_reg[rna];
    assign qb = array_reg[rnb];
    
    //д�Ĵ���
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

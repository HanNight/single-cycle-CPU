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
    input clk;             //ʱ���ź�
    input [4:0] addr;     //���ݴ洢����ַ
    input [31:0] datain;   //���ݴ洢������
    input we;              //���ݴ洢��дʹ�ܣ�1Ϊд��0Ϊ��
    output [31:0] dataout; //���ݴ洢�����
    
    reg [31:0] ram [0:31];
    
    assign dataout = ram[addr];
    
    always @(negedge clk)
    begin
        if(we)
            ram[addr] <= datain;
    end

endmodule

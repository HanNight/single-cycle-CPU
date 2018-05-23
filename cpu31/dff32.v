`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 22:11:17
// Design Name: 
// Module Name: dff32
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

//带异步清零的32位D触发器
module dff32(d,clk,clrn,q);
    input clk,clrn;
    input [31:0] d;
    output [31:0] q;
    reg [31:0] q;
    always @(posedge clk or posedge clrn)
    begin
        if(clrn == 1)
            q <= 0;
        else
            q <= d;
    end
endmodule

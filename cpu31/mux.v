`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 15:28:54
// Design Name: 
// Module Name: mux
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


module mux2x5(x0,x1,s,y);
    input [4:0] x0,x1;
    input s;
    output [4:0] y;
    assign y = s ? x1 : x0;
endmodule

module mux2x32(x0,x1,s,y);
    input [31:0] x0,x1;
    input s;
    output [31:0] y;
    assign y = s ? x1 : x0;
endmodule

module mux4x32(x0,x1,x2,x3,s,y);
    input [31:0] x0,x1,x2,x3;
    input [1:0] s;
    output [31:0] y;
    
    function [31:0] select;    
        input [31:0] x0,x1,x2,x3;
        input [1:0] s;
        case(s)
            2'b00: select = x0;
            2'b01: select = x1;
            2'b10: select = x2 - 32'h00400000;
            2'b11: select = x3 - 32'h00400000;
        endcase
    endfunction
    assign y = select(x0,x1,x2,x3,s);
endmodule

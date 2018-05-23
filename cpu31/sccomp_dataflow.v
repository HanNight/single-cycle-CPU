`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/22 12:28:34
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc,
    output [31:0] addr
    );
    wire [31:0] memout;
    wire [31:0] data;
    wire wmem;
    wire [31:0] pc1;
    
    assign pc = pc1 + 32'h00400000;
    
    imem imem(pc1[12:2],inst);
    sccpu_dataflow sccpu(clk_in,reset,inst,memout,pc1,wmem,addr,data);
    scdatamem dmem(clk_in,addr[6:2],data,wmem,memout);
endmodule

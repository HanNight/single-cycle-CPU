`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 01:34:14
// Design Name: 
// Module Name: sccu_dataflow
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


module sccu_dataflow(
    input [5:0] op,
    input [5:0] func,
    input zero,           //0标志位
    output wreg,          //写寄存器，为1时写，否则不写
    output wmem,          //写存储器，为1时写，否则为读
    output alua,          //ALU的a输入数据，为1时为立即数，否则为寄存器数据
    output alub,          //ALU的b输入数据，为1时为立即数，否则为寄存器数据
    output [3:0] aluc,    //ALU操作控制信号
    output regrt,         //目的寄存器选择，为1时为rt，否则为rd
    output [1:0] pcsource,//下一条指令地址选择
    output sext,          //立即数符号扩展，为1时符号扩展，否则零扩展
    output jal,           //子程序调用，为1时表示为jal，否则不是
    output m2reg          //写入寄存器数据选择，为1时为存储器数据，否则为ALU结果
    );
    
    wire r_type = ~|op;
    wire i_add = r_type & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
    wire i_addu = r_type & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & func[0];
    wire i_sub = r_type & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
    wire i_subu = r_type & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0];
    wire i_and = r_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
    wire i_or = r_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0];
    wire i_xor = r_type & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
    wire i_nor = r_type & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
    wire i_slt = r_type & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];
    wire i_sltu = r_type & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & func[0];
    wire i_sll = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
    wire i_srl = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
    wire i_sra = r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0];
    wire i_sllv = r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
    wire i_srlv = r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
    wire i_srav = r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
    wire i_jr = r_type & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];
    wire i_addi = ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
    wire i_addiu = ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0];
    wire i_andi = ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & ~op[0];
    wire i_ori = ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & op[0];
    wire i_xori = ~op[5] & ~op[4] & op[3] & op[2] & op[1] & ~op[0];
    wire i_lw = op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
    wire i_sw = op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
    wire i_beq = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
    wire i_bne = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
    wire i_slti = ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & ~op[0];
    wire i_sltiu = ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
    wire i_lui = ~op[5] & ~op[4] & op[3] & op[2] & op[1] & op[0];
    wire i_j = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
    wire i_jal = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
    
    assign wreg = i_add | i_addu | i_sub | i_subu | i_and | i_or | i_xor | i_nor | i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_slti | i_sltiu | i_lui | i_jal;
    assign wmem = i_sw;
    assign aluc[3] = i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_slti | i_sltiu | i_lui;
    assign aluc[2] = i_and | i_or | i_xor | i_nor | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_andi | i_ori | i_xori;
    assign aluc[1] = i_add | i_sub | i_xor | i_nor | i_slt | i_sltu | i_sll | i_sllv | i_addi | i_xori | i_lw | i_sw | i_beq | i_bne | i_slti | i_sltiu;
    assign aluc[0] = i_sub | i_subu | i_or | i_nor | i_slt | i_srl | i_srlv | i_ori | i_beq | i_bne | i_slti;
    assign sext = i_addi | i_addiu | i_lw | i_sw | i_beq | i_bne | i_slti;
    assign jal = i_jal;
    assign pcsource[1] = i_jr | i_j | i_jal;
    assign pcsource[0] = i_beq & zero | i_bne & ~zero | i_j | i_jal;
    assign alua = i_sll | i_srl | i_sra;
    assign alub = i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_sw | i_slti | i_sltiu | i_lui;
    assign regrt = i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_slti | i_sltiu | i_lui;
    assign m2reg = i_lw;

endmodule

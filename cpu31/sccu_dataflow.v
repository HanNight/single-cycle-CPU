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
    input zero,           //0��־λ
    output wreg,          //д�Ĵ�����Ϊ1ʱд������д
    output wmem,          //д�洢����Ϊ1ʱд������Ϊ��
    output alua,          //ALU��a�������ݣ�Ϊ1ʱΪ������������Ϊ�Ĵ�������
    output alub,          //ALU��b�������ݣ�Ϊ1ʱΪ������������Ϊ�Ĵ�������
    output [3:0] aluc,    //ALU���������ź�
    output regrt,         //Ŀ�ļĴ���ѡ��Ϊ1ʱΪrt������Ϊrd
    output [1:0] pcsource,//��һ��ָ���ַѡ��
    output sext,          //������������չ��Ϊ1ʱ������չ����������չ
    output jal,           //�ӳ�����ã�Ϊ1ʱ��ʾΪjal��������
    output m2reg          //д��Ĵ�������ѡ��Ϊ1ʱΪ�洢�����ݣ�����ΪALU���
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

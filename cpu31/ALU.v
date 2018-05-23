`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/09 00:31:42
// Design Name: 
// Module Name: alu
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


module alu(a,b,aluc,r,zero,carry,negative,overflow);
input [31:0] a,b;
input [3:0] aluc;
output [31:0] r;
output zero,carry,negative,overflow;
reg [31:0] r;
reg zero,carry,negative,overflow;
reg signed [31:0] sa,sb,sr;

always @ (*)
begin
  case(aluc)
    4'b0000:begin
      r = a + b;
      if(r < a || r < b)
          carry = 1;
      else
          carry = 0;
    end
    4'b0001:begin
      r = a - b;
      if(r > a)
        carry = 1;
      else
        carry = 0;
    end
    4'b0010:begin
      sa = $signed(a);
      sb = $signed(b);
      sr = sa + sb;
      if(sa > 0 && sb > 0)
      begin
        if(sr < 0)
          overflow = 1;
        else
          overflow = 0;
      end
      else if(sa < 0 && sb < 0)
      begin
        if(sr > 0)
          overflow = 1;
        else
          overflow = 0;
      end
      else
        overflow = 0;
      r = $unsigned(sr);
    end
    4'b0011:begin
      sa = $signed(a);
      sb = $signed(b);
      sr = sa - sb;
      if(sa >= 0 && sb <= 0)
      begin
        if(sr < 0)
          overflow = 1;
        else
          overflow = 0;
      end
      else if(a <= 0 && b >= 0)
      begin
        if(r > 0)
          overflow = 1;
        else
          overflow = 0;
      end
      else
        overflow = 0;
      r = $unsigned(sr);
    end
    4'b0100:begin
      r = a & b;
    end
    4'b0101:begin
      r = a | b;
    end
    4'b0110:begin
      r = a ^ b;
    end
    4'b0111:begin
      r = ~(a | b);
    end    
    4'b1000,4'b1001:begin
      r = {b[15:0],16'b0};
    end    
    4'b1010:begin
      r = (a<b)?1:0;
    end
    4'b1011:begin
      sa = $signed(a);
      sb = $signed(b);
      r = (sa<sb)?1:0;
    end
    4'b1100:begin
      sa = $signed(a);
      sb = $signed(b);
      if(sa != 0)
      begin
          sr = sb>>>(sa-1);
          carry = sr[0];
          sr = sr>>>1;
      end
      else
          sr = sb;
      r = $unsigned(sr);
    end
    4'b1101:begin
      if(a != 0)
      begin
          r = b>>(a-1);
          carry = r[0];
          r = r>>1;
      end
      else
          r = b;
    end
    4'b1110,4'b1111:begin
    if(a != 0)
    begin
        r = b<<(a-1);
        carry = r[31];
        r = r<<1;
    end
    else
        r = b;
    end
  endcase
  if(aluc == 4'b1010 || aluc == 4'b1011)
    zero = (a==b)?1:0;
  else
    zero = (r==0)?1:0;
  negative = r[31];
end
endmodule

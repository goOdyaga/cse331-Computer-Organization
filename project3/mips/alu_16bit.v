module alu_16bit(input [15:0]A,input [15:0]B,input cin,output [15:0] res,output cout,input [2:0]S);

wire[3:0] c;

cla_16 cla1(A[15:0],B[15:0],cin,c);

alu_4bit fuladd1(res[3:0], A[3:0], B[3:0], cin,S);
alu_4bit fuladd2(res[7:4], A[7:4], B[7:4], c[0],S);
alu_4bit fuladd3(res[11:8], A[11:8], B[11:8], c[1],S);
alu_4bit fuladd4(res[15:12], A[15:12], B[15:12], c[2],S);

or or1(cout,c[3],0);

endmodule
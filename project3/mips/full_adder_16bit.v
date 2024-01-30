module full_adder_16bit(input [15:0]A,input [15:0]B,input cin,output [15:0] sum,output cout);

wire[3:0] c;

cla_16 cla1(A[15:0],B[15:0],cin,c);

full_adder_4bit fuladd1(sum[3:0], A[3:0], B[3:0], cin);
full_adder_4bit fuladd2(sum[7:4], A[7:4], B[7:4], c[0]);
full_adder_4bit fuladd3(sum[11:8], A[11:8], B[11:8], c[1]);
full_adder_4bit fuladd4(sum[15:12], A[15:12], B[15:12], c[2]);

or or1(cout,c[3]);

endmodule
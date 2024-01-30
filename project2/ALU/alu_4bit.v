// 4 bit full adder

module alu_4bit (output [3:0] res,  input [3:0] a, input [3:0] b, input c_in,input [2:0]S);
// a:		a3 a2 a1 a0
// b:		b3 b2 b1 b0
// sum:	s3 s2 s1 s0
	wire [3:0]p ;
	wire [3:0]g ;

	fourbitand gres(a,b,g[3:0]);
	fourbitor pres(a,b,p[3:0]);
	wire [3:0]c;
	
	fourbcla fourbclares(c_in,c,p,g);
	
	alu_1bit fa1 (res[0],  a[0], b[0], c_in,S);
	alu_1bit fa2 (res[1],  a[1], b[1], c[0],S);
	alu_1bit fa3 (res[2],  a[2], b[2], c[1],S);
	alu_1bit fa4 (res[3],  a[3], b[3], c[2],S);

endmodule 

 
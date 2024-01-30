// 4 bit full adder

module full_adder_4bit (output [3:0] sum,  input [3:0] a, input [3:0] b, input c_in);
// a:		a3 a2 a1 a0
// b:		b3 b2 b1 b0
// sum:	s3 s2 s1 s0
	wire [3:0]p ;
	wire [3:0]g ;

	fourbitand gres(a,b,g[3:0]);
	fourbitor pres(a,b,p[3:0]);
	wire [3:0]c;
	
	fourbcla fourbclares(c_in,c,p,g);
	
	full_adder fa1 (sum[0],  a[0], b[0], c_in);
	full_adder fa2 (sum[1],  a[1], b[1], c[0]);
	full_adder fa3 (sum[2],  a[2], b[2], c[1]);
	full_adder fa4 (sum[3],  a[3], b[3], c[2]);

endmodule 

 
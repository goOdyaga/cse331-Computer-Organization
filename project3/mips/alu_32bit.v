module alu_32bit(input [31:0]A,input [31:0]B,output  [31:0] realres,output cout,input[2:0]S);

wire c;
	wire [31:0]res;
	wire [31:0]reslt;
	wire [3:0]snot;
	not not1(snot[0],S[0]);
	not not2(snot[1],S[1]);
	not not3(snot[2],S[2]);
	

	muxgate g5(S[2],S[1],snot[0],gat6);//110->subs
	muxgate g6(S[2],snot[1],snot[0],gate7);//100->setl
	
	
	or orsubles(gate6,gat6,gate7);
	
	wire [31:0]Btemp;

	revnum numaddsun(B,gate6,Btemp);

	alu_16bit lh(A[15:0],Btemp[15:0],gate6,res[15:0],c,S);
	alu_16bit rh(A[31:16],Btemp[31:16],c,res[31:16],cout,S);
	and stl(sltres,res[31],gate7);
	
	and_with_zero andwz(reslt,sltres);
	

	
	not not4(selectnot,gate7);
	
	muxbitcary muxcary1(res,reslt,selectnot,realres);

	
endmodule
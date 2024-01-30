module alu(output  [31:0] alu_result,output zero_bit,input [31:0]alu_src1,input [31:0]alu_src2,input[2:0]alu_ctr);

wire c;
wire c1;
wire c2;

	wire [31:0]res;
	wire [31:0]reslt;
	wire [3:0]snot;
	not not1(snot[0],alu_ctr[0]);
	not not2(snot[1],alu_ctr[1]);
	not not3(snot[2],alu_ctr[2]);
	

	muxgate g5(alu_ctr[2],alu_ctr[1],snot[0],gat6);//110->subs
	muxgate g6(alu_ctr[2],snot[1],snot[0],gate7);//100->setl
	
	
	or orsubles(gate6,gat6,gate7);
	
	wire [31:0]Btemp;

	revnum numaddsun(alu_src2,gate6,Btemp);

	alu_16bit lh(alu_src1[15:0],Btemp[15:0],gate6,res[15:0],c,alu_ctr);
	alu_16bit rh(alu_src1[31:16],Btemp[31:16],c,res[31:16],c1,alu_ctr);
	and stl(sltres,res[31],gate7);
	
	and_with_zero andwz(reslt,sltres);
	

	
	not not4(selectnot,gate7);
	
	muxbitcary muxcary1(res,reslt,selectnot,alu_result);
	
	or oralures(c2,alu_result[0],alu_result[1],alu_result[2],alu_result[3],
									 alu_result[4],alu_result[5],alu_result[6],alu_result[7],
			                   alu_result[8],alu_result[9],alu_result[10],alu_result[11],
									alu_result[12],alu_result[13],alu_result[14],alu_result[15],
									alu_result[16],alu_result[17],alu_result[18],alu_result[19],
									alu_result[20],alu_result[21],alu_result[22],alu_result[23],
									alu_result[24],alu_result[25],alu_result[26],alu_result[27],
									alu_result[28],alu_result[29],alu_result[30],alu_result[31]);
	not notzr(zero_bit,c2);
	

	
endmodule
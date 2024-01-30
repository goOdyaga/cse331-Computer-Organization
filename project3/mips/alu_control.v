module alu_control (
	output  [2:0] alu_ctr,
	input [5:0] function_code,
	input [2:0] ALUop);
	
	
	
	not n1(nf0,function_code[0]);
	not n2(nf1,function_code[1]);
	not n3(nf2,function_code[2]);
	not n4(nf3,function_code[3]);
	not n5(nf4,function_code[4]);
	not n6(nf5,function_code[5]);
	
	not n7(np0,ALUop[0]);
	not n8(np1,ALUop[1]);
	not n9(np2,ALUop[2]);
	
	

	//C2=P2P1'+P1P0'+F1
	 
	and and1(andv1,ALUop[2],np1);
	and and2(andv2,ALUop[1],np0);
	and andf(fc2,function_code[1],ALUop[2],ALUop[1],ALUop[0]);
	xor or1(alu_ctr[2],andv2,fc2,andv1);
	
	//C1=P1P0'+F2'F0
	
	and and3(andv3,nf2,function_code[0],ALUop[2],ALUop[1],ALUop[0]);
	
	xor or2(alu_ctr[1],andv3,andv2);

		
	//C0=P1'P0+ (F1 xor F0)
	
		and and4(andv4,np1,ALUop[0]);
		
		xor xor1(xorv1,function_code[1],function_code[0]);
		and andh(xorv1and,xorv1,ALUop[2],ALUop[1],ALUop[0]);
		
		xor or32(alu_ctr[0],andv4,xorv1and);
		

endmodule
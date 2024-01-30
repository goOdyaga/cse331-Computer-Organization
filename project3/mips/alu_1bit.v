module alu_1bit (output res, input a, b, c_in,input [2:0]S);


	wire [3:0]snot;
	not not1(snot[0],S[0]);
	not not2(snot[1],S[1]);
	not not3(snot[2],S[2]);
	
	muxgate g1(snot[0],snot[1],snot[2],gate1);//000->and
	muxgate g2(snot[2],snot[1],S[0],gate2);//001->or
	muxgate g3(snot[2],S[1],snot[0],gate3);//010->xor
	muxgate g4(snot[2],S[1],S[0],gate4);//011->nor
	
	muxgate g5(S[2],snot[1],S[0],gate5);//101->add
	muxgate g6(S[2],S[1],snot[0],gate6);//110->subs
	muxgate g7(S[2],snot[1],snot[0],gate7);//100->slt
	
	or orsubsand(gateadd1,gate6,gate5);
	or orsubsand2(gateadd,gateadd1,gate7);
	
	
	
	my_xor xor1 (a_xor_b, a, b);
	my_xor xor2 (temp1, a_xor_b, c_in);
	
	//and
	and and1(temp2,a,b); 
	//or
	or or1(temp3,a,b);
	//nor
	nor nor1(temp4,a,b);
	//xor
	xor xor3(temp5,a,b);
	
	
	
	
	
	and andres1(tempres1,temp2,gate1);
	and andres2(tempres2,temp3,gate2);
	and andres3(tempres3,temp5,gate3);
	and andres4(tempres4,temp4,gate4);
	and andres5(tempres5,temp1,gateadd);

	aluselct aalslct1(res,tempres1,tempres2,tempres3,tempres4,tempres5);
	
	
endmodule 
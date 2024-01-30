module my_xor(output y, input a,b);
	
	and and1(and1output,a,b);
	and and2(and2output,a,!and1output);
	and and3(and3output,b,!and1output);
	and and4(and4output,!and2output,!and3output);
	not not1(y,and4output);
endmodule
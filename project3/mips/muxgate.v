module muxgate(input a,input c,input b,output d);

	and and1(temp1,a,b);
	and and2(d,c,temp1);

endmodule
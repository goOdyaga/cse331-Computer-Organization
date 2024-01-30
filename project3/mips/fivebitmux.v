module fivebitmux(input [4:0] a,input [4:0] b, input select,output [4:0]realres);



wire [4:0]res;
	wire [4:0]resb;
	not not4(selectnot,select); 
	
	 and and1(res[0], a[0], select);
  and and2(res[1], a[1], select);
  and and3(res[2], a[2], select);
  and and4(res[3], a[3], select);
  and and5(res[4], a[4], select);
  
  and and1b(resb[0], b[0], selectnot);
  and and2b(resb[1], b[1], selectnot);
  and and3b(resb[2], b[2], selectnot);
  and and4b(resb[3], b[3], selectnot);
  and and5b(resb[4], b[4], selectnot);
  
  
   or or1b(realres[0],    resb[0], res[0]);
  or or2b(realres[1],   resb[1], res[1]);
  or or3b(realres[2],   resb[2], res[2]);
  or or4b(realres[3],   resb[3], res[3]);
  or or5b(realres[4],   resb[4], res[4]);
	
	
 

endmodule
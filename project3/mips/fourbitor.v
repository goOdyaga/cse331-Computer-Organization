module fourbitor(input [3:0]a,input [3:0]b,output [3:0] res);

or or0(res[0],a[0],b[0]);
or or1(res[1],a[1],b[1]);
or or2(res[2],a[2],b[2]);
or or3(res[3],a[3],b[3]);

endmodule
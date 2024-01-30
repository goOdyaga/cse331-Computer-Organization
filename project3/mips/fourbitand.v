module fourbitand(input [3:0]a,input [3:0]b,output [3:0] res);

and and0(res[0],a[0],b[0]);
and and1(res[1],a[1],b[1]);
and and2(res[2],a[2],b[2]);
and and3(res[3],a[3],b[3]);

endmodule
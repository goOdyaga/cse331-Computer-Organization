module blockgenerate(input[3:0]p,output pres);

and and1(a,p[0],p[1]);
and and2(b,p[2],p[3]);
and and3(pres,a,b);

endmodule
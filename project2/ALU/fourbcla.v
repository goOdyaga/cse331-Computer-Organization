
module fourbcla(input cin,output [3:0]c,input[3:0]p,input[3:0]g);



//c1 = g0 + p0c0

and and1(pc0,p[0],cin);
or or1(c[0],pc0,g[0]);


//c2 = g1 + p1g0 + p1p0c0

and and2(pc1,pc0,p[1]);
and and3(pg0,p[1],g[0]);
or or2(l1,g[1],pg0);
or or3(c[1],l1,pc1);



//c3 = g2 + p2g1 + p2p1g0 + p2p1p0c0

and and4(pc2,pc1,p[2]);
and and5(pg1,pg0,p[2]);
and and6(pgs1,p[2],g[1]);
or or4(l2,g[2],pgs1);
or or5(r1,pc2,pg1);
or or6(c[2],l2,r1);

//c4 = g3 + p3g2 + p3p2g1 + p3p2p1g0 + p3p2p1p0c0
and and7(pc3,pc2,p[3]);
and and8(pg2,pg1,p[3]);
and and9(pgs2,p[3],pgs1);
and and10(pgs3,p[3],g[2]);
or or7(l3,g[3],pgs3);
or or8(r2,pc3,pg2);
or or9(t1,l3,r2);
or or10(c[3],t1,pgs2);



endmodule
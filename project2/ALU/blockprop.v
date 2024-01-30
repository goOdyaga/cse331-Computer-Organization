module blockprop (
    input [3:0] p,
    input [3:0] g,
    output gres
);

    // G3:0 = g3 + p3g2 + p3p2g1 + p3p2p1g0

    // p3p2p1g0
    wire a, b, pres1;
    and and1(a, g[0], p[1]);
    and and2(b, p[2], p[3]);
    and and3(pres1, a, b);

    // p3p2g1
    wire c, pres2;
    and and4(c, p[2], p[3]);
    and and5(pres2, c, g[1]);

	and and6(d,p[3],g[2]);
    // Combine results
    wire l1, l2;
    or or1(l1, pres1, pres2);
    or or2(l2, d, g[3]);
    or or3(gres, l1, l2);

endmodule

module cla_16 (
    input [15:0] A,
    input [15:0] B,
    input cin,
    output [3:0] c
);

wire[15:0] p;
wire[15:0] g;

    wire [3:0] G;
    wire [3:0] P;
    
    // P3:0 G3:0
    fourbitand gres1(A[3:0], B[3:0], g[3:0]);
    fourbitor pres1(A[3:0], B[3:0], p[3:0]);
    
    // P4:7 G4:7
    fourbitand gres2(A[7:4], B[7:4], g[7:4]);
    fourbitor pres2(A[7:4], B[7:4], p[7:4]);
    
    // P8:11 G8:11
    fourbitand gres3(A[11:8], B[11:8], g[11:8]);
    fourbitor pres3(A[11:8], B[11:8], p[11:8]);
    
    // P12:15 G12:15
    fourbitand gres4(A[15:12], B[15:12], g[15:12]);
    fourbitor pres4(A[15:12], B[15:12], p[15:12]);
    
    // P3:0 = p3p2p1p0, G3:0 = g3 + p3g2 + p3p2g1 + p3p2p1g0
    blockgenerate b1(p[3:0], P[0]);
    blockprop p1(p[3:0], g[3:0], G[0]);

    // P4:7 = p7p6p5p4, G4:7 = g7 + p7g6 + p7p6g5 + p7p6p5g4
    blockgenerate b2(p[7:4], P[1]);
    blockprop p2(p[7:4], g[7:4], G[1]);

    // P8:11 = p11p10p9p8, G8:11 = g11 + p11g10 + p11p10g9 + p11p10p9g8
    blockgenerate b3(p[11:8], P[2]);
    blockprop p3(p[11:8], g[11:8], G[2]);

    // P12:15 = p15p14p13p12, G12:15 = g15 + p15g14 + p15p14g13 + p15p14p13g12
    blockgenerate b4(p[15:12], P[3]);
    blockprop p4(p[15:12], g[15:12], G[3]);

    // fourbcla
    fourbcla fbcla1(cin, c, P, G);

endmodule

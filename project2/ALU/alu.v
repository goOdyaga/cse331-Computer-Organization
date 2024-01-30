module alu(input [31:0]A,input [31:0]B,output  [31:0] realres,output done,input[2:0]S,input clk,input reset);

wire c;
	wire [31:0]res;
	wire [31:0]reslt;
	wire [3:0]snot;
	not not1(snot[0],S[0]);
	not not2(snot[1],S[1]);
	not not3(snot[2],S[2]);
	


	muxgate g7(S[2],S[1],S[0],gate8);//111->mod
	wire [31:0] result;
	  mod uut(
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .result(result),
        .done(done)
    );
	
	wire [31:0] rs3;
	//wire cout;
	alu_32bit alu1(A,B,rs3,cout,S);
	muxbitcary muxcary2(rs3,result,!gate8,realres);
	
endmodule
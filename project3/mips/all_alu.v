module all_alu(output  [31:0] alu_result,output zero_bit,input [31:0]alu_src1,input [31:0]alu_src2,input[2:0]alu_ctr,input clk,input reset);

wire c;
	wire [31:0]res;
	wire [31:0]reslt;
	wire [3:0]snot;
	not not1(snot[0],alu_ctr[0]);
	not not2(snot[1],alu_ctr[1]);
	not not3(snot[2],alu_ctr[2]);
	


	muxgate g7(alu_ctr[2],alu_ctr[1],alu_ctr[0],gate8);//111->mod
	wire [31:0] result;
	  mod uut(
        .clk(clk),
        .reset(reset),
        .A(alu_src1),
        .B(alu_src2),
        .result(result),
        .done(zero_bit)
    );
	
	wire [31:0] rs3;
	//wire cout;
	alu alu1(rs3,cout,alu_src1,alu_src2,alu_ctr);
	muxbitcary muxcary2(rs3,result,!gate8,alu_result);
	
endmodule
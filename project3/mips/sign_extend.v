module sign_extend (
 output  [31:0] sign_ext_imm,
 input [15:0] imm);
 
 
 wire [31:0] a;
 
 
	heplext h1(16'b0,sign_ext_imm[31:16],imm[15]);
  heplext h12(imm[15:0],sign_ext_imm[15:0],0);
 endmodule
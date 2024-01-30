module control_unit (
 output  regDst,
 output  branch,
 output memRead, 
 output memWrite,
 output [2:0] ALUop, 
 output ALUsrc,
 output regWrite,
 output jump,
 output byteOperations, 
 output move, 
 input [5:0] opcode); 
 
 wire [1:0]branch1;
 wire [1:0]jump1;
 wire [1:0]byteOperations1;
  wire [1:0]memRead1;
 wire [1:0]memWrite1;
 wire [9:0]regWrite1;
 
 wire [8:0]ALusrc1;
 wire regDst1[8:0];
 
 
 detectopcode det1(opcode,6'b100011,branch1[0]);
 
 detectopcode det2(opcode,6'b100111,branch1[1]);
 
 or o1(branch,branch1[0],branch1[1]);
 
 
 
 detectopcode det3(opcode,6'b001000,memRead1[0]);
 
 detectopcode det4(opcode,6'b001001,memRead1[1]);
 
 or or2(memRead,memRead1[0],memRead1[1]);
  
 
 detectopcode det5(opcode,6'b010000,memWrite1[0]);
 
 detectopcode det6(opcode,6'b010001,memWrite1[1]);
  
 or or3(memWrite,memWrite1[0],memWrite1[1]);
 
 //control signal of write to register
  
 detectopcode det7(opcode,6'b000000,regWrite1[0]);
 
 detectopcode det8(opcode,6'b000010,regWrite1[1]);
 
 detectopcode det9(opcode,6'b000011,regWrite1[2]);
 
 detectopcode det10(opcode,6'b000100,regWrite1[3]);
 
 detectopcode det11(opcode,6'b000101,regWrite1[4]);
 
 detectopcode det12(opcode,6'b001000,regWrite1[5]);
 
 detectopcode det13(opcode,6'b001001,regWrite1[6]);
 
 detectopcode det14(opcode,6'b000111,regWrite1[7]);
 
 detectopcode det15(opcode,6'b100000,regWrite1[8]);
 
 detectopcode det16(opcode,6'b111001,regWrite1[9]);
 
 or or4(regWrite,regWrite1[0],regWrite1[1],regWrite1[2],regWrite1[3],regWrite1[4],regWrite1[5],regWrite1[6],regWrite1[7],regWrite1[8],regWrite1[9]);

 //control signal of the write registerd
 
 detectopcode det17(opcode,6'b000010,regDst1[0]);
 detectopcode det47(opcode,6'b000011,regDst1[1]);
 detectopcode det48(opcode,6'b000100,regDst1[2]);
 detectopcode det173(opcode,6'b000101,regDst1[3]);
 detectopcode det174(opcode,6'b001000,regDst1[4]);
 detectopcode det175(opcode,6'b010000,regDst1[5]);
 detectopcode det176(opcode,6'b001001,regDst1[6]);
 detectopcode det178(opcode,6'b010001,regDst1[7]);
  detectopcode det179(opcode,6'b100000,regDst1[8]);
 
 or xor1(regDst,regDst1[0],regDst1[1],regDst1[2],regDst1[3],regDst1[4],regDst1[5],regDst1[6],regDst1[7],regDst1[8]);
 
 //control signal to take sign extend
 
 detectopcode det18(opcode,6'b000010,ALusrc1[0]);
 
 detectopcode det19(opcode,6'b000011,ALusrc1[1]);
 
 detectopcode det20(opcode,6'b000100,ALusrc1[2]);
 
 detectopcode det21(opcode,6'b000101,ALusrc1[3]);
 
 detectopcode det22(opcode,6'b001000,ALusrc1[4]);
 
  detectopcode det23(opcode,6'b010000,ALusrc1[5]);
 
 detectopcode det24(opcode,6'b001001,ALusrc1[6]);
 
 detectopcode det25(opcode,6'b010001,ALusrc1[7]);
 
 detectopcode det26(opcode,6'b000111,ALusrc1[8]);
 
 
 or or8(ALUsrc,ALusrc1[0],ALusrc1[1],ALusrc1[2],ALusrc1[3],ALusrc1[4],ALusrc1[5],ALusrc1[6],ALusrc1[7],ALusrc1[8]);
 
 
 detectopcode det27(opcode,6'b111000,jump1[0]);
 
 detectopcode det28(opcode,6'b111001,jump1[1]);
 
 //detectopcode det29(opcode,6'b000000,jump1[2]);
 
 or o9(jump,jump1[0],jump1[1]);
 
 
 detectopcode det30(opcode,6'b100000,move);
 

 
 
 detectopcode det31(opcode,6'b001001,byteOperations1[0]);
 
 detectopcode det32(opcode,6'b010001,byteOperations1[1]);
 
 or o11(byteOperations,byteOperations1[0],byteOperations1[1]);
 
//P0+P2'=C2
 
 
	not not1(p0,opcode[0]);
	not not2(p1,opcode[1]);
	not not3(p2,opcode[2]);
	not not4(p3,opcode[3]);
	not not5(p4,opcode[4]);
	not not6(p5,opcode[5]);

	or or5(ALUop[2],p2,opcode[0]);
 
 //C1=p2'p1p0+p5'p0'p1'p2'+p5p0p1p2
 
	and and1(andv1,p2,opcode[1],opcode[0]);
	and and2(andv2,p5,p0,p1,p2,p3,p4);
	and and3(andv3,opcode[0],opcode[1],opcode[2],opcode[5],p3,p4);
	or or6(ALUop[1],andv1,andv2,andv3);
	
	//C0=(p1'+p0').(p2p1'p0)'
	
	or or7(orvl7,p1,p0);
	and and4(andv4,opcode[2],p1,opcode[0]);
	not notand(notand1,andv4);
	and and5(ALUop[0],orvl7,notand1);
	
	
	
 
 
 
 
 
 
 
 endmodule
module shift_left_2 (
 output  [31:0] shifted_address,
 input [31:0] address);
 
 
  heplext h1(address[29:14],shifted_address[31:16],0);
  or or1(shifted_address[15],address[13],0);
  or or2(shifted_address[14],address[12],0);
  or or3(shifted_address[13],address[11],0);
  or or4(shifted_address[12],address[10],0);
  or or5(shifted_address[11],address[9],0);
  or or6(shifted_address[10],address[8],0);
  or or7(shifted_address[9],address[7],0);
  or or8(shifted_address[8],address[6],0);
  or or9(shifted_address[7],address[5],0);
  or or10(shifted_address[6],address[4],0);
  or or11(shifted_address[5],address[3],0);
  or or12(shifted_address[4],address[2],0);
  or or13(shifted_address[3],address[1],0);
  or or14(shifted_address[2],address[0],0);
  or or15(shifted_address[1],0,0);
  or or16(shifted_address[0],0,0);
  

 
 endmodule
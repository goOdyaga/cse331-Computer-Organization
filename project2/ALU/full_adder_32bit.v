module full_adder_32bit(input [31:0]A,input [31:0]B,input cin,output [31:0] sum,output cout);

wire c;
or or1(ora,A[31],0);


and and1(resn,ora,1);
wire [31:0] rest;
wire [31:0] rest1;
full_adder_16bit lh(A[15:0],B[15:0],cin,rest[15:0],c);
full_adder_16bit rh(A[31:16],B[31:16],c,rest[31:16],cout);

revnum numaddsun(rest,resn,rest1);


full_adder_16bit lh1(rest1[15:0],16'b0,resn,sum[15:0],c);
full_adder_16bit rh2(rest1[31:16],16'b0,c,sum[31:16],cout);

endmodule
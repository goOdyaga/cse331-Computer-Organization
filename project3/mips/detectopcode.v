module detectopcode(input [5:0] A, input [5:0] B, output res);

// XOR gates for bit-wise comparison
wire [5:0] temp;
xor xor0(temp[0], A[0], B[0]);
xor xor1(temp[1], A[1], B[1]);
xor xor2(temp[2], A[2], B[2]);
xor xor3(temp[3], A[3], B[3]);
xor xor4(temp[4], A[4], B[4]);
xor xor5(temp[5], A[5], B[5]);

// NOR gate to determine if all bits are equal
nor(res, temp[0], temp[1], temp[2], temp[3], temp[4], temp[5]);

endmodule

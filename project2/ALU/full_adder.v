// full_adder

module full_adder (output sum, input a, b, c_in);
	my_xor xor1 (a_xor_b, a, b);
	my_xor xor2 (sum, a_xor_b, c_in);
endmodule 
module my_testbenche();

    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] select;
    wire [31:0] result;
    wire done;

	     reg clk, reset;
	
    alu res(a, b, result, done, select,clk,reset);
initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with a period of 10 ns
    end
	 
    // Test sequence
    initial begin
        reset = 1;

       
		  
		  #60 a = 32'b00000000111111110101010100001111; b = 32'b11111111000000001010101111111100; select = 3'b000;    
        #60 $display("Operation: AND");
		  #60 $display("   %b\n   %b", a, b);
		  #60 $display("  --------------------------------  ");
		  #60 $display("   %b\n",result);

		  
		  #60 a = 32'b11111111000000001111111100000000; b = 32'b00000000111111110101010101010101; select = 3'b001;  
     
		   #60 $display("Operation: OR");
		  #60 $display("   %b\n   %b", a, b);
		  #60 $display("  --------------------------------  ");
		  #60 $display("   %b\n",result);

         #60 a = 32'b11111111000000001111111100000000; b = 32'b00000000111111110101010101010101; select = 3'b010;  
      
		   #60 $display("Operation: XOR");
		  #60 $display("   %b\n   %b", a, b);
		  #60 $display("  --------------------------------  ");
		  #60 $display("   %b\n",result);

         #60 a = 32'b11111111000000001111111100000000; b = 32'b00000000111111110101010101010101; select = 3'b011;  
       
		   #60 $display("Operation: NOR");
		  #60 $display("   %b\n   %b", a, b);
		  #60 $display("  --------------------------------  ");
		  #60 $display("   %b\n",result);

        #60 a = 82; b = 19; select = 3'b100;
        #60 $display("Operation: LESS THAN ->  %d < %d = %d  ", a, b, result);
		  
		  #60 a = 19; b = 82; select = 3'b100;
        #60 $display("Operation: LESS THAN -> %d < %d = %d  ", a, b, result);
		  
        #60 a = 19; b = 82; select = 3'b101;
        #60 $display("Operation: ADD -> %d + %d = %d  ", a, b, result);
		  #60 a = -5; b = -7; select = 3'b101;
        #60 $display("Operation: ADD -> %b + %b = %b  ", a, b, result);

   

        #60 a = 82; b = 19; select = 3'b110;
        #60 $display("Operation: SUB-> %d - %d = %d ", a, b, result);
		  
		  #60 a = 82; b = -19; select = 3'b110;
        #60 $display("Operation: SUB-> %d - %d = %d ", a, b, result);
		  
		   #60 a = 113; b = 47; select = 3'b111;reset=0;
				wait(done);
				
			
        
		  $display("Operation: MOD-> %d %% %d = %d ", a, b, result);
		  reset=1;
		  #60 a = 25; b = 47; select = 3'b111;reset=0;
				wait(done);
			
        
		  $display("Operation: MOD-> %d %% %d = %d ", a, b, result);
		  reset=1;
		  #60 a = 29; b = 8; select = 3'b111;reset=0;
				wait(done);
			
        
		  $display("Operation: MOD-> %d %% %d = %d ", a, b, result);
	
    end

endmodule

module  mips 
 (input clock ) ;
 


wire RegDst, Branch, MemRead;
wire jrsignal;
wire lastregwrite;
//wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire zero_bit;
wire jump;
wire move;
wire byteOperations;

wire [31:0] regraddata1;
wire [31:0] regraddata2;
reg [31:0] regwritedata;
reg [4:0]  regreadreg1;
reg [4:0]  regreadreg2;
reg [4:0]  regwrite1;
reg regwritereg;


wire [31:0] regmemraddata;
reg reginputbyte;
reg [17:0] regadress;
reg[31:0] regmemwritedata;
reg regmemraed;
reg regmedwrite;
    
    // Data paths
    wire [31:0] pc;
	wire [31:0] alu_result;
	wire [31:0]instruction;
	wire [31:0] write_data;
			wire [31:0] write_data_last;
wire [31:0]	read_data_1;
wire [31:0] read_data_2;
wire [31:0]ALu_read_data_2;
wire [31:0] memRead_data;
wire [31:0] MemtoReg_res;
wire [31:0]move_res;
    wire [4:0] write_register_rd;
	 wire [4:0]read_register;
	 wire [4:0]	write_register;
	 wire [2:0] ALUOp;
	wire [2:0] ALUctr;
   wire [31:0] sign_ext_imm;

    // PC update logic
    wire [31:0] pc_next;
	 wire [31:0] pc_plus_4;
	wire [31:0] pc_branch_target;
	 
	 
	 reg [31:0] PC;
	 
	 //read instruciton from the instruciton memory
	 instruction_block instblck1(instruction,PC);
	 
	 //choose write register between rt and rd
	 fivebitmux fvbtmx(instruction[20:16],instruction[15:11],RegDst,write_register_rd);
	 
	 //choose jr register between rt and rd
	 fivebitmux reggdest(instruction[15:11],instruction[20:16],jrsignal,read_register);
	 
	 //choose jr register between rt and rd
	 fivebitmux jrdest(5'b11111,write_register_rd,jump,write_register);
	 
	 wire [31:0] write_data_jal;
	 //mux move
	 muxbitcary movemux(
				.a(read_data_1),
				.b(write_data_jal),
				.select(move),
				.realres(move_res));
	
	muxbitcary movemuxjal(
				.a(pc_plus_4),
				.b(write_data),
				.select(jump),
				.realres(write_data_jal));
	 
	 
	 //pc mux

		muxbitcary pcmux(
				.a(pc_plus_4),
				.b(move_res),
				.select(jump),
				.realres(write_data_last));
		
	 //register block
	  register_block  rgstrblck( 
		.read_data1(read_data_1), 
		.read_data2(read_data_2),  
		.write_data(regwritedata), 
		.read_reg1(regreadreg1),
		.read_reg2(regreadreg2), 
		.write_reg(regwrite1), 
		.regWrite(regwritereg));
	 
	/* register_block  rgstrblck( 
		.read_data1(read_data_1), 
		.read_data2(
		),  
		.write_data(write_data_last), 
		.read_reg1(instruction[25:21]),
		.read_reg2(read_register), 
		.write_reg(write_register), 
		.regWrite(lastregwrite));*/
		
		
		
		/*
		memory_block mmrblck(
			 .read_data(memRead_data),
			 .byteOperations(byteOperations),
			 .address(alu_result[17:0]),
			 .write_data(read_data_2),
			 .memRead(MemRead),
			 .memWrite(MemWrite));
		
		*/
		memory_block mmrblck(
			 .read_data(memRead_data),
			 .byteOperations(reginputbyte),
			 .address(regadress),
			 .write_data(regmemwritedata),
			 .memRead(regmemraed),
			 .memWrite(regmedwrite));
		
		xnor xnortemp1(xnortempv1,RegWrite,1'b1);
		xnor xnortemp2(xnortempv2,jrsignal,1'b0);
		
		and lastregw(lastregwrite,xnortempv1,xnortempv2);
	 
	 //control unit block
	 
	   control_unit cntrlnt(
		 .regDst(RegDst),
		 .branch(Branch),
		 .memRead(MemRead),
		 .memWrite(MemWrite),
		 .ALUop(ALUOp),
		 .ALUsrc(ALUSrc),
		 .regWrite(RegWrite),
		 .jump(jump),
		 .byteOperations(byteOperations),
		 .move(move),
		 .opcode(instruction[31:26])); 
		 
	
		//signextend block
		sign_extend sgnxtnd(
			.sign_ext_imm(sign_ext_imm),
			.imm(instruction[15:0]));
			 
		//ALU control block
		 alu_control alcntr(
			.alu_ctr(ALUctr),
			.function_code(instruction[5:0]),
			.ALUop(ALUOp));
			
		//AluSrc MUX
			muxbitcary mxbcry(
				.b(read_data_2),
				.a(sign_ext_imm),
				.select(ALUSrc),
				.realres(ALu_read_data_2));
		
		//ALU
		alu alu1(
			.alu_result(alu_result),
			.zero_bit(zero_bit),
			.alu_src1(read_data_1),
			.alu_src2(ALu_read_data_2),
			.alu_ctr(ALUctr));
			
			nor andjrdetect1(andjrdetect1res,ALUctr[0],0);
			nor andjrdetect2(andjrdetect2res,ALUctr[1],0);
			nor andjrdetect3(andjrdetect3res,ALUctr[2],0);
			
			and andres(detectjr,andjrdetect1res,andjrdetect2res,andjrdetect3res);
			
			
			wire orlure;
			or oralures(orlure,alu_result[0],alu_result[1],alu_result[2],alu_result[3],
									 alu_result[4],alu_result[5],alu_result[6],alu_result[7],
			                   alu_result[8],alu_result[9],alu_result[10],alu_result[11],
									alu_result[12],alu_result[13],alu_result[14],alu_result[15],
									alu_result[16],alu_result[17],alu_result[18],alu_result[19],
									alu_result[20],alu_result[21],alu_result[22],alu_result[23],
									alu_result[24],alu_result[25],alu_result[26],alu_result[27],
									alu_result[28],alu_result[29],alu_result[30],alu_result[31]);
			not notalu(jrnot1,orlure);
			and andbranchjr(jrnot2,jrnot1,!Branch);
			and andjrlast(jrsignal,jrnot2,detectjr);
		wire [31:0] lefst;
			
			shift_left_2 shlt(
.shifted_address(lefst),
 .address(sign_ext_imm));
			wire [31:0] jr_data;
			//jumpregister to PC
			 muxbitcary jr_pc1(
				.a(read_data_2),
				.b(lefst),
				.select(jrsignal),
				.realres(jr_data));
				
			wire [31:0] pc_next_last;
			//wire orjumpjr;
			or orjrse(orjumpjr,jrsignal,jump);
			//jumpregister to PC
			 muxbitcary jr_pc(
				.a(jr_data),
				.b(pc_next_last),
				.select(orjumpjr),
				.realres(pc_next));
			
		
			//Data mempry block
			/*memory_block mmrblck(
			 .read_data(memRead_data),
			 .byteOperations(byteOperations),
			 .address(alu_result[17:0]),
			 .write_data(read_data_2),
			 .memRead(MemRead),
			 .memWrite(MemWrite));
			 */
			//MemtoReg MUX
			muxbitcary mxbcry1(
				.a(memRead_data),
				.b(alu_result),
				.select(MemRead),
				.realres(write_data));
				
			//PC+4
			wire cout;
			
			
			alu alu11(
			.alu_result(pc_plus_4),
			.zero_bit(cout),
			.alu_src1(PC),
			.alu_src2(32'b00000000000000000000000000000100),
			.alu_ctr(3'b101));
			
			wire zero_bit_temp;
			//jump PC
			alu alu2(
			.alu_result(pc_branch_target),
			.zero_bit(zero_bit_temp),
			.alu_src1(pc_plus_4),
			.alu_src2(lefst),
			.alu_ctr(3'b101));
			
			wire branchcheck;
			and andbranch(branchcheck,bneres,Branch);
			
			wire branchne;
			detectopcode detbne(instruction[31:26],6'b100111,branchne);
			
			xor xorbne(bneres,zero_bit,branchne); 
			
			//jumo MUX
			muxbitcary mxbcry2(
				.a(pc_branch_target),
				.b(pc_plus_4),
				.select(branchcheck),
				.realres(pc_next_last));
			

// Initialization of the PC for simulation
reg [31:0] registers [31:0];
reg [31:0] temp;


		initial begin
			 PC = 32'b0; // Starting address of the program, often the start of the text segment
		end
		
		
		always @(posedge clock) begin
		
		$readmemb("instructions.mem", registers);
				// $display("=> %d\n",pc_next);

				 temp=registers[pc_next/4];
		 
		
				if (temp[0]==1'b0 ||  temp[0]==1'b1) begin
        
					PC <= pc_next;
				end
				
				else begin
				$stop;
				end
		
		end
		
		always @(*) begin
		
			if(clock) begin
			
		
				regwritereg <= 0;
				regmemraed <=0;
				regmedwrite <=0;
		
			end
		
			else begin
				//$display("FUCK\n");
			regwritedata <= write_data_last;
				regreadreg1 <= instruction[25:21];
				regreadreg2 <= read_register;
				regwrite1 <= write_register;
				
		
		
		

				 reginputbyte <= byteOperations;
				 regadress <= alu_result[17:0];
				 regmemwritedata <=read_data_2;
				
				 
				
				 
		 
				
			end
      end
		
		always @(negedge clock) begin
		
		#5
		//	$display(" %d  %d %d %d\n",read_data_1,ALu_read_data_2,alu_result,write_data_last);
		 regmemraed <=MemRead;
				 regmedwrite <=MemWrite;
				 regwritereg <= lastregwrite;
		end
	
    
    // ... PC update logic here ...
 
endmodule
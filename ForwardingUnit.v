module ForwardingUnit(
	input [4:0] EX_MEM_RegisterRD,
	input	[4:0] MEM_WB_RegisterRD,
	input [4:0] ID_EX_RegisterRS,
	input [4:0] ID_EX_RegisterRT,
	input [4:0] EX_MEM_RegisterRT,
	input [4:0] MEM_WB_RegisterRT,
	input ID_EX_MemWrite,
	input EX_MEM_MemRead,
	input EX_MEM_RegWrite,
	input MEM_WB_RegWrite,
	input MEM_WB_MemRead,
	input JMP,
	output reg [1:0] ForwardA,
	output reg [1:0] ForwardB,
	output reg ForwardC
);


always@(*) 
	begin
		begin
			if(EX_MEM_RegWrite &&
				EX_MEM_RegisterRD != 0 && 
				EX_MEM_RegisterRD == ID_EX_RegisterRS)
					ForwardA = 2'b10;
			else if(MEM_WB_RegWrite && 
				MEM_WB_RegisterRD != 0 && 
				EX_MEM_RegisterRD != ID_EX_RegisterRS &&
				MEM_WB_RegisterRD == ID_EX_RegisterRS)
					ForwardA = 2'b01;
			else
					ForwardA = 2'b00;
		end
		begin
			if(JMP == 1)
				ForwardB = 2'b00;
			else if(EX_MEM_RegWrite && 
				EX_MEM_RegisterRD != 0 && 
				EX_MEM_RegisterRD == ID_EX_RegisterRT)
					ForwardB = 2'b10;
			else if(MEM_WB_RegWrite && 
				MEM_WB_RegisterRD != 0 && 
				EX_MEM_RegisterRD != ID_EX_RegisterRT &&
				MEM_WB_RegisterRD == ID_EX_RegisterRT)
					ForwardB = 2'b01;
			else
					ForwardB = 2'b00;
		end
		/*begin
			if((EX_MEM_RegisterRT == ID_EX_RegisterRT) && EX_MEM_MemRead && ID_EX_MemWrite)
				ForwardC = 1'b1;
			else 	
				ForwardC = 1'b0;
		*/
		begin
			if((MEM_WB_RegisterRT == ID_EX_RegisterRT) && MEM_WB_MemRead && ID_EX_MemWrite)
				ForwardC = 1'b1;
			else 	
				ForwardC = 1'b0;		
		end

	end
endmodule
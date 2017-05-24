module HazardDetection
(
	input ID_EX_MemRead,
	input EX_MEM_BranchDetected,
	input JMP,
	input JAL,
	input JR,
	input [4:0] ID_EX_RegisterRt,
	input [4:0] IF_ID_RegisterRt,
	input [4:0] IF_ID_RegisterRs,
	output reg PCWrite,
	output reg IF_IDWrite,
	output reg ID_EXWrite,
	output reg CtrlWrite
);



always@(*) 
	begin
	///// HazardDetection Load Word
		if (ID_EX_MemRead &&(ID_EX_RegisterRt == IF_ID_RegisterRs
			|| ID_EX_RegisterRt == IF_ID_RegisterRt))
			begin
				ID_EXWrite = 1'b1;
				IF_IDWrite = 1'b1;
				PCWrite    = 1'b1;
				CtrlWrite  = 1'b1;
			end
			
		//// HazardDetection for branches
		else if(EX_MEM_BranchDetected == 1)
		begin 
			ID_EXWrite = 1'b1;
			IF_IDWrite = 1'b1;
			PCWrite    = 1'b0;
			CtrlWrite  = 1'b1;
		end
		/// JMP dtected
		else if(JMP)
		begin 
			ID_EXWrite = 1'b1;
			IF_IDWrite = 1'b1;
			PCWrite    = 1'b0;
			CtrlWrite  = 1'b1;
		end			
		//JAL
		else if(JAL)
		begin 
			ID_EXWrite = 1'b1;
			IF_IDWrite = 1'b1;
			PCWrite    = 1'b0;
			CtrlWrite  = 1'b1;
		end
		//JR
		else if(JR)
		begin 
			ID_EXWrite = 1'b1;
			IF_IDWrite = 1'b0;
			PCWrite    = 1'b0;
			CtrlWrite  = 1'b1;
		end		
		else
		begin
			ID_EXWrite = 1'b0;
			IF_IDWrite = 1'b0;
			PCWrite    = 1'b0;
			CtrlWrite  = 1'b0;		
		end 
	end
endmodule 


module PipeEXMEM
(
	input clk,
	input reset,
	input [31:0] AluResultIn,
	input [31:0] ReadData2In,
	input JumpIn,
	input [4:0] WriteBackAddresIn,
	input [31:0] AddForBranchingIn,
	input ZeroIn,
	input NotZeroIn,
	input branchSelectorIn,
	input BranchNEIn,
	input BranchEQIn,
	input MemRead_toRAMIn,
	input MemtoReg_MUXIn,
	input MemWrite_toRAMIn,
	input RegWrite_wireIn,
   input [4:0] RegisterRTIN,
	output reg [4:0] RegisterRTOUT,
	output reg [31:0] AluResultOut,
	output reg [31:0] ReadData2Out,
	output reg [4:0] WriteBackAddresOut,
	output reg [31:0] AddForBranchingOut,
	output reg JumpOut,
	output reg ZeroOut,
	output reg NotZeroOut,
	output reg branchSelectorOut,
	output reg BranchNEOut,
	output reg BranchEQOut,
	output reg MemRead_toRAMOut,
	output reg MemtoReg_MUXOut,
	output reg MemWrite_toRAMOut,
	output reg RegWrite_wireOut
);


always@(negedge reset or negedge clk) 
begin
	if(reset==0)
		begin
			AddForBranchingOut <= 0;
			AluResultOut <= 0;
			ReadData2Out <= 0;
			WriteBackAddresOut <= 0;
			JumpOut <= 0;
			ZeroOut <= 0;
			NotZeroOut <= 0;
			branchSelectorOut <= 0;
			BranchNEOut <= 0;
			BranchEQOut <= 0;
			MemRead_toRAMOut <= 0;
			MemtoReg_MUXOut <= 0;
			MemWrite_toRAMOut <= 0;
			RegWrite_wireOut <= 0;
			RegisterRTOUT <= 0;
		end
	else	
		begin
			RegisterRTOUT <= RegisterRTIN;
			AddForBranchingOut <= AddForBranchingIn;
			AluResultOut <= AluResultIn;
			ReadData2Out <= ReadData2In;
			WriteBackAddresOut <= WriteBackAddresIn;
			JumpOut <= JumpIn;
			ZeroOut <= ZeroIn;
			NotZeroOut <= NotZeroIn;
			branchSelectorOut <= branchSelectorIn;
			BranchNEOut <= BranchNEIn;
			BranchEQOut <= BranchEQIn;
			MemRead_toRAMOut <= MemRead_toRAMIn;
			MemtoReg_MUXOut <= MemtoReg_MUXIn;
			MemWrite_toRAMOut <= MemWrite_toRAMIn;
			RegWrite_wireOut <= RegWrite_wireIn;
		end			
end
endmodule
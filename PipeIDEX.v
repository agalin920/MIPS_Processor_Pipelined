
module PipeIDEX
(
	input clk,
	input reset,
	input stall,
	input [31:0] instructionIn,
	input [31:0] ReadData1In,
	input [31:0] ReadData2In,
	input [4:0] WriteBackAddresIn,
	input [31:0] ImmediateExtendIn,
	input [31:0] PC_4_In,
	input [31:0] PCIn,
	input BranchNEIn,
	input BranchEQIn,
	input MemRead_toRAMIn,
	input MemtoReg_MUXIn,
	input MemWrite_toRAMIn,
	input [3:0] ALUOp_wireIn,
	input ALUSrc_wireIn,
	input RegWrite_wireIn,
	input JumpIn,

	output reg [31:0] instructionOut,
	output reg [31:0] ReadData1Out,
	output reg [31:0] ReadData2Out,
	output reg [31:0] ImmediateExtendOut,
	output reg [4:0] WriteBackAddresOut,
	output reg [31:0] PC_4_Out,
	output reg [31:0] PCOut,
	output reg BranchNEOut,
	output reg BranchEQOut,
	output reg MemRead_toRAMOut,
	output reg MemtoReg_MUXOut,
	output reg MemWrite_toRAMOut,
	output reg [3:0] ALUOp_wireOut,
	output reg ALUSrc_wireOut,
	output reg RegWrite_wireOut,
	output reg JumpOut
);


always@(negedge reset or negedge clk) 
begin
	if(reset==0)
		begin
			instructionOut <= 0;
			ReadData1Out <= 0;
			ReadData2Out <= 0;
			ImmediateExtendOut <= 0;
			WriteBackAddresOut <= 0;
			JumpOut <= 0;
			PC_4_Out <= 0;
			PCOut <= 0;
			BranchNEOut <= 0;
			BranchEQOut <= 0;
			MemRead_toRAMOut <= 0;
			MemtoReg_MUXOut <= 0;
			MemWrite_toRAMOut <= 0;
			ALUOp_wireOut <= 0;
			ALUSrc_wireOut <= 0;
			RegWrite_wireOut <= 0;
		end
	else if(stall == 1)
	begin
		instructionOut <= 0;
		ReadData1Out <= 0;
		ReadData2Out <= 0;
		ImmediateExtendOut <= 0;
		WriteBackAddresOut <= 0;
		JumpOut <= 0;
		PC_4_Out <= 0;
		PCOut <= 0;
		BranchNEOut <= 0;
		BranchEQOut <= 0;
		MemRead_toRAMOut <= 0;
		MemtoReg_MUXOut <= 0;
		MemWrite_toRAMOut <= 0;
		ALUOp_wireOut <= 0;
		ALUSrc_wireOut <= 0;
		RegWrite_wireOut <= 0;
	end
	else	
		begin

			instructionOut <= instructionIn;
			ReadData1Out <= ReadData1In;
			ReadData2Out <= ReadData2In;
			ImmediateExtendOut <= ImmediateExtendIn;
			WriteBackAddresOut <= WriteBackAddresIn;
			JumpOut <= JumpIn;
			PC_4_Out <= PC_4_In;
			PCOut <= PCIn; 
			BranchNEOut <= BranchNEIn;
			BranchEQOut <= BranchEQIn;
			MemRead_toRAMOut <= MemRead_toRAMIn;
			MemtoReg_MUXOut <= MemtoReg_MUXIn;
			MemWrite_toRAMOut <= MemWrite_toRAMIn;
			ALUOp_wireOut <= ALUOp_wireIn;
			ALUSrc_wireOut <= ALUSrc_wireIn;
			RegWrite_wireOut <= RegWrite_wireIn;
		end	
end
endmodule
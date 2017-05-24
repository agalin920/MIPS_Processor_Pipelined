

module PipeMEMWB
(
	input clk,
	input reset,
	input [31:0] AluResultIn,
	input [31:0] ReadDataMemIn,
	input JumpIn,
	input [4:0] WriteBackAddresIn,
	input MemtoReg_MUXIn,
	input RegWrite_wireIn,
   input [4:0] RegisterRTIN,
	input MemReadIN,
	
	output reg MemReadOUT,
	output reg [4:0] RegisterRTOUT,
	output reg [31:0] AluResultOut,
	output reg [31:0] ReadDataMemOut,
	output reg [4:0] WriteBackAddresOut,
	output reg JumpOut,
	output reg MemtoReg_MUXOut,
	output reg RegWrite_wireOut
);


always@(negedge reset or negedge clk) 
begin
	if(reset==0)
		begin
			AluResultOut <= 0;
			ReadDataMemOut <= 0;
			WriteBackAddresOut <= 0;
			JumpOut <= 0;
			MemtoReg_MUXOut <= 0;
			RegWrite_wireOut <= 0;
			MemReadOUT <= 0;
			RegisterRTOUT <= 0;
		end
	else	
		begin
			MemReadOUT <= MemReadIN;
			RegisterRTOUT <= RegisterRTIN;
			AluResultOut <= AluResultIn;
			ReadDataMemOut <= ReadDataMemIn;
			WriteBackAddresOut <= WriteBackAddresIn;
			JumpOut <= JumpIn;
			MemtoReg_MUXOut <= MemtoReg_MUXIn;
			RegWrite_wireOut <= RegWrite_wireIn;
		end			
end

endmodule

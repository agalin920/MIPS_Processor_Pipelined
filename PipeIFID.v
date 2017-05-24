

module PipeIFID 
(
	input clk,
	input reset,
	input stall,
	input [31:0] instructionIn,
	input [31:0] PCIn,
	input [31:0] PcAddIn,

	output reg [31:0] instructionOut,
	output reg [31:0] PCOut,
	output reg [31:0] PcAddOut	
);


always@(negedge reset or negedge clk) 
begin
	if(reset==0)
		begin
			instructionOut <= 0;
			PCOut <= 0;
			PcAddOut <= 0;
		end
	else if(stall == 1)
	begin
		instructionOut <= 0;
		PCOut <= 0;
		PcAddOut <= 0;
	end
	else	
		begin
			instructionOut <= instructionIn;
			PCOut <= PCIn;
			PcAddOut <= PcAddIn;
		end			
end
endmodule
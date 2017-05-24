module Multiplexer4to1 #(parameter NBits=32)
(
	input [1:0] Selector,
	input [NBits-1:0] MUX_Data0,
	input [NBits-1:0] MUX_Data1,
	input [NBits-1:0] MUX_Data2,
	input [NBits-1:0] MUX_Data3,
	output reg [NBits-1:0] MUX_Output
);


	always@(*) 
		begin
			if(Selector == 2'b11)
				MUX_Output = MUX_Data3;
			else if(Selector == 2'b10)
				MUX_Output = MUX_Data2;
			else if(Selector == 2'b01)
				MUX_Output = MUX_Data1;
			else 
				MUX_Output = MUX_Data0;
		end

endmodule
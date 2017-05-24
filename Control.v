/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. JosÃ© Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output Jump,
	output [3:0]ALUOp
);

localparam R_Type = 0;
localparam I_Type_ADDI = 6'h08;
localparam I_Type_ORI  = 6'h0d;
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c;
localparam I_Type_BEQ  = 6'h04;
localparam I_Type_BNE  = 6'h05;
localparam J_Type_J    = 6'h02;
localparam J_Type_JAL  = 6'h03;
localparam SW 			  = 6'h2b;
localparam LW          = 6'h23;

reg [12:0] ControlValues;

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues = 13'b01_001_00_00_0111; //7
		I_Type_ADDI:  ControlValues = 13'b00_101_00_00_0100; // 4
		I_Type_ORI:   ControlValues = 13'b00_101_00_00_0101; // 5
		I_Type_LUI:   ControlValues = 13'b00_101_00_00_0010;// 2
		I_Type_ANDI:  ControlValues = 13'b00_101_00_00_0011;// 3
		I_Type_BEQ:	  ControlValues = 13'b00_000_00_01_0001;// 1
		I_Type_BNE:	  ControlValues = 13'b00_000_00_10_0001;// 1
		J_Type_J:	  ControlValues = 13'b10_000_00_00_0000;// 0
		J_Type_JAL:	  ControlValues = 13'b10_001_00_00_0110;// 6
		
		LW:			  ControlValues = 13'b00_111_10_00_1000;// 8
	
		SW:			  ControlValues = 13'b00_000_01_00_1001;// 9
		default:
			ControlValues = 12'b000_000_000_000;
		endcase
end	

assign Jump     = ControlValues[12];
assign RegDst   = ControlValues[11];
assign ALUSrc   = ControlValues[10];
assign MemtoReg = ControlValues[9];
assign RegWrite = ControlValues[8];
assign MemRead  = ControlValues[7];
assign MemWrite = ControlValues[6];
assign BranchNE = ControlValues[5];
assign BranchEQ = ControlValues[4];
assign ALUOp    = ControlValues[3:0];	

endmodule

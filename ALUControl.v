/******************************************************************
* Description
*	This is the control unit for the ALU. It receves an signal called 
*	ALUOp from the control unit and a signal called ALUFunction from
*	the intrctuion field named function.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module ALUControl
(
	input [3:0] ALUOp,
	input [5:0] ALUFunction,
	output [3:0] ALUOperation
);

localparam R_Type_JR		 = 10'b0111_001000;
localparam R_Type_AND    = 10'b0111_100100;
localparam R_Type_OR     = 10'b0111_100101;
localparam R_Type_NOR    = 10'b0111_100111;
localparam R_Type_ADD    = 10'b0111_100000;
localparam R_Type_SLL    = 10'b0111_000000;
localparam R_Type_SRL    = 10'b0111_000010;
localparam R_Type_SUB    = 10'b0111_100010;
localparam I_Type_ADDI   = 10'b0100_xxxxxx;
localparam I_Type_ORI    = 10'b0101_xxxxxx;
localparam I_Type_LUI    = 10'b0010_xxxxxx;
localparam I_Type_ANDI	 = 10'b0011_xxxxxx;
localparam BEQ_AND_BNE   = 10'b0001_xxxxxx;
localparam J_Type_JAL	 = 10'b0110_xxxxxx;

localparam LW				 = 10'b1000_xxxxxx;
localparam SW				 = 10'b1001_xxxxxx;
reg [3:0] ALUControlValues;
wire [9:0] Selector;

assign Selector = {ALUOp,ALUFunction};

always@(Selector)begin
	casex(Selector)
		R_Type_AND:    ALUControlValues = 4'b0000;//0
		R_Type_OR: 		ALUControlValues = 4'b0001;//1
		R_Type_NOR:    ALUControlValues = 4'b0010;//2
		R_Type_ADD:    ALUControlValues = 4'b0011;//3
		R_Type_SUB:		ALUControlValues = 4'b0100;//4
		R_Type_SLL:    ALUControlValues = 4'b0101;//5
		R_Type_SRL:    ALUControlValues = 4'b0110;//6
		I_Type_ADDI:   ALUControlValues = 4'b0011;//3
		I_Type_ORI:    ALUControlValues = 4'b0001;//1
		I_Type_LUI:    ALUControlValues = 4'b0111;//7
		BEQ_AND_BNE:   ALUControlValues = 4'b0100; //4
		J_Type_JAL:    ALUControlValues = 4'b1001;//9 
		R_Type_JR:		ALUControlValues = 4'b1010;//10
		LW:				ALUControlValues = 4'b1011;//11
		SW:				ALUControlValues = 4'b1100;//12
		default: 		ALUControlValues = 4'b1111;//15
	endcase
end

assign ALUOperation = ALUControlValues;

endmodule

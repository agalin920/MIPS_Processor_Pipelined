/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. JosÃ© Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module ALU 
(
	input [3:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	input [4:0] Shamt,
	input [31:0] ProgramCounter,
	input signed [15:0] bitLocForLoadAndSave,
	output reg Zero,
	output reg NotZero,
	output reg JReg,
	output reg [31:0]ALUResult
);


localparam AND = 4'b0000; // 0
localparam OR  = 4'b0001; // 1
localparam NOR = 4'b0010; // 2
localparam ADD = 4'b0011; // 3
localparam SUB = 4'b0100; // 4
localparam SLL = 4'b0101; // 5
localparam SRL = 4'b0110; // 6
localparam LUI = 4'b0111; // 7
localparam JAL = 4'b1001; // 9
localparam JR  = 4'b1010; // 10
localparam LW  = 4'b1011; //11
localparam SW  = 4'b1100; //12

wire [31:0] tempA = A + (bitLocForLoadAndSave);
   always @ (A or B or ALUOperation,Shamt,ProgramCounter,bitLocForLoadAndSave,tempA)
     begin
		case (ALUOperation)
		  ADD: // add
			ALUResult = A + B;
		  SUB: // sub
			ALUResult = A - B;
		  AND: // and
			ALUResult = A & B;
		  OR: // or
			ALUResult = A | B;
		  NOR: // nor
			ALUResult = ~(A|B);
		  SLL: // shift left
			ALUResult=  B << Shamt;
		  SRL: // shift right
			ALUResult=  B >> Shamt;
		  LUI: // load upper immediate
			ALUResult= B << 16;
		  JAL: // jump and link
			ALUResult = ProgramCounter;
		  LW:begin
			ALUResult = {16'b0000_0000_0000_0000_0000, tempA[11:0]};
		  end
		  SW:begin
			ALUResult = {16'b0000_0000_0000_0000_0000, tempA[11:0]};
		  end
		default:begin
			ALUResult = 0;
			
			end
		endcase // case(control)
		Zero = (ALUResult == 0) ? 1'b1 : 1'b0;
		NotZero= (ALUResult == 0) ? 1'b0 : 1'b1;
	  end
	  always@(JReg or ALUOperation)
	  begin
	  if(JR == ALUOperation) 
			JReg = 1;
	  else JReg = 0;
	  end
endmodule 
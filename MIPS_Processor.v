/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2016
******************************************************************/

module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 128
)
(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
//******************************************************************/
assign  PortOut = 0;
//******************************************************************/
//******************************************************************/
// Data types to connect modules

//**********PIPE LINE WIRES************
//******PIPE LINE IF-ID
wire [31:0] IF_ID_INSTRUCTION_IN;
wire [31:0] IF_ID_PcIn;
wire [31:0] IF_ID_AddIn;

wire [31:0] IF_ID_INSTRUCTION_OUT;
wire [31:0] IF_ID_PcOut;
wire [31:0] IF_ID_PcAddOut;

//******PIPELINE ID-EX
			//INPUT 
wire [31:0] ID_EX_INSTRUCTION_IN;
wire [31:0] ID_EX_READ_DATA1_IN;
wire [31:0] ID_EX_READ_DATA2_IN;
wire [31:0] ID_EX_Immediate_IN;
wire [4:0] ID_EX_WriteBackAddress_IN;
wire ID_EX_Jump_IN;
wire [31:0] IDEX_PC_4_IN; 
wire [3:0] ID_EX_ALUOp_IN;
wire ID_EX_BranchEQ_IN;
wire ID_EX_BranchNE_IN;
wire ID_EX_MemRead_toRAMIn;
wire ID_EX_MemtoReg_MUXIn;
wire ID_EX_MemWrite_toRAMIn;
wire ID_EX_ALUSrc_In;
wire ID_EX_RegWrite_wireIn;
			//OUTPUT 
wire [31:0] ID_EX_INSTRUCTION_OUT;
wire [31:0] ID_EX_READ_DATA1_OUT;
wire [31:0] ID_EX_READ_DATA2_OUT;
wire [31:0] ID_EX_Immediate_OUT;
wire [31:0] ID_EX_PC_4_OUT;
wire [31:0] ID_EX_PC_OUT;
wire [4:0] ID_EX_WriteBackAddress_OUT;
wire ID_EX_Jump_OUT;
wire [3:0] ID_EX_ALUOp_Out;
wire ID_EX_BranchEQ_Out;
wire ID_EX_BranchNE_Out;
wire ID_EX_MemRead_toRAMOut;
wire ID_EX_MemtoReg_MUXOut;
wire ID_EX_MemWrite_toRAMOut;
wire ID_EX_ALUSrc_Out;
wire ID_EX_RegWrite_wireOut;

//********PIPELINE EX-MEM
	//INPUT
	//Zero_wire
wire [31:0] EX_MEM_ALURESULT_IN;
wire [31:0] EX_MEM_ReadData2_IN;
wire [4:0] EX_MEM_WriteBackAddress_IN;
wire EX_MEM_Jump_IN;
wire EX_MEM_ZeroWire_IN;
wire EX_MEM_NotZeroWire_IN;
wire EX_MEM_branchSelector_IN;
wire EX_MEM_BranchNE_IN;
wire EX_MEM_BranchEQ_IN;
wire EX_MEM_MemToReg_IN;
wire EX_MEM_RegWrite_IN;
wire EX_MEM_MemWrite_IN;
wire EX_MEM_MemRead_IN;
	//OUTPUT
wire [31:0] EX_MEM_ALURESULT_OUT;
wire [31:0] EX_MEM_ReadData2_Out;
wire [4:0] EX_MEM_WriteBackAddress_OUT;
wire [4:0] EX_MEM_RegisterRTOUT;
wire EX_MEM_Jump_OUT;
wire EX_MEM_ZeroWire_OUT;
wire EX_MEM_NotZeroWire_OUT;
wire EX_MEM_branchSelector_OUT;
wire EX_MEM_BranchNE_OUT;
wire EX_MEM_BranchEQ_OUT;
wire EX_MEM_MemToReg_OUT;
wire EX_MEM_RegWrite_OUT;
wire EX_MEM_MemWrite_OUT;
wire EX_MEM_MemRead_OUT;

//PIPELINE MEM-WB
	//INPUT 
wire MEM_WB_MemToReg_IN;
wire MEM_WB_RegWrite_IN;
wire [31:0] MEM_WB_ALUResult_IN;
wire [31:0] MEM_WB_ReadDataMem_IN;//.
wire [4:0] MEM_WB_WriteBackAddress_IN;
wire MEM_WB_Jump_IN;
	//OUTPUT
wire MEM_WB_MemToReg_OUT;
wire MEM_WB_RegWrite_OUT;
wire [4:0] MEM_WB_WriteBackAddress_OUT;
wire MEM_WB_Jump_OUT;
wire [31:0] MEM_WB_ALUResult_OUT;
wire [31:0] MEM_WB_ReadDataMem_OUT;//.


wire [31:0] Mux_to_ALU_Input_2_wire;
wire [31:0] Mux_to_ALU_Input_1_wire;
wire [1:0] ForwardA_wire;
wire [1:0] ForwardB_wire;
wire [4:0] MEM_WB_RegisterRT;
wire MEM_WB_MemRead;

wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire NotZeroAndBranchNE;
wire ZeroAndBranchEQ;
wire OrForBranch;
wire ALUSrc_wire;
wire RegWrite_wire;
wire Zero_wire;
wire NotZero_wire;
wire Jump_wire;
wire JReg_wire;

wire [3:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [4:0] WriteRegister_wire;
wire [31:0] WriteRegister_wire2;
wire [31:0] WriteBackRegister_wire;
wire [31:0] PC_wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] ImmediateExtend_wire;
wire [31:0] ImmediateExtendAndShifted_wire;

wire [31:0] ReadData2OrImmediate_wire;
wire [31:0] RamWriteWire;
wire [31:0] ALUResult_wire;
wire [31:0] PC_4_wire;
wire [31:0] PC_Branch_wire;
wire [31:0] EX_MEM_PC_Branch_wire2;

wire [31:0] MUX_ProgramCounter_wire;
wire [31:0] MUX_ProgramCounter_wire2;
wire [31:0] MUX_JR_wire;
wire [31:0] JumpShift_wire;
wire [31:0] MUX_OrForBranch_wire;
wire [4:0] MUX_ForRAndI_Type_wire;
wire  MemRead_toRAM;
wire  MemWrite_toRAM;
wire  MemtoReg_MUX;
wire[31:0] ReadDatatoMux;

wire IF_IDResetFromHazard;
wire ID_EXResetFromHazard;
wire PCWriteFromHazard;
wire ForwardC_wire;
integer ALUStatus;
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//////PIpELINE

PipeIFID
IFID
(
	.clk(clk),
	.reset(reset),
	.stall(IF_IDResetFromHazard),
	.instructionIn(Instruction_wire),
	.PCIn(PC_wire),
	.PcAddIn(PC_4_wire),

	.instructionOut(IF_ID_INSTRUCTION_OUT),
	.PCOut(IF_ID_PcOut),
	.PcAddOut(IF_ID_PcAddOut)	
);

PipeIDEX
IDEX 
(
	.clk(clk),
	.reset(reset),
	.stall(ID_EXResetFromHazard),
	.instructionIn(IF_ID_INSTRUCTION_OUT),
	.ReadData1In(ReadData1_wire),
	.ReadData2In(ReadData2_wire),
	.ImmediateExtendIn(ImmediateExtend_wire),
	.PC_4_In(IF_ID_PcAddOut),
	.PCIn(IF_ID_PcOut),
	.BranchNEIn(BranchNE_wire),
	.BranchEQIn(BranchEQ_wire),
	.MemRead_toRAMIn(MemRead_toRAM),
	.MemtoReg_MUXIn(MemtoReg_MUX),
	.MemWrite_toRAMIn(MemWrite_toRAM),
	.ALUOp_wireIn(ALUOp_wire),
	.ALUSrc_wireIn(ALUSrc_wire),
	.RegWrite_wireIn(RegWrite_wire),
	.WriteBackAddresIn(MUX_ForRAndI_Type_wire),
	.JumpIn(Jump_wire),

	.instructionOut(ID_EX_INSTRUCTION_OUT),
	.ReadData1Out(ID_EX_READ_DATA1_OUT),
	.ReadData2Out(ID_EX_READ_DATA2_OUT),
	.ImmediateExtendOut(ID_EX_Immediate_OUT),
	.PC_4_Out(ID_EX_PC_4_OUT),
	.PCOut(ID_EX_PC_OUT),
	.BranchNEOut(ID_EX_BranchNE_Out),
	.BranchEQOut(ID_EX_BranchEQ_Out),
	.MemRead_toRAMOut(ID_EX_MemRead_toRAMOut),
	.MemtoReg_MUXOut(ID_EX_MemtoReg_MUXOut),
	.MemWrite_toRAMOut(ID_EX_MemWrite_toRAMOut),
	.ALUOp_wireOut(ID_EX_ALUOp_Out),
	.ALUSrc_wireOut(ID_EX_ALUSrc_Out),
	.RegWrite_wireOut(ID_EX_RegWrite_wireOut),
	.WriteBackAddresOut(ID_EX_WriteBackAddress_OUT),
	.JumpOut(ID_EX_Jump_OUT)
);

PipeEXMEM
EXMEM
(
	.clk(clk),
	.reset(reset),
	.AluResultIn(ALUResult_wire),
	.ReadData2In(RamWriteWire),
	.ZeroIn(Zero_wire),
	.NotZeroIn(NotZero_wire),
	.AddForBranchingIn(PC_Branch_wire),
	.branchSelectorIn(ID_EX_INSTRUCTION_OUT[26]),
	.BranchNEIn(ID_EX_BranchNE_Out),
	.BranchEQIn(ID_EX_BranchEQ_Out),
	.MemRead_toRAMIn(ID_EX_MemRead_toRAMOut),
	.MemtoReg_MUXIn(ID_EX_MemtoReg_MUXOut),
	.MemWrite_toRAMIn(ID_EX_MemWrite_toRAMOut),
	.RegWrite_wireIn(ID_EX_RegWrite_wireOut),
	.WriteBackAddresIn(ID_EX_WriteBackAddress_OUT),
	.JumpIn(ID_EX_Jump_OUT),
	.RegisterRTIN(ID_EX_INSTRUCTION_OUT[20:16]),
	.RegisterRTOUT(EX_MEM_RegisterRTOUT),
	.AluResultOut(EX_MEM_ALURESULT_OUT),
	.ReadData2Out(EX_MEM_ReadData2_Out),
	.ZeroOut(EX_MEM_ZeroWire_OUT),
	.NotZeroOut(EX_MEM_NotZeroWire_OUT),
	.AddForBranchingOut(EX_MEM_PC_Branch_wire2),
	.branchSelectorOut(EX_MEM_branchSelector_OUT),
	.BranchNEOut(EX_MEM_BranchNE_OUT),
	.BranchEQOut(EX_MEM_BranchEQ_OUT),
	.MemRead_toRAMOut(EX_MEM_MemRead_OUT),
	.MemtoReg_MUXOut(EX_MEM_MemToReg_OUT),
	.MemWrite_toRAMOut(EX_MEM_MemWrite_OUT),
	.RegWrite_wireOut(EX_MEM_RegWrite_OUT),
	.WriteBackAddresOut(EX_MEM_WriteBackAddress_OUT),
	.JumpOut(EX_MEM_Jump_OUT)
);

PipeMEMWB
MEMWB
(
	.clk(clk),
	.reset(reset),
	.AluResultIn(EX_MEM_ALURESULT_OUT),
	.ReadDataMemIn(ReadDatatoMux),
	.MemtoReg_MUXIn(EX_MEM_MemToReg_OUT),
	.RegWrite_wireIn(EX_MEM_RegWrite_OUT),
	.WriteBackAddresIn(EX_MEM_WriteBackAddress_OUT),
	.JumpIn(EX_MEM_Jump_OUT),
	.RegisterRTIN(EX_MEM_RegisterRTOUT),
	.MemReadIN(EX_MEM_MemRead_OUT),
	
	.AluResultOut(MEM_WB_ALUResult_OUT),
	.ReadDataMemOut(MEM_WB_ReadDataMem_OUT),
	
	.MemtoReg_MUXOut(MEM_WB_MemToReg_OUT),
	.RegWrite_wireOut(MEM_WB_RegWrite_OUT),
	.WriteBackAddresOut(MEM_WB_WriteBackAddress_OUT),
	.RegisterRTOUT(MEM_WB_RegisterRT),
	.MemReadOUT(MEM_WB_MemRead),
	.JumpOut(MEM_WB_Jump_OUT)
);


///uni-cycle

Control
ControlUnit
(
	.OP(IF_ID_INSTRUCTION_OUT[31:26]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.MemRead(MemRead_toRAM),
	.MemtoReg(MemtoReg_MUX),
	.MemWrite(MemWrite_toRAM),
	.ALUOp(ALUOp_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	.Jump(Jump_wire)
);

PC_Register
ProgramCounter
(
		.clk(clk),
		.reset(reset),
		.PCWrite(PCWriteFromHazard),
		.NewPC(MUX_OrForBranch_wire),
		.PCValue(PC_wire)
);	

ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire)
);

Adder32bits
PC_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC_4_wire)
);

// Cambio
ShiftLeft2
Shifter 
(   
	.DataInput(ID_EX_Immediate_OUT),
   .DataOutput(ImmediateExtendAndShifted_wire)
);
// Cambio
ShiftLeft2
Shifter_Jump 
(   
	.DataInput({6'b000000,IF_ID_INSTRUCTION_OUT[25:0]}),
   .DataOutput(JumpShift_wire)

);
// Cambio
Adder32bits
For_Branching
(
	.Data0(ID_EX_PC_4_OUT),
	.Data1(ImmediateExtendAndShifted_wire),
	
	.Result(PC_Branch_wire)
);

ANDGate
And_Gate_BEQ
(
	.A(EX_MEM_ZeroWire_OUT),
	.B(EX_MEM_BranchEQ_OUT),
	.C(ZeroAndBranchEQ)
);

ANDGate
And_Gate_BNE
(
	.A(EX_MEM_NotZeroWire_OUT),
	.B(EX_MEM_BranchNE_OUT),
	.C(NotZeroAndBranchNE)
);

Multiplexer2to1
#(
	.NBits(1)
)
MUX_Branch
(
	.Selector(EX_MEM_branchSelector_OUT),
	.MUX_Data0(ZeroAndBranchEQ),
	.MUX_Data1(NotZeroAndBranchNE),
	
	.MUX_Output(OrForBranch)
);

Multiplexer2to1
#(
	.NBits(32)
)

MUX_Jump
(
	.Selector(Jump_wire),
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(({PC_wire[31:28],JumpShift_wire[27:0]}) + 4),
	
	.MUX_Output(MUX_JR_wire)

);
Multiplexer2to1
#(
	.NBits(32)
)
MUX_JR2
(
	.Selector(ForwardA_wire[0]),
	.MUX_Data0(ID_EX_READ_DATA1_OUT),
	.MUX_Data1(Mux_to_ALU_Input_1_wire),
	
	.MUX_Output(MUX_ProgramCounter_wire2)

);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_JR
(
	.Selector(JReg_wire),
	.MUX_Data0(MUX_JR_wire),
	.MUX_Data1(MUX_ProgramCounter_wire2 + 4),
	
	.MUX_Output(MUX_ProgramCounter_wire)

);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_PC
(
	.Selector(OrForBranch),
	.MUX_Data0(MUX_ProgramCounter_wire),
	.MUX_Data1(EX_MEM_PC_Branch_wire2 - 4),
	
	.MUX_Output(MUX_OrForBranch_wire)

);

HazardDetection Hazardetection(
	.ID_EX_MemRead(ID_EX_MemRead_toRAMOut),
	.EX_MEM_BranchDetected(OrForBranch),
	.JMP(),
	.JAL(),
	.JR(JReg_wire),
	.ID_EX_RegisterRt(ID_EX_INSTRUCTION_OUT[20:16]),
	.IF_ID_RegisterRt(IF_ID_INSTRUCTION_OUT[20:16]),
	.IF_ID_RegisterRs(IF_ID_INSTRUCTION_OUT[25:21]),
	.PCWrite(PCWriteFromHazard),
	.IF_IDWrite(IF_IDResetFromHazard),
	.ID_EXWrite(ID_EXResetFromHazard),
	.CtrlWrite()
	 
);

// Cambio
Multiplexer2to1
#(
	.NBits(5)
)
MUX_R_I_Type
(
	.Selector(RegDst_wire),
	.MUX_Data0(IF_ID_INSTRUCTION_OUT[20:16]),
	.MUX_Data1(IF_ID_INSTRUCTION_OUT[15:11]),
	
	.MUX_Output(MUX_ForRAndI_Type_wire)

);

RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(MEM_WB_RegWrite_OUT),
	.WriteRegister(WriteRegister_wire),
	.ReadRegister1(IF_ID_INSTRUCTION_OUT[25:21]),
	.ReadRegister2(IF_ID_INSTRUCTION_OUT[20:16]),
	.WriteData(WriteRegister_wire2),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)
);

SignExtend
SignExtendForConstants
(   
	.DataInput(IF_ID_INSTRUCTION_OUT[15:0]),
   .SignExtendOutput(ImmediateExtend_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndImmediate
(
	.Selector(ID_EX_ALUSrc_Out),
	.MUX_Data0(Mux_to_ALU_Input_2_wire),
	.MUX_Data1(ID_EX_Immediate_OUT),
	
	.MUX_Output(ReadData2OrImmediate_wire)

);
// Cambio
Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReturnAddress
(
	.Selector(MEM_WB_Jump_OUT),
	.MUX_Data0(MEM_WB_WriteBackAddress_OUT),
	.MUX_Data1(31),  
	
	.MUX_Output(WriteRegister_wire)

);



ForwardingUnit Forwarder(
	.EX_MEM_RegisterRD(EX_MEM_WriteBackAddress_OUT),
	.MEM_WB_RegisterRD(MEM_WB_WriteBackAddress_OUT),
	.EX_MEM_MemRead(EX_MEM_MemRead_OUT),
	.EX_MEM_RegisterRT(ID_EX_INSTRUCTION_OUT[20:16]),
	.ID_EX_MemWrite(ID_EX_MemWrite_toRAMOut),
	.ID_EX_RegisterRS(ID_EX_INSTRUCTION_OUT[25:21]),
	.ID_EX_RegisterRT(ID_EX_INSTRUCTION_OUT[20:16]),
	.JMP(ID_EX_BranchNE_Out | ID_EX_BranchEQ_Out),
	.EX_MEM_RegWrite(EX_MEM_RegWrite_OUT),
	.MEM_WB_RegisterRT(MEM_WB_RegisterRT),
	.MEM_WB_MemRead(MEM_WB_MemRead),
	.MEM_WB_RegWrite(MEM_WB_RegWrite_OUT),
	.ForwardA(ForwardA_wire),
	.ForwardB(ForwardB_wire),
	.ForwardC(ForwardC_wire)
);

// -------------------------------------------------------------------
//
// 4 TO 1 MUX FOR FORWARDING UNIT AND ALU INPUT 1:
//
//

Multiplexer4to1 #(.NBits(32)) Mux_Input_ALU_1(
	.Selector(ForwardA_wire),
	.MUX_Data0(ID_EX_READ_DATA1_OUT),
	.MUX_Data1(WriteRegister_wire2),
	.MUX_Data2(EX_MEM_ALURESULT_OUT),
	.MUX_Data3(0),
	.MUX_Output(Mux_to_ALU_Input_1_wire)
);

// -------------------------------------------------------------------
//
// 4 TO 1 MUX FOR FORWARDING UNIT AND ALU INPUT 2:
//
//

Multiplexer4to1 #(.NBits(32)) Mux_Input_ALU_2(
	.Selector(ForwardB_wire),
	.MUX_Data0(ID_EX_READ_DATA2_OUT),
	.MUX_Data1(WriteRegister_wire2),
	.MUX_Data2(EX_MEM_ALURESULT_OUT),
	.MUX_Data3(0),
	.MUX_Output(Mux_to_ALU_Input_2_wire)
);

// 
ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ID_EX_ALUOp_Out),
	.ALUFunction(ID_EX_INSTRUCTION_OUT[5:0]),
	.ALUOperation(ALUOperation_wire)
);

ALU
ArithmeticLogicUnit 
(
	.ALUOperation(ALUOperation_wire),
	.A(Mux_to_ALU_Input_1_wire),
	.B(ReadData2OrImmediate_wire),
	.bitLocForLoadAndSave(ID_EX_INSTRUCTION_OUT[15:0]),
	.Shamt(ID_EX_INSTRUCTION_OUT[10:6]),
	.ProgramCounter(ID_EX_PC_OUT),
	.Zero(Zero_wire),
	.NotZero(NotZero_wire),
	.ALUResult(ALUResult_wire),
	.JReg(JReg_wire)
);
Multiplexer2to1
#(
	.NBits(32)
)
MUX_RAMWrite
(
	.Selector(ForwardC_wire),
	.MUX_Data0(ID_EX_READ_DATA2_OUT), // IDEX
	.MUX_Data1(WriteRegister_wire2),   //WB
	
	.MUX_Output(RamWriteWire)

);

DataMemory 
#(	
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(1024)

)
PROGRAM_RAM
(
	.WriteData(EX_MEM_ReadData2_Out),
	.Address({20'b0,EX_MEM_ALURESULT_OUT[11:0]>>2}),
	.MemWrite(EX_MEM_MemWrite_OUT),
	.MemRead(EX_MEM_MemRead_OUT), 
	.clk(clk),
	.ReadData(ReadDatatoMux)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_RAM2
(
	.Selector(MEM_WB_MemToReg_OUT),
	.MUX_Data0(MEM_WB_ALUResult_OUT),
	.MUX_Data1(MEM_WB_ReadDataMem_OUT),  
	
	.MUX_Output(WriteRegister_wire2)

);
	
assign ALUResultOut = ALUResult_wire;

endmodule

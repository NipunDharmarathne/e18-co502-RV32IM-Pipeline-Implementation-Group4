`include "../RegisterFile/reg_file.v"
`include "../Sign_Zero_Extend/Sign_Zero_Extend.v"
`include "../ControlUnit/control_unit.v"
`include "../Pipeline_Registers/2_ID_EX/ID_EX_register.v"



module cpu (
    CLK, RESET, PC
);
// port declaration
  input RESET, CLK ; 


wire WRITE_REG, MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP;
wire [31:0] INSTRUCTION, IN_REG, OUT1_REG, OUT2_REG, SIGN_ZERO_EXTEND;
wire [4:0] MEM_WB_INADDRESS, ALUOP;
wire[2:0] MUXIMMTYPE_SELECT;

output reg[31:0] PC;


// initiating modules
reg_file myreg(IN_REG, OUT1_REG, OUT2_REG, MEM_WB_INADDRESS, INSTRUCTION[19:15], INSTRUCTION[24:20], WRITE_REG, CLK, RESET); 
control_unit mycu(INSTRUCTION, ALUOP,  MUXIMMTYPE_SELECT, MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP);
Sign_Zero_Extend signZeroExtend(INSTRUCTION,MUXIMMTYPE_SELECT, SIGN_ZERO_EXTEND );
// ID_EX_register myIDEX(CLK,RESET,WRITE_ENABLE,MUXDATAMEM_SELECT,MEM_READ,MEM_WRITE,MUXJAL_SELECT,ALUOP,MUXIMM_SELECT,MUXPC_SELECT,BRANCH,JUMP,PC_DIRECT_OUT_IN,SIGN_ZERO_EXTEND,PC_PLUS_4_OUT_IN,OUT1_IN,OUT2_IN,RD_IN,FUNCT3_IN,WRITE_ENABLE_OUT,MUXDATAMEM_SELECT_OUT,MEM_READ_OUT,MEM_WRITE_OUT,MUXJAL_SELECT_OUT,ALUOP_OUT,MUXIMM_SELECT_OUT,MUXPC_SELECT_OUT,BRANCH_OUT,JUMP_OUT,PC_DIRECT_OUT_OUT,SIGN_ZERO_EXTEND_OUT,PC_PLUS_4_OUT_OUT,OUT1_OUT,OUT2_OUT,RD_OUT,FUNCT3_OUT,BUSYWAIT);

// IF_ID_register myIFID(CLK,RESET,INSTRUCTION_IN,PC_PLUS_4_IN,PC_DIRECT_IN,	INSTRUCTION_OUT,PC_PLUS_4_OUT,PC_DIRECT_OUT,BUSYWAIT);


// always @ ( posedge CLK ) begin
		
// 		if( RESET )	
// 			PC = 0 ;						// reset the PC
// 		else 
// 		begin
		
// 			PC = #1 PC_NEXT ;
// 		end

// 	end	
endmodule
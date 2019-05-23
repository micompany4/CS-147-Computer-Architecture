// Name: alu.v
// Module: ALU
// Input: OP1[32] - operand 1
//        OP2[32] - operand 2
//        OPRN[6] - operation code
// Output: OUT[32] - output result for the operation
//
// Notes: 32 bit combinatorial ALU
// 
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_rigth (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Oct 19, 2014        Kaushik Patra   kpatra@sjsu.edu         Added ZERO status output
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module ALU(OUT, ZERO, OP1, OP2, OPRN);
// input list
input [`DATA_INDEX_LIMIT:0] OP1; // operand 1
input [`DATA_INDEX_LIMIT:0] OP2; // operand 2
input [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code

// output list
output [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
output ZERO;

//Creates registers for the outputs 
reg [`DATA_INDEX_LIMIT:0] OUT;
reg ZERO;

always @(OP1 or OP2 or OPRN)
begin
	ZERO = 1'b0;	//sets the ZERO register initially to 0

// TBD - Code for the ALU
    case (OPRN)
	
	`ALU_OPRN_WIDTH'h01 : OUT = OP1 + OP2;		//addition
	`ALU_OPRN_WIDTH'h02 : OUT = OP1 - OP2;		//subtraction
	`ALU_OPRN_WIDTH'h03 : OUT = OP1 * OP2;		//multiplication
	`ALU_OPRN_WIDTH'h04 : OUT = OP1 >> OP2;		//right shift
	`ALU_OPRN_WIDTH'h05 : OUT = OP1 << OP2;		//left shift		
	`ALU_OPRN_WIDTH'h06 : OUT = OP1 & OP2; 		//bitwise and
	`ALU_OPRN_WIDTH'h07 : OUT = OP1 | OP2;		//bitwise or
	`ALU_OPRN_WIDTH'h08 : OUT = ~(OP1 | OP2);	//bitwise nor
	`ALU_OPRN_WIDTH'h09 : OUT = OP1 < OP2;		//set less than	
	
	default: OUT = `DATA_WIDTH'hxxxxxxxx;
	
	
    endcase
    //checks if OUT is equal to 0 and sets ZERO to 1 if so
    if (OUT === 0)
	ZERO = 1'b1;

end

endmodule

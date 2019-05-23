// Name: register_file.v
// Module: REGISTER_FILE_32x32
// Input:  DATA_W : Data to be written at address ADDR_W
//         ADDR_W : Address of the memory location to be written
//         ADDR_R1 : Address of the memory location to be read for DATA_R1
//         ADDR_R2 : Address of the memory location to be read for DATA_R2
//         READ    : Read signal
//         WRITE   : Write signal
//         CLK     : Clock signal
//         RST     : Reset signal
// Output: DATA_R1 : Data at ADDR_R1 address
//         DATA_R2 : Data at ADDR_R1 address
//
// Notes: - 32 bit word accessible dual read register file having 32 regsisters.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA_R* if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2, 
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);

// input list
input READ, WRITE, CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_W;
input [`ADDRESS_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;

// output list
output [`DATA_INDEX_LIMIT:0] DATA_R1;
output [`DATA_INDEX_LIMIT:0] DATA_R2;

//registers for outputs 
reg [`DATA_INDEX_LIMIT:0] reg_data_r1;
reg [`DATA_INDEX_LIMIT:0] reg_data_r2;

reg [`DATA_INDEX_LIMIT:0] mem_32x32 [0:`REG_INDEX_LIMIT]; // memory storage
integer i;   //why can't I just declare this inside the for loop? fricking Verilog dude

//read = 1 and write = 0 is the only case where the outputs are changed
//just check if where in this case, if so output = the contents of the register
//if not hold the previously held data as high z
assign DATA_R1 = ((READ===1'b1)&&(WRITE===1'b1) || (READ===1'b0)&&(WRITE===1'b0))?{`DATA_WIDTH{1'bz}}:reg_data_r1 ;
assign DATA_R2 = ((READ===1'b1)&&(WRITE===1'b1) || (READ===1'b0)&&(WRITE===1'b0))?{`DATA_WIDTH{1'bz}}:reg_data_r2 ;

//intialize the 32 registers as 0
initial 
begin
   for (i = 0; i < `REG_INDEX_LIMIT; i = i + 1)
   begin
	mem_32x32[i] = {`DATA_WIDTH{1'b0}};
   end
end

always @ (negedge RST or posedge CLK)
begin
	// TBD: Code for the register file model
	
	//resets the block on a negative edge of the reset
	if (RST === 1'b0)
	begin
	   for (i = 0; i < `REG_INDEX_LIMIT; i = i + 1)
   	   begin
		mem_32x32[i] = {`DATA_WIDTH{1'b0}};
   	   end
	end
	else	//if its not a reset(positife edge of RST) then it must be a read or write
	begin
	    //handles the read rquest
	   if (READ === 1'b1 && WRITE === 1'b0)
	   begin
	      reg_data_r1 = mem_32x32[ADDR_R1];
	      reg_data_r2 = mem_32x32[ADDR_R2];
	   end
	   //handles the write request
	   else if (READ === 1'b0 && WRITE === 1'b1)
	   begin
	      mem_32x32[ADDR_W] = DATA_W;
	   end
        
        end

end
endmodule

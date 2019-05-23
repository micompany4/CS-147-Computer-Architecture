// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
// output list
output [63:0] Y;
output CO;
// input list
input [63:0] A;
input [63:0] B;
input SnA;

// TBD
wire [`DATA_INDEX_LIMIT:0] BthruX;	//holds the value of passing B and SnA through an xor gate
wire [`DATA_INDEX_LIMIT:0] nextCI;	//holds the value of for the CO to be passed into CI at the next adder

xor firstints(BthruX[0], B[0], SnA);
FULL_ADDER inst1(.S(Y[0]), .CO(nextCI[0]), .A(A[0]), .B(BthruX[0]), .CI(SnA));

genvar i;
generate
for(i = 1; i < 64; i = i+1)
begin
     xor intsxor(BthruX[i], SnA, B[i]);
     FULL_ADDER inst2(.S(Y[i]), .CO(nextCI[i]), .A(A[i]), .B(BthruX[i]), .CI(nextCI[i-1]));
end
endgenerate


endmodule



module RC_ADD_SUB_32(Y, CO, A, B, SnA);
// output list
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
// input list
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;

// TBD
wire [`DATA_INDEX_LIMIT:0] BthruX;	//holds the value of passing B and SnA through an xor gate
wire [`DATA_INDEX_LIMIT:0] nextCI;	//holds the value of for the CO to be passed into CI at the next adder

xor firstints(BthruX[0], B[0], SnA);
FULL_ADDER inst1(.S(Y[0]), .CO(nextCI[0]), .A(A[0]), .B(BthruX[0]), .CI(SnA));

genvar i;
generate
for(i = 1; i < `DATA_WIDTH; i = i+1)
begin
     xor intsxor(BthruX[i], SnA, B[i]);
     FULL_ADDER inst2(.S(Y[i]), .CO(nextCI[i]), .A(A[i]), .B(BthruX[i]), .CI(nextCI[i-1]));
end
endgenerate

//overflow detector 
xor(CO, nextCI[31], nextCI[30]);

endmodule


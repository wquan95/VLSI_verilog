module adder_16bit_b(A , B ,Add_ctrl , O , C_out , SUM);

input [15:00] A , B ;
input Add_ctrl;//1 for sub ,0 for add

output [15:00] SUM ;
output C_out ;
output O ;
wire [15:0] y;
reg O;
reg overflow;
wire equal;
assign y =~B+1;
assign {C_out,SUM} = (Add_ctrl==0)?(A+B):(A+y);
always@*
begin	
	if(B[15]==y[15]) overflow = 0;
	else if(A[15]==1'b1&&y[15]==1'b1&&SUM[15]==1'b0&&Add_ctrl==1) overflow = 1;
	else if(A[15]==1'b0&&y[15]==1'b0&&SUM[15]==1'b1&&Add_ctrl==1) overflow = 1;
	else if(A[15]==1'b1&&B[15]==1'b1&&SUM[15]==1'b0&&Add_ctrl==0) overflow = 1;
	else if(A[15]==1'b0&&B[15]==1'b0&&SUM[15]==1'b1&&Add_ctrl==0) overflow = 1;
    else overflow = 0;
	O <= overflow;
end
endmodule

//assign O = ((Add_ctrl==1'b0&&(A[15]==1'b0&&B[15]==1'b0&&SUM[15]==1'b1))||(Add_ctrl==1'b0&&(A[15]==1'b1&&y[15]==1'b0&&SUM[15]==1'b0))||(Add_ctrl==1'b1&&(A[15]==1'b0&&B[15]==1'b1&&SUM[15]==1'b1))||(Add_ctrl==1'b1&&(A[15]==1'b1&&B[15]==1'b0&&SUM[15]==1'b0)))?1:0;


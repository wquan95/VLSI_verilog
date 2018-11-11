module full_adder(A, B, C_in, Sum, C_out);

input A, B, C_in;
output Sum, C_out ;

wire xor1_out;
wire and1_out,and2_out;

xor xor1(xor1_out,A,B);
xor xor2(Sum,xor1_out,C_in);
and and1(and1_out,xor1_out,C_in);
and and2(and2_out,A,B);
or or1(C_out,and1_out,and2_out); 

endmodule
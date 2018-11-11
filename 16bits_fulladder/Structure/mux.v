module mux(in1, in2, sel, out);
input in1,in2;
input sel;
output out;

wire and1_out,and2_out;
wire not1_out;

not not2(not2_out,in2);
not not1(not1_out,sel);
and and1(and1_out,in2, not1_out);
and and2(and2_out,not2_out, sel);
or or1(out,and1_out, and2_out); 

endmodule
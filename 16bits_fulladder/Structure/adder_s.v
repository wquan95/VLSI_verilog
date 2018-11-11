`include "mux.v"
`include "full_adder.v"

module adder_16bit_s(A , B ,Add_ctrl , O , C_out , SUM);

input [15:00] A , B ;
input Add_ctrl;//1 for sub ,0 for add

output [15:00] SUM ;
output C_out ;
wire[15:0] c_out1;
output O ;

/** your code **/
wire [15:00] C_in;
wire [15:00]B1;//~B
wire [15:00] y;//Add_ctrl selection for whether B or B~
/*xor xor30(y[0],Add_ctrl,B[0]);
xor xor31(y[1],Add_ctrl,B[1]);
xor xor32(y[2],Add_ctrl,B[2]); 
xor xor33(y[3],Add_ctrl,B[3]);
xor xor34(y[4],Add_ctrl,B[4]);
xor xor35(y[5],Add_ctrl,B[5]);
xor xor36(y[6],Add_ctrl,B[6]);
xor xor37(y[7],Add_ctrl,B[7]);
xor xor38(y[8],Add_ctrl,B[8]);
xor xor39(y[9],Add_ctrl,B[9]);
xor xor40(y[10],Add_ctrl,B[10]);
xor xor41(y[11],Add_ctrl,B[11]);
xor xor42(y[12],Add_ctrl,B[12]);
xor xor43(y[13],Add_ctrl,B[13]);
xor xor44(y[14],Add_ctrl,B[14]);
xor xor45(y[15],Add_ctrl,B[15]);*/
mux mux1(.in1(B[0]), .in2(B[0]), .sel(Add_ctrl),.out(y[0])); 
mux mux2(.in1(B[1]), .in2(B[1]), .sel(Add_ctrl),.out(y[1])); 
mux mux3(.in1(B[2]), .in2(B[2]), .sel(Add_ctrl),.out(y[2])); 
mux mux4(.in1(B[3]), .in2(B[3]), .sel(Add_ctrl),.out(y[3])); 
mux mux5(.in1(B[4]), .in2(B[4]), .sel(Add_ctrl),.out(y[4])); 
mux mux6(.in1(B[5]), .in2(B[5]), .sel(Add_ctrl),.out(y[5])); 
mux mux7(.in1(B[6]), .in2(B[6]), .sel(Add_ctrl),.out(y[6])); 
mux mux8(.in1(B[7]), .in2(B[7]), .sel(Add_ctrl),.out(y[7])); 
mux mux9(.in1(B[8]), .in2(B[8]), .sel(Add_ctrl),.out(y[8])); 
mux mux10(.in1(B[9]), .in2(B[9]), .sel(Add_ctrl),.out(y[9])); 
mux mux11(.in1(B[10]), .in2(B[10]), .sel(Add_ctrl),.out(y[10])); 
mux mux12(.in1(B[11]), .in2(B[11]), .sel(Add_ctrl),.out(y[11])); 
mux mux13(.in1(B[12]), .in2(B[12]), .sel(Add_ctrl),.out(y[12])); 
mux mux14(.in1(B[13]), .in2(B[13]), .sel(Add_ctrl),.out(y[13])); 
mux mux15(.in1(B[14]), .in2(B[14]), .sel(Add_ctrl),.out(y[14])); 
mux mux16(.in1(B[15]), .in2(B[15]), .sel(Add_ctrl),.out(y[15])); 

full_adder full_adder1(.A(A[0]),.B(y[0]),.C_in(Add_ctrl),.Sum(SUM[0]),.C_out(c_out1[0]));
full_adder full_adder2(.A(A[1]),.B(y[1]),.C_in(c_out1[0]),.Sum(SUM[1]),.C_out(c_out1[1]));
full_adder full_adder3(.A(A[2]),.B(y[2]),.C_in(c_out1[1]),.Sum(SUM[2]),.C_out(c_out1[2]));
full_adder full_adder4(.A(A[3]),.B(y[3]),.C_in(c_out1[2]),.Sum(SUM[3]),.C_out(c_out1[3]));
full_adder full_adder5(.A(A[4]),.B(y[4]),.C_in(c_out1[3]),.Sum(SUM[4]),.C_out(c_out1[4]));
full_adder full_adder6(.A(A[5]),.B(y[5]),.C_in(c_out1[4]),.Sum(SUM[5]),.C_out(c_out1[5]));
full_adder full_adder7(.A(A[6]),.B(y[6]),.C_in(c_out1[5]),.Sum(SUM[6]),.C_out(c_out1[6]));
full_adder full_adder8(.A(A[7]),.B(y[7]),.C_in(c_out1[6]),.Sum(SUM[7]),.C_out(c_out1[7]));
full_adder full_adder9(.A(A[8]),.B(y[8]),.C_in(c_out1[7]),.Sum(SUM[8]),.C_out(c_out1[8]));
full_adder full_adder10(.A(A[9]),.B(y[9]),.C_in(c_out1[8]),.Sum(SUM[9]),.C_out(c_out1[9]));
full_adder full_adder11(.A(A[10]),.B(y[10]),.C_in(c_out1[9]),.Sum(SUM[10]),.C_out(c_out1[10]));
full_adder full_adder12(.A(A[11]),.B(y[11]),.C_in(c_out1[10]),.Sum(SUM[11]),.C_out(c_out1[11]));
full_adder full_adder13(.A(A[12]),.B(y[12]),.C_in(c_out1[11]),.Sum(SUM[12]),.C_out(c_out1[12]));
full_adder full_adder14(.A(A[13]),.B(y[13]),.C_in(c_out1[12]),.Sum(SUM[13]),.C_out(c_out1[13]));
full_adder full_adder15(.A(A[14]),.B(y[14]),.C_in(c_out1[13]),.Sum(SUM[14]),.C_out(c_out1[14]));
full_adder full_adder16(.A(A[15]),.B(y[15]),.C_in(c_out1[14]),.Sum(SUM[15]),.C_out(C_out));

xor xor1(O, c_out1[14], C_out);//overflow dectection

endmodule

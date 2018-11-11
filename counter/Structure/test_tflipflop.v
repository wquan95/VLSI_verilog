`include "tflipflop.v"
`timescale 1ns/10ps


module testing;
reg R;
wire Q, Qn;
reg D;
reg clk = 0;
always #3 clk = ~clk;
tff tff1(.Q(Q), .Qn(Qn), .C(clk), .T(D), .R(R));

initial
begin
  R = 0;
  D = 0;
  #10;
  R = 1;
  #1
  D = 1;
  #10
  $display("Q = %d",Q);
  #10
  D = 1;
  #10
  R = 0;
  #10
  R =1;
  #20
  D = 0;
  
  $display("Q = %d",Q);
  
end


endmodule
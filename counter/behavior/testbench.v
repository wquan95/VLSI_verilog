`timescale 1ns/10ps
`include  "counter_b.v"

module tb_counter_b;

reg clk = 0,clear,ctrl;
wire [5:0]count;
wire ripple_out;

always
begin
  #5 clk = ~clk;
  $display("count = %d",count);
end
counter_b counter1(
    .ctrl(ctrl), 
    .clear(clear), 
    .clk(clk), 
    .count(count), 
    .ripple_out(ripple_out)
    );

initial
begin
  clear = 1;
  ctrl = 0;
  #1 clear = 0;
  ctrl = 1;
  #300
  clear = 1;
  #10
  clear = 0;
  ctrl = 0;
  #300; 
  $finish;
end
endmodule
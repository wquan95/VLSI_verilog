`timescale 1ns/1ps

`ifdef syn
`include "tsmc18.v"
`include "TLC_syn.v"
`else
`include "TLC.v"
`endif 

module test_TLC;

wire T12G, T12R, T12Y;
wire T34G, T34R, T34Y;
wire T5G, T5R;
wire T6G, T6R;
wire[5:0] counter;
reg clk;

wire[2:0] state;
reg reset;

always #5 clk = ~clk;

traffic_lights TFL(
        .T12R(T12R), 
        .T12Y(T12Y), 
        .T12G(T12G), 
        .T34R(T34R), 
        .T34Y(T34Y), 
        .T34G(T34G),
        .T5R(T5R),
        .T5G(T5G),
        .T6R(T6R),
        .T6G(T6G),
        .state(state),
        .clk(clk),
        .counter(counter),
        .reset(reset)
        );

always@(state)
begin
    wait(~clk);
    $display("==============================================");
    $display("Time = %d",counter);
    $display("State = %d", state);
    $display("T12R = %d, T12Y = %d, T12G = %d", T12R, T12Y, T12G);
    $display("T34R = %d, T34Y = %d, T34G = %d",T34R ,T34Y, T34G);
    $display("T5R = %d, T5G = %d",T5R, T5G);
    $display("T6R = %d, T6G = %d",T6R, T6G);
end



initial
begin
	clk = 0;
	#1 reset = 1;
	#2 reset = 0;
	#2 reset = 1;
	#1000 $finish;

end
initial begin
	$dumpfile("TLC.vcd");
	$dumpvars;
end

`ifdef syn
initial $sdf_annotate("TLC_syn.sdf", TFL);
`endif
endmodule

`include "TLC.v"
`include "counter_b.v"
`timescale 1ns/1ps

module test_TLC;

wire T12G, T12R, T12Y;
wire T34G, T34R, T34Y;
wire T5G, T5R;
wire T6G, T6R;
wire[31:0] timer;
wire[31:0] counter;
reg clk = 0;

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
        .State(state),
        .clk(clk),
        .timer(timer),
        .counter(counter),
        .reset(reset)
        );

always@(state)
begin
    begin
        $display("Timer = %dsec", timer);
        $display("State = %d", state);
        $display("T12R = %d, T12Y = %d, T12G = %d", T12R, T12Y, T12G);
        $display("T34R = %d, T34Y = %d, T34G = %d",T34R ,T34Y, T34G);
        $display("T5R = %d, T5G = %d",T5R, T5G);
        $display("T6R = %d, T6G = %d",T6R, T6G);
    end
end

initial
begin
    reset = 1;
    #10
    reset = 0;
    #10
    reset = 1;
end


endmodule
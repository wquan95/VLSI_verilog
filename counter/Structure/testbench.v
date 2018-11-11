`include "counter.v"

module tb_counter;

reg clk = 1;
reg trig;
reg reset;
reg ctrl;

wire[5:0] count;

always 
begin

    #5 clk = ~clk;
    if(reset)
    $display("count = %d",count);

end

counter counter1(.count(count), .clk(clk) ,.reset(reset), .ctrl(ctrl), .trig(trig));


initial
begin
    
    trig = 0;
    reset = 0;
    ctrl = 0;
    $display("reset = 0 ,count = %d",count);
    #8
    reset = 1;
    trig = 1;
    #300
    reset = 0;
    #10
    reset = 1;
    ctrl = 1;
    #300
    ctrl = 0;
    #100
    trig = 0;
    #10
    reset = 0;
    $display("reset = 0 ,count = %d",count);

end


endmodule
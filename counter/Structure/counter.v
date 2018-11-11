`include "tflipflop.v"
`include "mux.v"

module counter(count, ,clk ,reset, ctrl, trig);

    input reset; // reset the counter(active low), reset must be 0 for initializing
    input ctrl;//counting up or down, 0 for up / 1 for down
    input trig;//start or stop
    input clk;
    output[5:0] count;

    wire[4:0] Q, Qn;

    wire and1_out;
    wire and2_out;
    wire and3_out;
    wire and4_out;
    wire and5_out;
    wire and6_out;
    wire and7_out;
    wire and8_out;
    wire and9_out;
    wire and10_out;
    wire and11_out;
    wire and12_out;
    wire and13_out;
    wire and14_out;
    wire and15_out;
    wire and16_out;
    wire and17_out;

    wire and_out;
    wire and_trig;

    wire T0,T1,T2,T3,T4;


    // wand R;

    // assign  R = reset;
    // assign R = nand_out; 

    assign count[5] = 0;

    and(and1_out,~ctrl,Q[4],Q[2]);
    and(and2_out,ctrl,~Q[3],~Q[2],~Q[1],~Q[0]);
    and(and3_out,~ctrl,Q[3],Q[2],Q[1],Q[0]);
    or(T4,and1_out,and2_out,and3_out);

    and(and4_out,~ctrl,Q[2],Q[1],Q[0]);
    and(and5_out,ctrl,Q[3],~Q[2],~Q[1],~Q[0]);
    and(and6_out,ctrl,Q[4],~Q[2],~Q[1],~Q[0]);
    or(T3,and4_out,and5_out,and6_out);

    and(and7_out,Q[4],Q[2]);
    and(and8_out,~ctrl,Q[1],Q[0]);
    and(and9_out,ctrl,~Q[1],~Q[0]);
    or(T2,and7_out,and8_out,and9_out);

    and(and10_out,~ctrl,Q[0]);
    and(and11_out,ctrl,Q[1],~Q[0]);
    and(and12_out,ctrl,Q[2],~Q[0]);
    and(and13_out,ctrl,Q[3],~Q[0]);
    and(and14_out,ctrl,Q[4],~Q[0]);
    or(T1,and10_out,and11_out,and12_out,and13_out,and14_out);

    and(and15_out,~ctrl,~Q[4]);
    and(and16_out,Q[4],~Q[2]);
    and(and17_out,ctrl,Q[2]);
    or(T0, and15_out,and16_out,and17_out,Q[0],Q[1],Q[3]);
    // and and1(and1_out,Q[0],and_trig);
    // and and2(and2_out,and1_out,Q[1]);
    // and and3(and3_out,and2_out,Q[2]);
    // and and4(and4_out,and3_out,Q[3]);
    // and and5(and_out,Qn[0],Qn[1],Q[2],Qn[3],Q[4]);

    // or(or1,and2_out,and_out);
    // or(or2,and4_out,and_out);
    // and(and_trig,~and_out,trig);

    

    tff tff0(.Q(Q[0]), .Qn(Qn[0]), .C(clk), .T(T0), .R(reset));
    tff tff1(.Q(Q[1]), .Qn(Qn[1]), .C(clk), .T(T1), .R(reset));
    tff tff2(.Q(Q[2]), .Qn(Qn[2]), .C(clk), .T(T2), .R(reset));
    tff tff3(.Q(Q[3]), .Qn(Qn[3]), .C(clk), .T(T3), .R(reset));
    tff tff4(.Q(Q[4]), .Qn(Qn[4]), .C(clk), .T(T4), .R(reset));

    assign count[4] = Q[4];
    assign count[3] = Q[3];
    assign count[2] = Q[2];
    assign count[1] = Q[1];
    assign count[0] = Q[0];
    // mux mux0(.in1(Q[0]), .in2(Qn[0]), .sel(ctrl), .out(count[0]));
    // mux mux1(.in1(Q[1]), .in2(Qn[1]), .sel(ctrl), .out(count[1]));
    // mux mux2(.in1(Q[2]), .in2(Qn[2]), .sel(ctrl), .out(count[2]));
    // mux mux3(.in1(Q[3]), .in2(Qn[3]), .sel(ctrl), .out(count[3]));
    // mux mux4(.in1(Q[4]), .in2(Qn[4]), .sel(ctrl), .out(count[4]));

endmodule
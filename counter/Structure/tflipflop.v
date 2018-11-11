module tff(Q, Qn, C, T, R);

    output Q,Qn;
    input C, T,R;
    wire xor_out;
    // wand temp;
    // wand Tin;
    // assign temp = R;
    // assign temp = Q;
    // assign Tin = T;
    // assign Tin =  R;

    // xor(xor_out,Tin,temp);
    xor(xor_out, T, Q);

    d_flip_flop_edge_triggered dff1(Q, Qn, C, xor_out, R);

endmodule

module d_flip_flop_edge_triggered(Q, Qn, C, D, R);
    output Q;
    output Qn;
    input  C;
    input  D;
    input R;
    

    wire   Cn;   // Control input to the D latch.
    wire   Cnn;  // Control input to the SR latch.
    wire   DQ;   // Output from the D latch, input to the gated SR latch.
    wire   DQn;  // Output from the D latch, input to the gated SR latch.
   
    wand reset; // to reset

    assign reset = DQ;
    assign reset = R;

    not(Cn, C);
    not(Cnn, Cn);   
    d_latch dl(DQ, DQn, Cn, D);
    d_latch d2(Q, Qn, Cnn, reset);   
endmodule // d_flip_flop_edge_triggered

module d_latch(Q, Qn, G, D);
   output Q;
   output Qn;
   input  G;   
   input  D;
   wire   Dn; 
   wire   D1;
   wire   Dn1;

   not(Dn, D);   
   and(D1, G, D);
   and(Dn1, G, Dn);   
   nor(Qn, D1, Q);
   nor(Q, Dn1, Qn);
endmodule // d_latch

// module sr_latch_gated(Q, Qn, G, S,R);
//    output Q;
//    output Qn;
//    input  G;   
//    input  S;
//    input R;
//    trior Q,Qn;

//     reg i = 0;
//    wire   S1;
//    wire   R1;
//    and(S1, G, S);
//    and(R1, G, R);   
//    nor(Qn, S1, Q);
//    nor(Q, R1, Qn);
// endmodule // sr_latch_gated
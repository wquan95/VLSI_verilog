/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : N-2017.09-SP4
// Date      : Mon Nov 19 12:24:43 2018
/////////////////////////////////////////////////////////////


module traffic_lights ( T12R, T12Y, T12G, T34R, T34Y, T34G, T5R, T5G, T6R, T6G, 
        state, clk, counter, reset );
  output [2:0] state;
  output [5:0] counter;
  input clk, reset;
  output T12R, T12Y, T12G, T34R, T34Y, T34G, T5R, T5G, T6R, T6G;
  wire   N23, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, n3,
         n4, n6, n8, n9, n10, n11, n14, n15, n16, n17, n18, n23, n26, n29, n30,
         n31, n32, n33, n34, n35, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n53, n55;
  wire   [2:0] next_state;
  wire   [5:2] \add_51_S2/carry ;

  DFFRX1 \next_state_reg[0]  ( .D(n35), .CK(clk), .RN(reset), .Q(next_state[0]), .QN(n32) );
  DFFRX1 \next_state_reg[1]  ( .D(n34), .CK(clk), .RN(reset), .Q(next_state[1]), .QN(n31) );
  DFFRX1 \next_state_reg[2]  ( .D(n33), .CK(clk), .RN(reset), .Q(next_state[2]), .QN(n30) );
  EDFFX1 \state_reg[2]  ( .D(next_state[2]), .E(reset), .CK(clk), .Q(state[2]), 
        .QN(n43) );
  EDFFX1 \state_reg[1]  ( .D(next_state[1]), .E(reset), .CK(clk), .Q(state[1]), 
        .QN(n44) );
  DFFRHQX1 \counter_reg[0]  ( .D(N31), .CK(clk), .RN(reset), .Q(counter[0]) );
  DFFRHQX1 \counter_reg[4]  ( .D(N35), .CK(clk), .RN(reset), .Q(counter[4]) );
  EDFFX1 \state_reg[0]  ( .D(next_state[0]), .E(reset), .CK(clk), .Q(state[0]), 
        .QN(n42) );
  DFFRHQX1 \counter_reg[5]  ( .D(N36), .CK(clk), .RN(reset), .Q(counter[5]) );
  DFFRHQX1 \counter_reg[1]  ( .D(N32), .CK(clk), .RN(reset), .Q(counter[1]) );
  DFFRHQX1 \counter_reg[2]  ( .D(N33), .CK(clk), .RN(reset), .Q(counter[2]) );
  DFFRHQX1 \counter_reg[3]  ( .D(N34), .CK(clk), .RN(reset), .Q(counter[3]) );
  INVX1 U43 ( .A(clk), .Y(n29) );
  INVX1 U50 ( .A(T6R), .Y(T6G) );
  INVX1 U51 ( .A(n3), .Y(n45) );
  NOR2X1 U52 ( .A(n26), .B(n18), .Y(n9) );
  NOR2X1 U53 ( .A(n44), .B(n42), .Y(n6) );
  NOR2X1 U54 ( .A(n43), .B(n53), .Y(T34Y) );
  INVX1 U55 ( .A(n18), .Y(n53) );
  AND2X2 U56 ( .A(N26), .B(N23), .Y(N32) );
  AND2X2 U57 ( .A(N27), .B(N23), .Y(N33) );
  AND2X2 U58 ( .A(N28), .B(N23), .Y(N34) );
  AND2X2 U59 ( .A(N29), .B(N23), .Y(N35) );
  NAND3BX1 U60 ( .AN(n6), .B(n43), .C(n9), .Y(T6R) );
  OAI21XL U61 ( .A0(n26), .A1(n42), .B0(n43), .Y(T12R) );
  OAI21XL U62 ( .A0(n55), .A1(n29), .B0(T5R), .Y(T34G) );
  INVX1 U63 ( .A(n8), .Y(n55) );
  INVX1 U64 ( .A(T5G), .Y(T5R) );
  NOR2X1 U65 ( .A(counter[0]), .B(n10), .Y(n3) );
  AOI31X1 U66 ( .A0(n11), .A1(n47), .A2(n49), .B0(n14), .Y(n10) );
  AOI21X1 U67 ( .A0(n15), .A1(n16), .B0(n17), .Y(n14) );
  INVX1 U68 ( .A(n23), .Y(n49) );
  NOR2X1 U69 ( .A(n42), .B(state[1]), .Y(n26) );
  OAI22X1 U70 ( .A0(state[0]), .A1(n45), .B0(n3), .B1(n32), .Y(n35) );
  OAI22X1 U71 ( .A0(n3), .A1(n30), .B0(n4), .B1(n45), .Y(n33) );
  AOI211X1 U72 ( .A0(n6), .A1(n43), .B0(T34Y), .C0(n8), .Y(n4) );
  OAI22X1 U73 ( .A0(n3), .A1(n31), .B0(n9), .B1(n45), .Y(n34) );
  INVX1 U74 ( .A(counter[3]), .Y(n48) );
  AOI32X1 U75 ( .A0(n50), .A1(n44), .A2(n42), .B0(n26), .B1(counter[2]), .Y(
        n23) );
  INVX1 U76 ( .A(counter[1]), .Y(n51) );
  INVX1 U77 ( .A(counter[2]), .Y(n50) );
  INVX1 U78 ( .A(counter[5]), .Y(n46) );
  OAI33X1 U79 ( .A0(n48), .A1(counter[5]), .A2(n51), .B0(n46), .B1(counter[3]), 
        .B2(counter[1]), .Y(n11) );
  NOR2X1 U80 ( .A(n44), .B(state[0]), .Y(n18) );
  AOI22X1 U81 ( .A0(n6), .A1(counter[2]), .B0(n18), .B1(n50), .Y(n17) );
  NAND4X1 U82 ( .A(counter[4]), .B(counter[1]), .C(n48), .D(n46), .Y(n15) );
  NAND4X1 U83 ( .A(counter[3]), .B(counter[5]), .C(n51), .D(n47), .Y(n16) );
  NOR2X1 U84 ( .A(n43), .B(state[1]), .Y(n8) );
  ADDHXL U85 ( .A(counter[3]), .B(\add_51_S2/carry [3]), .CO(
        \add_51_S2/carry [4]), .S(N28) );
  ADDHXL U86 ( .A(counter[2]), .B(\add_51_S2/carry [2]), .CO(
        \add_51_S2/carry [3]), .S(N27) );
  ADDHXL U87 ( .A(counter[1]), .B(counter[0]), .CO(\add_51_S2/carry [2]), .S(
        N26) );
  INVX1 U88 ( .A(counter[4]), .Y(n47) );
  AND2X2 U89 ( .A(N30), .B(N23), .Y(N36) );
  AND2X2 U90 ( .A(N25), .B(N23), .Y(N31) );
  INVX1 U91 ( .A(counter[0]), .Y(N25) );
  ADDHXL U92 ( .A(counter[4]), .B(\add_51_S2/carry [4]), .CO(
        \add_51_S2/carry [5]), .S(N29) );
  NOR2X1 U93 ( .A(n55), .B(state[0]), .Y(T5G) );
  NOR2X1 U94 ( .A(state[2]), .B(n53), .Y(T12Y) );
  AOI211X1 U95 ( .A0(state[0]), .A1(n29), .B0(state[2]), .C0(state[1]), .Y(
        T12G) );
  AOI211X1 U96 ( .A0(state[2]), .A1(n26), .B0(T5G), .C0(T34Y), .Y(T34R) );
  XOR2X1 U97 ( .A(\add_51_S2/carry [5]), .B(counter[5]), .Y(N30) );
  AOI32X1 U98 ( .A0(counter[3]), .A1(counter[2]), .A2(counter[5]), .B0(
        counter[4]), .B1(counter[5]), .Y(N23) );
endmodule


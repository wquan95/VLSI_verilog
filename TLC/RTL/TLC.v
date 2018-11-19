`timescale 1ns/1ps

module traffic_lights(T12R, T12Y, T12G, T34R, T34Y, T34G, T5R, T5G, T6R, T6G, state,
clk, counter, reset);

output T12R, T12Y, T12G;
output T34R, T34Y, T34G;
output T5R, T5G;
output T6R, T6G;
output reg [2:0] state;
output reg [5:0] counter;

input clk;
input reset;

parameter S1 = 3'b000;
parameter S2 = 3'b001; 
parameter S3 = 3'b010; 
parameter S4 = 3'b011;
parameter S5 = 3'b100;
parameter S6 = 3'b101;
parameter S7 = 3'b110;
parameter S8 = 3'b111;

reg[2:0] next_state;
wire GT, BGT, YT, ART;

assign T12G = (state == S1) ? 1 : state == S2 ? (clk == 1) : 0;
assign T12Y = (state == S3);
assign T12R = (state != S1 && state != S2 && state != S3);
assign T34G = (state == S5) ? 1 : state == S6 ? (clk == 1) : 0;
assign T34Y = (state == S7);
assign T34R = (state != S5 && state != S6 && state != S7);
assign T5R = (state != S5);
assign T5G = (state == S5);
assign T6R = (state != S1);
assign T6G = (state == S1);

assign GT = (counter == 10 || counter == 32)?1:0;
assign BGT = (counter == 14 || counter == 36)?1:0;
assign YT = (counter == 18 || counter == 40)?1:0;
assign ART = (counter == 22 || counter == 44)?1:0;


always@(posedge clk or negedge reset) begin
	if (~reset) begin
		counter <= 0;
		next_state <= S1;
	end
	else begin
		if (counter <= 'd43) counter <= counter + 1'b1; else counter <= 0;
		state <= next_state; 
		case(state)
			S1: if (GT ==1'b1) next_state <= S2;
			S2: if (BGT==1'b1) next_state <= S3;
			S3: if (YT ==1'b1) next_state <= S4;
			S4: if (ART==1'b1) next_state <= S5;
			S5: if (GT ==1'b1) next_state <= S6;
			S6: if (BGT==1'b1) next_state <= S7;
			S7: if (YT ==1'b1) next_state <= S8;
			S8: if (ART==1'b1) next_state <= S1;
		endcase
	end
	
end

endmodule

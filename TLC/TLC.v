`include "counter_b.v"

module traffic_lights(T12R, T12Y, T12G, T34R, T34Y, T34G, T5R, T5G, T6R, T6G, State,
clk, timer, counter, reset);

output T12R, T12Y, T12G;
output T34R, T34Y, T34G;
output T5R, T5G;
output T6R, T6G;
output wire[2:0] State;

input clk;
input reset;

reg[31:0] timer_;
reg[31:0] counter_;

wire ripple_out;
wire[5:0] count;

reg [2:0] state, next_state;
reg GT, BGT, YT, ART;

reg[2:0] S1=3'b000, S2=3'b001, S3=3'b010, S4=3'b011;
reg[2:0] S5=3'b100, S6=3'b101, S7=3'b110, S8=3'b111;

output wire [31:0] timer, counter;

assign State = state;
assign counter = counter_;
assign timer = timer_;

assign T12G = (state==S1)?1:state==S2?(counter_<=50/2-1):0;
assign T12Y = (state==S3);
assign T12R = (state!=S1&&state!=S2&&state!=S3);
assign T34G = (state==S5)?1:state==S6?(counter_<=50/2-1):0;
assign T34Y = (state==S7);
assign T34R = (state!=S5&&state!=S6&&state!=S7);
assign T5R = (state!=S5);
assign T5G = (state==S5);
assign T6R = (state!=S1);
assign T6G = (state==S1);

always @(posedge clk or negedge reset)
begin
    if(~reset) begin
        state = S1;
        next_state = S1;
        counter_ = 0;
        timer_ = 0;
    end
    else begin
        state <= next_state;
    end
end  

always@ (state or GT or YT or BGT or ART)
begin
    case(state)
        S1: if(GT==1) next_state = S2;
        S2: if(BGT==1) next_state = S3;
        S3: if(YT==1) next_state = S4;
        S4: if(ART==1) next_state =S5;
        S5: if(GT==1) next_state = S6;
        S6: if(BGT==1) next_state = S7;
        S7: if(YT==1) next_state = S8;
        S8: if(ART==1) next_state =S1;
    endcase
end

always@(timer_)
begin
    if(timer_ == 46) timer_ = 0;
    if(timer_ == 10||timer_ == 33) GT = 1;
    else GT = 0;
    if(timer_ == 14||timer_ == 37) BGT = 1;
    else BGT = 0;
    if(timer_ == 18||timer_ == 41) YT = 1;
    else YT = 0;
    if(timer_ == 22||timer_ == 0) ART = 1;
    else ART = 0;
end

counter_b counter1(
        .ctrl(1'b0), 
        .clear(~reset), 
        .clk(clk), 
        .count(count), 
        .ripple_out(ripple_out)
        );

always@(posedge ripple_out)
    begin
        if(counter_ == 50) 
        begin
            counter_ <= 0;
            timer_ <= timer_ + 1;
        end
        else  
        begin
        counter_ <= counter_ + 1;
        end
    end
 
endmodule
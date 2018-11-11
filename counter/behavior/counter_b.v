module counter_b(ctrl, clear, clk, count, ripple_out);

input ctrl, clear, clk;//ctrl == 1
output reg[5:0] count;
output ripple_out;

assign ripple_out = ~ctrl? count==5'b010100 : count==5'b000000;

always@(posedge clk, posedge clear)
begin
  if(clear)count = 0;
  else if(count == 5'b010100 && ~ctrl) count = 0;
  else if(count == 5'b000000 && ctrl) count = 5'b010100;
  else if(~ctrl) count = count + 1;
  else count = count-1;
end

// always@(posedge ctrl, negedge ctrl)
// begin
//     if(ctrl) count = 5'b010100;
//     else count = 0;
// end
endmodule

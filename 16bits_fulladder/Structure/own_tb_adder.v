`timescale       1ns/10ps
`include        "adder_s.v"

module own_tb_adder;

reg[15:0] A ,B;
reg Add_ctrl;
integer i = 0;
wire O;
wire C_out;
wire[15:0] SUM;

reg[15:0] mem_A [99:0];
reg[15:0] mem_B [99:0];
reg mem_Add_ctrl [99:0]; 

initial
begin
    for(i=0;i<=99;i=i+1)
    begin
    mem_B[i] <= $random ;
    mem_A[i] <= $random;
    mem_Add_ctrl[i] <= $random  ;
    end
end

adder_16bit_s u_adder(        .A            (A        ),
                .B            (B        ),
                .Add_ctrl     (Add_ctrl ),
                .O            (O        ),
                .C_out        (C_out    ),
                .SUM          (SUM      )
);
initial
begin
        #10;
        for(i=0;i<=99;i=i+1)
        begin
        A = mem_A[i];
        B = mem_B[i];
        Add_ctrl = mem_Add_ctrl[i];
        #10;
        if(Add_ctrl==0)    
            $display(" %b + %b = %b, O = %b CarryOut = %b, Add_ctrl = %b",A,B,SUM,O,C_out,Add_ctrl);
        else
            $display(" %b - %b = %b, O = %b CarryOut = %b, Add_ctrl = %b",A,B,SUM,O,C_out,Add_ctrl);
        end
end


initial
begin
	$fsdbDumpfile("adder_b.fsdb");
	$fsdbDumpvars;
end

endmodule

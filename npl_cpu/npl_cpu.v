/* ==========================
 *   Model of RISC without pipeline.
 *   risc.v
 *
 *  Useful for instruction set simulation.
 *  Three main tasks - fetch, execute, write.
 */
`timescale 1ns/10ps

module instruction_set_model ;
/* 
 * Declarations, functions , and tasks
 */
// Declare parameters
parameter  CYCLE=10 ;		             // Cycle Time
parameter  WIDTH=32 ; 		// Width of data paths
parameter  ADDRSIZE = 12 ;		// Size of address field
parameter  MEMSIZE = 18;	// Size of memory
parameter  MAXREGS = 16 ;		// Maximum # of registers
parameter  SBITS = 5 ;		              // Status register bits

// Declare Registers and Memory

reg [WIDTH-1:0] MEM[MEMSIZE-1:0],    //  MEMORY
      		 RFILE[0:MAXREGS-1],   // Register File
			 ir,                                      // Instruction Register
			 src1, src2 ;                       // Alu operation registers
reg[WIDTH:0]	 result ;     // ALU result register
reg[SBITS-1:0]	 psr;          // Processor Status Register
reg[ADDRSIZE-1:0] pc ;    // Program counter
reg               dir;                   // rotate direction
reg               reset;               // System Reset
reg[31:0]           i;                    // useful for interactive debugging **integer cannot detect even it is negetive     

// General definitions
`define TRUE 1
`define FALSE 0 
`define DEBUG_ON  debug = 1
`define DEBUG_OFF debug = 0

// Define Instruction fields
`define OPCODE ir[31:28]
`define SRC 	ir[23:12]
`define DST 	 ir[11:0]
`define SRCTYPE ir[27] // source type, 0=reg (mem for LD), 1=imm
`define DSTTYPE ir[26] // destination type, 0=reg, 1=imm
`define CCODE 	 ir[27:24]
`define SRCNT 	 ir[23:12] // Shift/rotate count -= left, +=right

// Operand Types
`define REGTYPE 0
`define IMMTYPE 1

 // Define opcodes for each instruction
`define NOP     	4'b0000
`define BRA     	4'b0001
`define LD      	4'b0010
`define STR     	4'b0011
`define ADD     	4'b0100
`define SUB       4'b0101 //new instruction: substraction   
`define MUL     	4'b0110
`define DIV       4'b0111 //new instruction: division
`define RMD       4'b1000 //new instruction: remainder
`define CMP     	4'b1001
`define SHF     	4'b1010
`define ROT     	4'b1011
`define JMP       4'b1100
`define HLT     	4'b1101

// Define Condition Code fields
`define CARRY 	psr[0]
`define EVEN   psr[1]
`define PARITY psr[2]
`define ZERO   psr[3]
`define NEG    psr[4]

// Define Condition Codes
`define CCC 1   // Result has carry
`define CCE 2   // Result is even
`define CCP 3   // Result is odd parity
`define CCZ 4   // Result is Zero
`define CCN 5   // Result is Negative
`define CCA 0   // Always

`define RIGHT  0 // Rotate/Shift Right
`define LEFT   1 // Rotate/Shift Left

// Function for ALU operands and result

function [WIDTH-1:0] getsrc;
input [WIDTH-1:0] in;
begin
   if (`SRCTYPE == `REGTYPE) getsrc = RFILE[`SRC] ;
   else getsrc = `SRC ;   // immediate type
end
endfunction

function [WIDTH-1:0] getdst;
input [WIDTH-1:0] in;
begin
   if (`DSTTYPE == `REGTYPE) begin
      getdst = RFILE[`DST];
  end
  else begin // immediate type
    $display("Error:Immediate data can’t be destination.");
   end
end
endfunction

// Functions / tasks for Condition Codes

function checkcond; //Returns 1 if condition code is set .
input [4:0] ccode;
begin
   case (ccode)
     `CCC : checkcond =  `CARRY ;
     `CCE : checkcond =  `EVEN ;
     `CCP : checkcond =  `PARITY ;
     `CCZ : checkcond =  `ZERO ;
     `CCN : checkcond =  `NEG ;
     `CCA : checkcond =  1; 
endcase
end
endfunction

task clearcondcode ; // Reset condition codes in PSR
begin
   psr = 0;
end
endtask

task setcondcode ; // Compute the condition codes and set PSR
input [WIDTH:0] res; //33 bit result register
begin
   `CARRY  = res[WIDTH];
   `EVEN   = ~res[0];
   `PARITY =  ^res ;
   `ZERO   = (res==33'b1000000000000000000000000000000000 || res == 33'b0000000000000000000000000000000000) ;
   `NEG    = res[WIDTH-1];
end
endtask

// Main Tasks - fetch, execute, write_result
task fetch ;   // Fetch the instruction and increment PC.
begin
  ir = MEM[pc] ;
  pc = pc + 1 ;
end 
endtask

task execute ; // Decode and execute the instruction.
begin
case(`OPCODE)
    `NOP : ;
    `BRA :	begin
                  $display("==================");
                  $display("OPCODE = BRA");
                  if (checkcond( `CCODE)  == 1) begin
                  pc = `DST;
                  $display("JUMP TO DESTINATION = LINE %d",`DST);
                  end
                  else $display("NO JUMP");
            end
    `LD  : 	begin  
                  clearcondcode ;
                  if (`SRCTYPE) RFILE[`DST] = `SRC ;
                  else RFILE[`DST]=MEM[`SRC] ;
                  setcondcode({1'b0,RFILE[`DST]}) ;
                  $display("==================");
                  $display("OPCODE = LD");
                  if(`SRCTYPE)$display("LOAD %d to REGISTER %d",`SRC,`DST);
                  else $display("LOAD %d to REGISTER %d",MEM[`SRC],`DST);
                  end
    `STR :	begin
        	    clearcondcode;    
         	      if (`SRCTYPE) MEM[`DST] = `SRC;
         	      else MEM[`DST] = RFILE[`SRC] ;
	               if (`SRCTYPE) setcondcode({21'b0,`SRC});
                  else setcondcode ({1'b0,RFILE[`SRC]});
                  $display("==================");
                  $display("OPCODE = STR");
                  if(`SRCTYPE)$display("STORE %d to MEM %d",`SRC,`DST);
                  else $display("STORE %d to MEM %d",RFILE[`SRC],`DST);
               end
    `ADD :  begin
                  clearcondcode ;
                  src1 = getsrc(ir);
                  src2 = getdst(ir);
                  result = src1 + src2;
                  setcondcode(result);
                  $display("==================");
                  $display("OPCODE = ADD");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
              end
    
    `SUB :  begin                               //subtraction
                  clearcondcode ;
                  src1 = getsrc(ir);
                  src2 = getdst(ir);
                  result = src2 - src1;
                  setcondcode(result);
                  $display("==================");
                  $display("OPCODE = SUB");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
              end
    
    `MUL :  begin
                  clearcondcode ;
                  src1 = getsrc(ir) ;
                  src2 = getdst(ir) ;
                  result = src1 * src2 ;
                  setcondcode(result) ;
                  $display("==================");
                  $display("OPCODE = DIV");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
                   
                end

    `DIV :  begin
                  clearcondcode;
                  src1 = getsrc(ir);
                  src2 = getdst(ir);
                  result = src2 / src1;
                  setcondcode(result);
                  $display("==================");
                  $display("OPCODE = DIV");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
                end

    `RMD :  begin
                  clearcondcode;
                  src1 = getsrc(ir);
                  src2 = getdst(ir);
                  result = src2 % src1;
                  setcondcode(result);
                  $display("==================");
                  $display("OPCODE = RMD");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
                end

    `CMP : begin
                   clearcondcode ;
                   src1 = getsrc(ir) ;
                   result = ~src1 ;
                   setcondcode (result) ;
                   $display("==================");
                   $display("OPCODE = CMP");
                   $display("RESULT = %b",result);
                   $display("REGISTER = %d",`DST);
               end
    `SHF : begin
                  clearcondcode ;
                  src1 = getsrc(ir) ;
                  src2 = getdst(ir) ;
                  i = src1[31:0] ;
                  result = (i[31]==0) ? (src2 >> i) : (src2 << -i) ;
                  setcondcode(result);
                  $display("==================");
                  $display("OPCODE = SHF");
                  if(i[31]==0)$display("OPCODE = DIRECTION = RIGHT");
                  else $display("OPCODE = DIRECTION = LEFT");
                  $display("RESULT = %b",result);
                  $display("REGISTER = %d",`DST);
               end
     `ROT : begin
               clearcondcode ;
               src1 = getsrc(ir) ;
               src2 = getdst(ir) ;
               dir = (src1[31] ==0) ? `RIGHT : `LEFT ;
               i = ( src1[31] ==0)?	  src1 : -src1[31:0] ;
	            while (i > 0) begin
                  if (dir == `RIGHT) begin
                     result = src2 >> 1 ;
                     result[WIDTH-1] = src2 [0] ;
                     end
                  else begin
                     result = src2 << 1 ;
                     result[0] =src2[WIDTH-1] ;
                     end
                  i= i - 1 ;
                  src2 = result ;
               end //end of while
               setcondcode(result);
               $display("==================");
               $display("OPCODE = ROT");
               if(dir == `RIGHT)$display("OPCODE = DIRECTION = RIGHT");
               else $display("OPCODE = DIRECTION = LEFT");
               $display("RESULT = %b",result);
               $display("REGISTER = %d",`DST);
	         end
   `JMP : begin
         pc = `DST;
         $display("==================");
         $display("OPCODE = JMP");
         $display("DESTINATION = LINE %d",`DST);
         end
   `HLT : begin
               $display("==================");
                $display("OPCODE = HLT");
                $stop ;
              end
   default : $display ("Error : Illegal Opcode ." );
endcase
end
endtask
// Write the result in register file or memory.

task write_result ;
begin
   if ((`OPCODE >= `ADD) && (`OPCODE < `HLT)&&(`OPCODE)!=`JMP) begin
      if(`DSTTYPE == `REGTYPE) RFILE[`DST] = result ; 
      else MEM[`DST] = result ;
   end
end
endtask 

// Debugging help

task apply_reset ;
begin
   reset = 1;
   #CYCLE
   reset = 0;
   pc = 0;
end
endtask


task disprm ;
input rm ;
input [ADDRSIZE-1:0] adr1, adr2 ;
begin
   if (rm == `REGTYPE) begin
       while (adr2 >= adr1)
		       begin
               $display("REGFILE[%d] = %d\n",adr1,RFILE[adr1]);
               adr1 = adr1 +1;
		       end
   end

   else begin
         while (adr2 >= adr1) begin  
              $display("MEM[%d]=%d\n",adr1,MEM[adr1]);
              adr1= adr1 + 1;
         end
   end
end
endtask

// Initial and always blocks
initial begin : prog_load
     $readmemb("sisc.prog",MEM);
   //   $monitor("%d %d %h %h %h",
   //   $time,pc,RFILE[0], RFILE[1], RFILE[2]) ;
     apply_reset;
end

always begin : main_process
    if (!reset) begin
       #CYCLE fetch ;
       #CYCLE execute ;
       #CYCLE write_result ;
    end
    else #CYCLE ;
 end

initial
begin
	$fsdbDumpfile("adder_b.fsdb");
	$fsdbDumpvars;
end

 endmodule
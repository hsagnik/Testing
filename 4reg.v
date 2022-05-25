module reg_4
  (input wire [3:0] d, input wire clk,en,reset, output reg [3:0] q,q0);
   always @ (posedge clk,negedge reset)
     begin
	if(reset == 0)
	  begin
	     q <= 0;
	     q0 <= 1;
	  end
	else if(en == 1)
	  begin
	     q <= d;
	     q0 <= ~d;
	  end
     end // always @ (posedge clk,negedge reset)
endmodule // 4_reg

module tg
  (output reg [3:0] d,output reg clk,en,reset, input wire [3:0] q,q0);
   integer x;
   reg [0:6] memory[0:15];
   initial
     begin: Read_Block
	$readmemb("test_in.txt",memory);
     /*#1 $readmemb("test.txt",clk);
     #1 $readmemb("test.txt",en);
     #1 $readmemb("test.txt",reset);*/
     end
   initial
     begin: Print_Block
	$monitor("d=%b clk=%b en=%b reset=%b q=%b q0=%b",d,clk,en,reset,q,q0);
	for(x=0;x<16;x++)
	  begin
	     #1 d=memory[x][0:3];
	     clk=memory[x][4];
	     en=memory[x][5];
	     reset=memory[x][6];
	  end
	#1 $finish;
     end
endmodule // tg
module wb;
   wire [3:0] d,q,q0;
   wire clk,en,reset;
   reg_4 r1(d,clk,en,reset,q,q0);
   tg tg1(d,clk,en,reset,q,q0);
endmodule // wb

module rw
  (input wire [0:31] din,input wire clk,reset,wen,ren,output wire [0:31] dout);
   reg [0:31] regis;
   always @ (posedge clk or negedge reset)
     begin
	if(!reset)
	  regis <= 0;
	else 
	  if(wen)
	    regis <= din;
     end // always @ (posedge clk or negedge reset)
   assign dout=(ren)?regis:32'bZ;
endmodule // rw
module tg
  (output reg [0:31] din,output reg clk,reset,wen,ren,input wire [0:31] dout);
   initial begin
      $monitor($time,,,"din=%x clk=%b reset=%b ren=%b wen=%b dout=%x regis=%x",din,clk,reset,ren,wen,dout,rw1.regis);
      clk=0;
      #2 din=32'hffff;
      ren=0;
      wen=0;
      reset=1;
      #2 reset=0;
      #4 reset=1;
      #2 ren=1;
      #2 wen=1;
      #2 ren=0;
      #2 $finish;
   end
   always
     begin
	#1 clk=~clk;
     end
endmodule // tg
module wb;
   wire [0:31] din,dout;
   wire        clk,reset,ren,wen;
   rw rw1(din,clk,reset,wen,ren,dout);
   tg tg1(din,clk,reset,wen,ren,dout);
endmodule // wb




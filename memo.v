module mem
  (input wire [0:7] din,input wire [0:9] add,input wire  wr,en,clk,output reg [0:7] dout);
   reg [0:7] memo [0:1023];
   always @ (posedge clk)
     begin
	if(en)
	  begin
	     if(wr)
	       begin
		  memo[add] <= din;
               end
	     else
	       dout<=memo[add];
	  end
     end
endmodule // mem
module tg
  (output reg [0:7] din,output reg [0:9] add,output reg wr,en,clk,input wire [0:7] dout);
   initial begin
      $monitor($time,,,,"din=%b add=%b wr=%b en=%b clk=%b dout=%b",din,add,wr,en,clk,dout);
      clk=0;
      din=43;
      add=32;
      en=1;
      #1 wr=1;
      #2 wr=0;
      #1 $finish;
   end
   always #1 clk=~clk;
endmodule // tg
module wb;
   wire [0:7] din,dout;
   wire [0:9] add;
   wire       wr,en,clk;
   mem mem1(din,add,wr,en,clk,dout);
   tg tg1(din,add,wr,en,clk,dout);
endmodule // wb

      

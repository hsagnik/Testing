module shift
  (input wire [0:15] din,input wire en,clk,reset,output reg [0:15] a,b,c,d,e,f,g,h);
   always @ (posedge clk or negedge reset)
     begin
	if(reset == 0)
	  begin
	     a <= 0;
	     b <= 0;
	     c <= 0;
	     d <= 0;
	     e <= 0;
	     f <= 0;
	     g <= 0;
	     h <= 0;
	  end // if (reset == 0)
	else if(en)
	  begin
	     a <= din;
             b <= a;
	     c <= b;
	     d <= c;
	     e <= d;
	     f <= e;
	     g <= f;
	     h <= g;
	  end // if (en)
     end
endmodule // shift
module tg
  (output reg [0:15] din,output reg en,clk,reset,input wire [0:15] a,b,c,d,e,f,g,h);
   integer x;
   initial begin
      $monitor($time,,,"din=%x en=%b clk=%b reset=%b a=%x b=%x c=%x d=%x e=%x f=%x g=%x h=%x",din,en,clk,reset,a,b,c,d,e,f,g,h);
      #1 din=0;
      en=1'b1;
      reset=1'b0;
      clk=1'b0;
      #1 reset=1'b1;
      clk=1'b1;
      for(x=1;x<64;x++)
	begin
	   #1 din=x;
	   clk=~clk;
	end
      #1 $finish;
   end
endmodule // tg
module wb;
   wire [0:15] din,a,b,c,d,e,f,g,h;
   wire        en,reset,clk;
   shift s1(din,en,clk,reset,a,b,c,d,e,f,g,h);
   tg tg1(din,en,clk,reset,a,b,c,d,e,f,g,h);
endmodule // wb

	

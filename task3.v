module bus
  (input wire [0:15] data,input wire clk,a_en,b_en,c_en,d_en,reset,output reg [0:15] a,b,c,d);
   always @ (posedge clk or negedge reset)
     begin
	if(reset == 0)
	  begin
	     a <= 0;
	     b <= 0;
	     c <= 0;
	     d <= 0;
	  end
	else 
	  begin
	     if(a_en)
	       a<=data;
	     if(b_en)
	       b<=data;
	     if(c_en)
	       c<=data;
	     if(d_en)
	       d<=data;
	  end // else: !if(reset == 0)
     end // always @ (posedge clk or negedge reset)
endmodule // bus
module tg
  (output reg [0:15] data,output reg clk,a_en,b_en,c_en,d_en,reset,input wire [0:15] a,b,c,d);
   integer x;
   initial begin
      $monitor($time,,,"data =%x clk=%b a_en=%b b_en=%b c_en=%b d_en=%b reset=%b a=%x b=%x c=%x d=%x",data,clk,a_en,b_en,c_en,d_en,reset,a,b,c,d);
      #1 data=0;
      clk=0;
      reset=0;
      #1 a_en=1;
      b_en=0;
      c_en=1;
      d_en=0;
      for(x=0;x<8;x++)
	begin
	   if(x==3)
	     reset=1;
	   #1  data=x;
	end
      #1 $finish;
   end // initial begin
   always
     begin
	#2 clk=~clk;
     end
endmodule // tg
module wb;
   wire [0:15] data,a,b,c,d;
   wire        clk,a_en,b_en,c_en,d_en,reset;
   bus bus1(data,clk,a_en,b_en,c_en,d_en,reset,a,b,c,d);
   tg tg1(data,clk,a_en,b_en,c_en,d_en,reset,a,b,c,d);
endmodule // wb


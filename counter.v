module count
  (input wire [0:15] c_in, input wire load,en,clk,resetb, output reg [0:15] c_out);   
   always @(posedge clk or negedge resetb)
     begin
	if(!resetb)
	  c_out <= 0;
	else if(load)
	  c_out <= c_in;
	else if(en)
	  begin
	       c_out <= (c_out+1);
	  end
     end // always @ (posedge clk or negedge resetb)
endmodule // count
module tg
  (output reg [0:15] c_in, output reg load,en,clk,resetb, input wire [0:15] c_out);
   integer x;
   initial begin;
      $monitor($time,,,"count_in=%x load=%b en=%b clk=%b reset=%b count_out=%x",c_in,load,en,clk,resetb,c_out);
      clk=0;
      #2 resetb=0;
      #6 resetb=1;
      load=1;
      en=1;
      c_in=16'hfff0;
      #2 load=0;
      #35 $finish;
   end // initial begin;
      always
	begin
	   #1 clk=~clk;
	end
   
endmodule // tg

module wb;
   wire [0:15] c_in, c_out;
   wire        load,clk,en,resetb;
   count c2(c_in,load,en,clk,resetb,c_out);
   tg tg1(c_in,load,en,clk,resetb,c_out);
endmodule // wb


   
      
	
	
      
      
   
   

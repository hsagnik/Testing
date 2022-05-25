module comp1
  (input wire in,clk,reset,output reg out);
   reg [0:1] cs,ns;
   always @ (posedge clk,negedge reset)
     begin
	if(!reset)
	  cs <= 0;
	else
	  cs <= ns;
     end
   always @ (cs or in)
     begin
	case(cs)
	     2'b00:if(in==0)
	       ns=2'b00;
	       else 
	       ns=2'b01;
	     2'b01:if(in==0)
	       ns=2'b01;
	       else
	       ns=2'b10;
	     2'b10:if(in==1)
	       ns=2'b10;
	       else
	       ns=2'b01;
	     default: ns=2'b00;
	  endcase
	end // always @ (cs or in)
      always @ (cs)
	begin
         case(cs)
	   2'b00:out=0;
           2'b01:out=1;
	   2'b10:out=0;
         endcase // case (cs)
	end
endmodule // comp1
module tg
  (output reg in,clk,reset,input wire out);
   initial begin
      $monitor($time,,,"in=%b clk=%b reset=%b out=%b cs=%b ns=%b",in,clk,reset,out,comp11.cs,comp11.ns);
      clk=0;
      reset=0;
      #0.5 in=1;
      #0.2 reset=1;
      #2 in=1;
      #2 in=0;
      #2 in=1;
      #1 $finish;
   end
   always
     begin
         #1 clk=~clk;
     end
endmodule // tg
module wb;
   wire in,clk,reset,out;
   comp1 comp11(in,clk,reset,out);
   tg tg1(in,clk,reset,out);
endmodule
   

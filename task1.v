module reg_16
  (input wire [0:31] din,input wire en,clk,reset,output reg [0:31] dout);
  always @ (posedge clk or negedge reset)
     begin
        if(reset == 0)
          begin
             dout <= 4'b0000;
	  end
        else if(en)
           begin
              dout <= din;
	   end
     end // always @ (posedge clk or negedge reset)
endmodule // reg_16
module tg
  (output reg [0:31] din,output reg en,clk,reset,input wire [0:31] dout);
   integer x;
   initial begin
      $monitor($time,,,"d_in = %x clk=%b en=%b d_out = %x",din,clk,en,dout);
      #1 din=4'b0000;
      clk=1'b1;
      en=1'b1;
      reset=1'b1;
      for(x=1;x<64;x++)
	begin
	  #1 din=x;
	   clk=~clk;
	end
      #1 $finish;
   end // initial begin
endmodule // tg
module wb;
   wire [0:31] din,dout;
   wire        clk,en,reset;
   reg_16 reg_16_1(din,en,clk,reset,dout);
   tg tg1(din,en,clk,reset,dout);
endmodule // wb

      
      
 

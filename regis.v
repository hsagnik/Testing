module reg_4
  (input wire [3:0] d,input wire clk,en,reset,output reg [3:0] q,q0);
   always @ (posedge clk or negedge reset)
   begin
      if(reset == 0)
	begin
	   q <= 4'b0000;
           q0 <= ~q;
	end
      else if(en)
	begin
	   q <= d;
           q0 <= ~d;
        end 
   end
endmodule // reg_4
module tg
  (output reg [3:0] d,output reg clk,en,reset,input wire [3:0] q,q0);
   integer x,file_1;
   reg [0:6] memory[0:15];
   initial
     begin: Read_Block
	$readmemb("test_in.txt",memory);
     end
   initial
     begin: Print_Block
	file_1=$fopen("test_out2.txt","w");
	for(x=0;x<16;x++)
	  begin
	     d=memory[x][0:3];
	     clk=memory[x][4];
	     en=memory[x][5];
	     reset=memory[x][6];
	     #1 $fdisplay(file_1,$time,,,"d=%b clk=%b en=%b reset=%b q=%b q0=%b",d,clk,en,reset,q,q0);
	  end
	#1 $finish;
	$fclose(file_1);
     end
endmodule // tg
module wb;
   wire [3:0] d,q,q0;
   wire clk,en,reset;
   reg_4 r1(d,clk,en,reset,q,q0);
   tg tg1(d,clk,en,reset,q,q0);
endmodule // wb

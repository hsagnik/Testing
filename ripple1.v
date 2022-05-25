module adder
  (input wire [0:3] a,b,input wire cin,output reg [0:3] sum,output reg carry);
   always @ (a,b,cin)
     begin
	{carry,sum}=a+b+cin;
     end
endmodule // adder
module tg
  (output reg [0:3] a,b,output reg cin,input wire [0:3] sum,input wire carry);
   integer i,x,file_1;
     initial begin
      file_1=$fopen("test_out1.txt","w");
      for(i=0;i<512;i++)
	begin
	   {cin,a,b}=i;
	    #1 $fdisplay(file_1,$time,,,"{a,b,cin}=%b %b %b {sum,carry}=%b %b",a,b,cin,sum,carry);
	end
	#1 $finish;
      $fclose(file_1);
     end
endmodule // tg1
module wb;
   wire [0:3] a,b,sum;
   wire cin,carry;
   adder ad1(a,b,cin,sum,carry);
   tg tg1(a,b,cin,sum,carry);
endmodule // wb


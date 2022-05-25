module half_adder
  (input wire a,b,output wire sum,carry);
   assign sum=a^b,carry=a&b;
endmodule // half_adder
/*module tg
  (output reg a,b,input wire sum,carry);
   initial begin
      $monitor($time,,,"{a,b}=%b %b,{sum,carry}=%b %b",a,b,sum,carry);
      #1 a=1'b0;
      b=1'b0;
      #1 b=1'b1;
      #1 a=1'b1;
      #1 b=1'b0;
      #1 $finish;
   end
endmodule // tg
module wb;
   wire a,b,sum,carry;
   half_adder dut(a,b,sum,carry);
   tg tg1(a,b,sum,carry);
endmodule // wb*/
module full_adder
   (input wire a,b,c,output wire sum,c_out);
   wire s1,c1,c2;
   half_adder h1(a,b,s1,c1);
   half_adder h2(c,s1,sum,c2);
   assign c_out=c1|c2;
endmodule // full_adder
/*module tg
  (output reg a,b,c,input wire sum,c_out);
   initial begin
      $monitor($time,,,"{a,b,c}=%b%b%b, {sum,carry}=%b%b",a,b,c,sum,c_out);
      #1 a=1'b0;
      b=1'b0;
      c=1'b0;
      #1 c=1'b1;
      #1 b=1'b1;
      #1 c=1'b0;
      #1 a=1'b1;
      #1 c=1'b1;
      #1 b=1'b0;
      #1 c=1'b0;
      #1 $finish;
   end
endmodule // tg
module wb;
   wire a,b,c,sum,c_out;
   full_adder f1(a,b,c,sum,c_out);
   tg tg1(a,b,c,sum,c_out);
 endmodule // wb*/
module ripple
  (input wire [3:0] a,b,input wire cin, output wire [3:0] s,output wire c3);
   wire c0,c1,c2;
   full_adder #1 f1(a[0],b[0],cin,s[0],c0);
   full_adder #1 f2(a[1],b[1],c0,s[1],c1);
   full_adder #1 f3(a[2],b[2],c1,s[2],c2);
   full_adder #1 f4(a[3],b[3],c2,s[3],c3);
endmodule // ripple
module tg
  (output reg [3:0] a,b,output reg cin,input wire [3:0] s, input wire c3);
   integer x;
   initial begin
      $monitor($time,,,"{a,b}=%b %b,cin=%b, sum=%b, carry=%b",a,b,cin,s,c3);
      #1 a=4'b0000;
      b=4'b1101;
      cin=1'b0;
	 for(x=0;x<15;x++)
	   begin
	      #1 a=a+1;
	   end
      #1 a=4'b1101;
      b=4'b0000;
      cin=1'b1;
      	 for(x=0;x<15;x++)
      	    begin
      	    	#1 b=b+1;
      	    end
      /*#1 b=4'b1111;
      cin=4'b1;
      #1 a=4'b0000;
      b=4'b0000;
      cin=4'b0;*/
      
      #1 $finish;
   end
endmodule // tg
module wb;
   wire [3:0] a,b,s;
   wire cin,c3;
   ripple r1(a,b,cin,s,c3);
   tg tg1(a,b,cin,s,c3);
endmodule // wb

   

   
   

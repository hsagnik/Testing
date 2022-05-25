module register
  (input wire [0:31] din,input wire clk,ren,wen,output wire [0:31] dout);
   reg [0:31] r;
   always @ (posedge clk)
     begin
	if(wen)
	  r <= din;
     end
   assign dout=(ren)?r:32'bz;
endmodule // register
module alu
  (input wire [0:31]a,b,input wire [0:2] opc,output reg [0:31] out);
   always @(a,b,opc)
     begin
	case(opc)
	  3'b000:out=a&b;
	  3'b001:out=a|b;
	  3'b010:out=~a;
	  3'b011:out=~b;
	  3'b100:out=a+b;
	  3'b101:out=-a;
	  3'b110:out=-b;
	endcase // case (opc)
     end // always @ (a,b,opc)
endmodule // alu
module datapath_1
  (input wire [0:31] mdr,input wire clk,aren,bren,tren,r1ren,r2ren,awen,bwen,twen,r1wen,r2wen,input wire [0:2] opc,output wire [0:31] r1out,r2out);
   wire [0:31] ain,bin,tin,r1in,r2in,aout,bout,tout,bus;
   assign bus=(tren)?tout:mdr;
   assign r1in=bus,r2in=bus,ain=bus,bin=bus;
          register r1(r1in,clk,r1ren,r1wen,r1out);
          register r2(r2in,clk,r2ren,r2wen,r2out);
	  register a(ain,clk,aren,awen,aout);
	  register b(bin,clk,bren,bwen,bout);
          alu #1 alu1(aout,bout,opc,tin);
          register #1 t(tin,clk,tren,twen,tout);
endmodule // datapath
module tg
  (output reg [0:31] mdr,output reg clk,aren,bren,tren,r1ren,r2ren,awen,bwen,twen,r1wen,r2wen,output reg [0:2] opc,input wire [0:31] r1out,r2out);
   initial begin
      $monitor($time,,"mdr=%d clk=%b awr=%d aout=%d bwr=%d bout=%d twr=%d tout=%d r1wr=%d r1out=%d r2wr=%d r2out=%d opcode=%b",mdr,clk,dp1.a.r,dp1.aout,dp1.b.r,dp1.bout,dp1.t.r,dp1.tout,dp1.r1.r,r1out,dp1.r2.r,r2out,opc);
   clk=0;
   tren=0;
      twen=0;
      aren=0;
      bren=0;
      bwen=0;
      twen=0;
      r1ren=0;
      r1wen=0;
      r2ren=0;
      r2wen=0;
      awen=1;
      mdr=30;
      #10 awen=0;
      bwen=1;
      mdr=25;
      #10 bwen=0;
      aren=1;
      bren=1;
      opc=3'b100;
      twen=1;
      #10 aren=0;
      bren=0;
      twen=0;
      tren=1;
      r1wen=1;
      r1ren=1;
      #10 tren=0;
      r1wen=0;
      bren=1;
      opc=3'b110;
      twen=1;
      #10 bren=0;
      twen=0;
      tren=1;
      bwen=1;
      #10 tren=0;
      bwen=0;
      aren=1;
      bren=1;
      opc=3'b100;
      twen=1;
      #10 aren=0;
      bren=0;
      twen=0;
      tren=1;
      r2wen=1;
      r2ren=1;
      #7 $finish;
      end // initial begin
   always #5 clk=~clk;
endmodule // tg
module wb;
   wire [0:31] mdr,r1out,r2out;
   wire [0:2]  opc;
   wire        clk,aren,bren,tren,r1ren,r2ren,awen,bwen,twen,r1wen,r2wen;
   datapath_1 dp1(mdr,clk,aren,bren,tren,r1ren,r2ren,awen,bwen,twen,r1wen,r2wen,opc,r1out,r2out);
   tg tg1(mdr,clk,aren,bren,tren,r1ren,r2ren,awen,bwen,twen,r1wen,r2wen,opc,r1out,r2out);
endmodule // wb


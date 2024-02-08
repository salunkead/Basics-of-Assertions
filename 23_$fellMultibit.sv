//$fell() in case of multibit value
/*
1.if there is multibit value,the $fell system task only considers the L.S.B of the expression and returns true if it changed from 1,x,z
  to 0 between the previous and current clock cycle.
2.$fell,doesnot check other bits of the expression except L.S.B bit
*/

module test;
  bit clk;
  reg [3:0]a;
  always #5 clk=~clk;
  
  initial
    begin
      a=4'b1001;
      #12;
      a=4'b1000;
      #12;
      a=4'b1011;
      #12;
      a=4'b101x;
      #12;
      a=4'b1110;
      #12;
      a=4'b111z;
      #12;
      a=4'b1100;
    end
  
  //the property ppt checks that the signal a has negative edge on every positive edge of the clock cycle
  property ppt;
    @(posedge clk) $fell(a) |-> 1'b1;
  endproperty
  
  assert property(ppt) $info("passed at t=%0t",$time);
  
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

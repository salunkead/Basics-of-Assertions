//$rose() with multibit value
/*
1.if there is multibit value,the $rose() system task only considers the L.S.B of the expression and it return true 
    if it cheanged from 0,x,z to 1 between the previous and the current clock cycle
2.the $rose() doesnot check the other bits of the expression,so it doesnot detect positive edge of the entire multibit value.
*/

//$rose() in case of mutibit value
module test;
  bit clk;
  reg [3:0]a;
  always #5 clk=~clk;
  
  initial
    begin
      a=4'b1000;
      #12;
      a=4'b1001;
      #12;
      a=4'b1011;
      #12;
      a=4'b101x;
      #12;
      a=4'b1111;
      #12;
      a=4'b111z;
      #12;
      a=4'b1101;
    end
  
  //the property ppt checks that the signal a has positive edge on every positive edge of the clock cycle
  property ppt;
    @(posedge clk) $rose(a) |-> 1'b1;
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

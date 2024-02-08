//$rose() can be assigned to continous assignment

/*
1.the syntax of $rose():-
  $rose(expression,<clocking_event>);
2.the clocking event is optional and specifies the clock edge on which the assertion is evaluated.if the clocking event is ommited,the default clocking is used
*/

module test;
  bit clk;
  reg [3:0]a;
  wire c;
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
  
  assign c=$rose(a,@(posedge clk));
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

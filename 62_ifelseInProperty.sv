//if-else operator (allowed only in property)
/*
1.if(expression) property_expr1 OR if(expression) property_expr1 else property_expr2;
*/

////signal b is asserted one clock cycle after signal a is asserted when start signal is high
//signal b is asserted two clock cycles after signal a is asserted when start signal is low
module test;
  bit clk,start,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {start,a,b}=0;
      repeat(3)@(negedge clk);
      start=1;
      @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      b=1;
      @(negedge clk);
      b=0;
      repeat(3)@(negedge clk);
      start=0;
      @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
    end
  
  property ppt;
    $rose(a)|-> if(start) ##1 $rose(b) else ##2 $rose(b);
  endproperty
  
  assert property(@(posedge clk)ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

//always in system verilog assertions
/*
1.always used in system verilog assertions to specify temporal properties that must hold true at all times
2.we can use always with range or without range
3. always property_expr (weak form)
   always[constant range expression] (strong form)
   s_always[constant range expression] (strong form)
   note:- s_always is always used with range only
*/

////as reset signal is never become one after falling edge of the reset
//it doesnot throws error
module test;
  bit clk,rst;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(5)@(negedge clk);
      rst=0;
    end
  
  property ppt;
    $fell(rst) |-> always !rst;
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
  
endmodule


///Assertion error
module test;
  bit clk,rst;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(5)@(negedge clk);
      rst=0;
      @(negedge clk);
      rst=1;
      @(negedge clk);
      rst=0;
    end
  
  property ppt;
    $fell(rst) |-> always !rst;
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
  
endmodule

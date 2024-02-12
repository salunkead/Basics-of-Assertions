//until operator in system verilog assertions
/*
1.the until operator is used to specify temporal relationship between two property expression.
2.it means that first expression must be true at every clock edge until the second expression becomes true.
3.there are four types of until operators,depending unpon they are strong or weak ,and overlapping or non-overlapping
  1.strong until (s_until):-
    the first expression must be true until the second expression is true,and there must exists a clock edge where the second expression becomes true
  2.weak until (until):-
    the first expression must be true until second expression is true,but the second expression may never be true
*/

//reset must be high until signal a becomes high -> success
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat(10)@(negedge clk);
      rst=0;
      a=1;
    end
  
  assert property(@(posedge clk) $fell(rst) |-> rst until a) //success as reset is high until a is high
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//reset must be high until signal a becomes high -> failure
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat(10)@(negedge clk);
      rst=0;
      a=0;
    end
  
  assert property(@(posedge clk) $fell(rst) |-> rst until a) //success as reset is high but signal a never become high
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//even though there is overlapping of reset and signal a,both until and s_until results into success
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat(8)@(negedge clk);
      a=1;
      repeat(2)@(negedge clk);
      rst=0;
    end
  
  until_op:assert property(@(posedge clk) $fell(rst) |-> rst until a) //sucesss
    $info("passed at t=%0t",$time);
  
  s_until_op:assert property(@(posedge clk) $fell(rst) |-> rst s_until a) //success 
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

///////////////////////////
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat(8)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      @(negedge clk);
      a=1;
      rst=0;
    end
  
  until_op:assert property(@(posedge clk) $fell(rst) |-> rst until a) //sucesss
    $info("passed at t=%0t",$time);
  
  s_until_op:assert property(@(posedge clk) $fell(rst) |-> rst s_until a) //success 
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule
    

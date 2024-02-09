///Non-consecutive repetition operator with range [= min:max],[-> min:max]
/*
1.The non-consecutive repetition operator with range [=min:max],[-> min:max] is used to check if a boolean expression is true for min to max times,but not necessarily on consecutive clock cycles.
2.it is useful when you want to verify a condition that may happen irregular,but still within a certain number of clock cycles.
3.the assertion will pass if the expression is true for min no. of clock cycles,it will not check for more repetitions.
*/

module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      a=0;
      b=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      ///////////////////success
      a=0;
      b=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      //////////////////////////success
      a=0;
      b=0;
      repeat(2)@(negedge clk);
      a=1;
      ///////////////////////fail
    end
 
    
  go_to_Op:assert property(@(posedge clk)$rose(a)|-> strong( b[->1:3] ))
     $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
    
    non_consecutiveOp:assert property(@(posedge clk)$rose(a)|-> strong( b[=1:3] ))
     $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//Non-consecutive repetition operator [=No_of_clock_cycles]
/*
1.the non-consecutive repetition operator [=n] is used to specify that the boolean expression must be true for n times,but not necessarily on consecutive clock cycles
2.By default property expression are weak in nature,even if it fails it won't show failure messeage on console.we need to make property strong by using strong qualifier
*/

//Demonstration of non-consecutive repetition operator [=n]
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
      ///////////////////success
      a=0;
      b=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      //////////////////////////fail -won't show error on console due to weak nature
    end
  
  non_consecutiveOp:assert property(@(posedge clk) $rose(a)|-> b[=2])
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #150 $finish;
    end
endmodule

////making property strong using strong qualifier
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
      ///////////////////success
      a=0;
      b=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      //////////////////////////fail
    end
  
  non_consecutiveOp:assert property(@(posedge clk) $rose(a)|-> strong(b[=2]))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #150 $finish;
    end
endmodule

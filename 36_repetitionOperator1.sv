//consecutive repetition operator [*no_of_clock_cycle]
/*
1.consecutive repetition operator is a sequence operator that indicates the sequence repeats itself a specified number of times.
2.consecutive repetition is indicated by [*no_of_clock_cycle]
*/

//if signal a is high for two consecutive clock cycles then after two clock cycles b must also be high for two consecutive clock cyles
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      a=0;
      b=0;
      @(negedge clk);
      a=1;
      b=0;
      repeat(2)@(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      repeat(2)@(negedge clk);
      b=0;
      //////////////////////////success
      a=0;
      b=0;
      @(negedge clk);
      a=1;
      b=0;
      repeat(2)@(negedge clk);
      a=0;
      b=0;
      @(negedge clk);
      b=1;
      repeat(1)@(negedge clk);
      b=0;
      ///////failure
    end
  
  consecutiveRepeat:assert property(@(posedge clk) a[*2] |-> ##2 b[*2])
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

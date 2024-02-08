//Consecutive repetition operator [*min:max]
/*
1.you can use consecutive repetition for range values when you want to check if a sequence repeats itself a minimum and maximum number of times
2.in below,code signal b can be high consecutivly for minumim two clock ticks or maximum 4 clock ticks
*/


//when a is asserted in next clock tick b should remain high for 2 to 4 clock ticks
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      a=0;
      b=0;
      @(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      repeat($urandom_range(2,4))@(negedge clk);
      b=0;
      ///////////////////////success
      @(negedge clk);
      a=0;
      @(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
      //////failure
    end
  
  consecutiveRepeatRange:assert property(@(posedge clk) $rose(a) |=> b[*2:4])
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

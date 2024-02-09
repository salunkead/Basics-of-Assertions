//Goto vs non-consecutive repetition operator
/*
1.the non-consecutive repetition operator [=] doesnot impose any restriction on the number of clock cycles after last true value of the boolean expression while goto operator does.
*/

//Demonstration of difference between non-consecutive repetition operator [=] and goto operator [->]
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b}=0;
      repeat(2)@(negedge clk);
      repeat(2)
        begin
          @(negedge clk);
          b=1;
          @(negedge clk);
          b=0;
        end
      repeat($urandom_range(1,10)) @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
    end

  nonConsOp:assert property(@(posedge clk) $rose(b) |-> b[=2] ##1 a) ///there is no restriction on no. of clock cycles after which a becomes 1
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
    GoToOp:assert property(@(posedge clk) $rose(b) |-> b[->2] ##1 a) //a must become high after one clock cycle,when b becomes high second time non-consecutively
      $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

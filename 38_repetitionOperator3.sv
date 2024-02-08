///consecutive repetition with unbounded max value i.e [*min:$] 


//a must remain high until b also becomes high
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      a=1;
      b=0;
      repeat($urandom_range(10,15))@(negedge clk);
      b=1;
      @(negedge clk);
      a=0;
      b=0;
    end
  
  consecutiveRepeatRange:assert property(@(posedge clk) $rose(a) |-> a[*1:$] ##1 $fell(b))
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

//Go to operator [->n]
/*
1.the goto operator [->n] is used to check if a boolean expression is true for n times,but not necessarily on consecutive clock cycles.
2.it is same like [=n] non-concsecutive repetition operator but slight difference
*/

//Demonstration of goto operator [->n]
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
 
    
    go_to_Op:assert property(@(posedge clk)$rose(a)|-> b[->2])
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

///making property strong using strong qualifier
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
 
    
  go_to_Op:assert property(@(posedge clk)$rose(a)|-> strong(b[->2]))
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

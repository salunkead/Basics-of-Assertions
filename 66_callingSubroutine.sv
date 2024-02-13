///subroutine attached to the expression in assert property
/*
1.what is subroutine?
  a subroutine is a piece of code that can be called from other parts of the program to perform specific task
2.in system verilog,there are two types of subroutines
  1.function
  2.task
3.in SVA,subroutine can be attached to expression in a property or sequence call or sequence expression
*/

//////////////////
module test;
  bit clk,a,b,c;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      b=1;
      @(negedge clk);
      b=0;
      c=1;
      @(negedge clk);
      c=0;
    end
  
  task display_time;
    $display("the time at which assertion check ended is t: %0t",$time);
  endtask
  
  sequence seq;
    @(posedge clk) a ##1 b;
  endsequence
  
  
  general:assert property(@(posedge clk) seq |-> ##1 (c,display_time))
      $info("passed at t=%0t",$time);
  
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

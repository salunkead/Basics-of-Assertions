//Variable delay ##[min:max]
/*
1.variable delay( ##[min:max] ):-
    1.when delay between two events or expression is variable and depends upon some condition
*/

////
////if req becomes high,gnt must also become high after 3 to 5 clock cycles

module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      req=1;
      repeat(3)@(negedge clk);
      gnt=1;
      /////////////////////////success1
      @(negedge clk);
      gnt=0;
      req=0;
      @(negedge clk);
      req=1;
      repeat(4)@(negedge clk);
      gnt=1;
      ////////////////////////success2
      @(negedge clk);
      gnt=0;
      req=0;
      @(negedge clk);
      req=1;
      repeat(5)@(negedge clk);
      gnt=1;
      /////////////////////////////success3
      @(negedge clk);
      gnt=0;
      req=0;
      @(negedge clk);
      req=1;
      repeat(3)@(negedge clk);
      gnt=0;
      ///////////////fail
    end
  
  variable_delay:assert property(@(posedge clk) $rose(req) |-> ##[3:5] $rose(gnt))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #250 $finish;
    end
endmodule

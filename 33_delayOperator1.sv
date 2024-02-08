//constant delay
/*
1.Delays can be categorized into three different types in system verilog assertions
  1.constant delay ( ##delay ):-
    1.when the delay between two events or expressionn is fixed and known in advance
  2.variable delay( ##[min:max] ):-
    1.when delay between two events or expression is variable and depends upon some condition
  3.unbounded delay( ##[min:$] ):-
    1.when the delay between two events or expressions is not specified and can be any number of clock cycles
*/

/////Example of constant delay - to define constant delay ## operator is used
////if req becomes high,gnt must also become high after 3 clock cycles

module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  task success;
    req=1;
    repeat(3)@(negedge clk);
    gnt=1;
  endtask
  
  task fail(bit req1,bit gnt1);
    req=req1;
    repeat(3)@(negedge clk);
    gnt=gnt1;
  endtask
  
  initial
    begin
      fail(1,0);
      success;
      fail(0,0);
      success;
      fail(0,0);
    end
  
  constant_delay:assert property(@(posedge clk) req |-> ##3 gnt)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

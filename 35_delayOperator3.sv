//Unbounded Delay ##[min:$]
 /*
 1.unbounded delay( ##[min:$] ):-
    1.when the delay between two events or expressions is not specified and can be any number of clock cycles
*/

////if req becomes high,gnt must also become high somewhere during simulation
module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      req=1;
      repeat($urandom_range(6,16))@(negedge clk);
      gnt=1;
      /////////////////////////success1
    end
  
  unbounded_delay:assert property(@(posedge clk) $rose(req) |-> ##[3:$] $rose(gnt))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

//what happens if gnt is not high somewhere during simulation
//it doesnot throw assertion failure
module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      req=1;
      repeat($urandom_range(6,16))@(negedge clk);
      gnt=0;
      /////////////////////////failure
    end
  
  unbounded_delay:assert property(@(posedge clk) $rose(req) |-> ##[3:$] $rose(gnt))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

    
//By default properties are weak in nature :- meaning that they donot fail if the expression never matched
//to make them strong,we nned to use strong qualifier,which means that the expression must be matched at least once,otherwise the property will fail
module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      req=1;
      repeat($urandom_range(6,16))@(negedge clk);
      gnt=0;
      /////////////////////////success1
    end
  
  unbounded_delay:assert property(@(posedge clk) $rose(req) |-> strong(##[3:$] $rose(gnt)))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule    

//$stable system task
/*
1.$stable system task returns true if the value of signal has the same value in current and previous clock cycle.
2.syntax:-
  $stable(signal_name,clock_edge);
*/
//Demonstration of $stable() system task
module test;
  bit clk,a;
  always #5 clk=~clk;
  
  initial
    begin
      repeat(10)
        begin
          @(negedge clk);
          a=$random;
        end
    end
  
  stable:assert property(@(posedge clk) $stable(a))
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

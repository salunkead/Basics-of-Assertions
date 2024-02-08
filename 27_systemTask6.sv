//$changed() system task
/*
1.$changed system task returns true,if the value of the signal is in current clock cycle is differnt than previous clock cycle 
2.in current clock tick,if value of signal a is 1 and in previous clock tick,if it is 0 then $changed will return 1
3.syntax: $changed(signal_name,clocking_edge)
*/

//Demonstration of $changed system task
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
  
  changed:assert property(@(posedge clk) $changed(a))
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

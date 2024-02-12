///the difference between until and s_untils operator
/*
1.i have used level of the signal,
  in case of delay and until operator,even though 10 clock edges are not available,it gives success
  but in case s_until operator,if 10 clock edges are not avaiable then it throws assertion error
*/

///
module test;
  bit clk,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=0;
      repeat(10)@(negedge clk);
      rst=1;
    end
  
  delay_op:assert property(@(posedge clk) ##10 rst )
    $info("passed at t=%0t",$time);
  nexttime_op:assert property(@(posedge clk) nexttime[10] rst)
      $info("passed at t=%0t",$time);
  s_nexttime_op:assert property(@(posedge clk) s_nexttime[10] rst)
      $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

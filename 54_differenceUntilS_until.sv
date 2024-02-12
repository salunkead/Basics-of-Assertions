///The difference between until and s_until operator

//reset is always high and signal a is always low
//in that case weak until doesnot throw an assertion error but s_until does throws an error
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
 
    end
  
  initial until_op:assert property(@(posedge clk) rst until a) //doesnot through an error
    $info("passed at t=%0t",$time);
  
  initial s_until_op:assert property(@(posedge clk) rst s_until a) //throws an error
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

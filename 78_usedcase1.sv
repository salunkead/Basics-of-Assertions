//////valid must be high until ready is high
module test;
  bit valid,ready,clk;
  always #5 clk=~clk;
  
  initial
    begin
      {valid,ready}=0;
      repeat(2)@(negedge clk);
      valid=1;
      repeat(2)@(negedge clk);
      ready=1;
      @(negedge clk);
      ready=0;
      valid=0;
      ///////////////////success
      {valid,ready}=0;
      repeat(2)@(negedge clk);
      valid=1;
      ready=1;
      @(negedge clk);
      ready=0;
      valid=0;
      ////////////////////success
      {valid,ready}=0;
      repeat(2)@(negedge clk);
      valid=1;
      repeat(5)@(negedge clk);
      ready=1;
      @(negedge clk);
      ready=0;
      valid=0;
      ////////////////////////////success
      {valid,ready}=0;
      repeat(2)@(negedge clk);
      valid=1;
      repeat(2)@(negedge clk);
      ready=1;
      @(negedge clk);
      ready=0;
      @(negedge clk);
      valid=0;
      //////////////failure
    end
  
  assert property(@(posedge clk) $rose(valid)|-> valid until ready ##1 $fell(valid)&&$fell(ready))
    $info("passed at t=%0t",$time);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #300 $finish;
    end
endmodule

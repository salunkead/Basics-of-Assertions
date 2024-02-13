//Concurrent Assertions in procedural block
/*
1.concurrent assertions can be used inside or outside procedural block.
2.when to use concurrent assertions in procedural block like always or initial
  1.to check that a signal is always high or low during a certain phase of a clock cycle
  2.to check that a sequence of events occures within a specified time interval or cycle count
  3.to check that a signal value changes only when another signal is active
  4.to check that a signal maintains a certain value until another signal occures.
  5.to check that a signal never violates a certain condition or constraint
*/

//////////concurrent assertion in procedural block
module test;
  bit clk,req,gnt,enb;
  always #5 clk=~clk;
  
  initial
    begin
      {req,gnt,enb}=0;
      repeat(3)@(negedge clk);
      enb=1;
      req=1;
      @(negedge clk);
      enb=0;
      req=0;
      repeat(3)@(negedge clk);
      gnt=1;
      @(negedge clk);
      gnt=0;
    end
  
  property ppt;
    req ##4 gnt;
  endproperty
  
  always@(posedge clk)
    begin
      if(enb)
        assert property(ppt) $info("passed at t=%0t",$time);
    end
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

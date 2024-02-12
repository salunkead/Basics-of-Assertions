//Frequency of the clock using local variable in system verilog assertions

module test;
  bit clk;
  always #10 clk=~clk;
  
  initial
    begin
     @(negedge clk);
      $assertoff();
    end
  
  property ppt;
    realtime t1,t2;
    (1'b1,t1=$realtime) |=> (1'b1,t2=$realtime,$display("The frequency of clock is : %0e",(10**9)/(t2-t1)));
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//Calculating no. of clock edges for which start signal is high

////////////////////////////
module test;
  bit clk,start;
  always #5 clk=~clk;
  
  initial
    begin
      start=1;
      repeat($urandom_range(10,15)) @(negedge clk);
      start=0;
    end
  
  property ppt;
    int count=0;
    $rose(start) |-> (start,count++)[*1:$] ##1 (!start,$display("The start signal is high for :",count," clock ticks"));
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

//always with range always[min:max]
/*
1.always with range specifies that a property must hold true continuously for a specified range of clock cycles
2.always[min:max] :- this means that property expression must be true for atleast min cycles and atmost max clock cycles,
  where max and min are positive integers
*/

/////a must toggle for atleast one clock cycle or at most 12 clock cycles
module test;
  bit clk,rst,a;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(5)@(negedge clk);
      rst=0;
      repeat(7)
        begin
          @(negedge clk);
          a=1;
          @(negedge clk);
          a=0;
        end
    end
  
  property ppt;
    $fell(rst) |=> always[1:12] (a==!$past(a));  
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
  
endmodule

//$rose() system task
/*
1.the $rose() system task is a build-in function that returns true if the expression inside it chenaged from 0,x,z to 1 between the previous
  and current clock cycle.
2.$rose() system task can be used to detect the rising edge/positive edge of a signal in assertions
3.$rose():- at t=5 time unit,it will reurn true as the default value of the bit data type is 0
  for single clock cycle at the begining,it will check the default value,if it is 0,x,z and in next clock cycle,if it is 1 then $rose() will return true
4.for two clock cycles,if in current clock cycle value is 1 and in previous clock cycle,if it is 0,x,z then $rose will return true
*/

module test;
  bit a,clk;
  always #5 clk=~clk;
  initial a=1;
  always #12 a=~a;
  
  //the property ppt checks that the signal a has positive edge on every positive edge of the clock cycle
  property ppt;
    @(posedge clk) $rose(a) |-> 1'b1;
  endproperty
  
  assert property(ppt) $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

/// to check whether $rose return true if there is transition from 0,x,z to 1 
module test;
  bit clk;
  reg a;
  always #5 clk=~clk;
  
  initial
    begin
      a=1;
      #12;
      a=0;
      #12;
      a=1;
      #12;
      a=1'bx;
      #12;
      a=1;
      #12;
      a=1'bz;
      #12;
      a=1;
    end
  
  //the property ppt checks that the signal a has positive edge on every positive edge of the clock cycle
  property ppt;
    @(posedge clk) $rose(a) |-> 1'b1;
  endproperty
  
  assert property(ppt) $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

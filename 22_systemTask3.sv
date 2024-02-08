//The system task $fell()
/*
1.$fell() returns true if the expression inside it changed from 1,z,x to 0 between the previous and the current clock cycle.
2.$fell() system task can be used to check negative edge of a signal in assertions
*/

module test;
  bit clk;
  reg a;
  always #5 clk=~clk;
  
  initial
    begin
      a=0;
      #3;
      a=1;
      #11;
      a=0;
      #10;
      a=1'bx;
      #10;
      a=0;
      #10;
      a=1'bz;
      #10;
      a=0;
    end
  
  property ppt;
    @(posedge clk) $fell(a) |-> 1'b1;
  endproperty
  
  assert property(ppt) $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

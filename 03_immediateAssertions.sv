//immediate assertions
/*
1.immediate assertions are used for non-temporal domain (non-temporal domain means verification of properties that are checked at a single point in time)
2.immediate assertions are useful for checking the behavior of combinational circuits
3.we cannot use poperties or sequences,which are temporal domain construct (temporal domain means verification of properties that span across multiple clock cycles)
  example of temporal domain,when req is high,gnt must be asserted after 3 clock cycles
4.immediate assertions are evaluated immediatly without waiting for variables in it's combinatorial expression to settle down.
  in below code,y=a|b is combinatorial expression
5.immediate assertions are used inside the procedural block like always,initial
*/

//code for immediate assertions
module test;
  bit a,b;
  wire y;
  
  assign y=a|b;

  //initial block to drive the input
  initial
    begin
      repeat(10)
        begin
          {a,b}=$urandom_range(0,3);
          #5;
        end
    end

  //assertion procedural block
  always@(a,b)
    begin
      assert (y==a|b)
        $info("passed at t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

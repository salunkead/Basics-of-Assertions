//////local variables in system verilog assertion

/*
1.local variables in SVA are the variables that are declared and used within sequence or property.
2.They are created for each attempt to match a sequence or property.
3.They are not accessible from outside of their scope.
4.local variables can be assigned values,can be operated on, and compared to other expressions
5.parentheses are used to group expressions and assign values to the local variables
*/

/////when request is asserted then grant must come any time during simulation
module test;
  bit clk,req,gnt;
  bit[1:0]id;
  always #5 clk=~clk;
  
  initial
    begin
      {req,gnt}=0;
      repeat(2)@(negedge clk);
      req=1;
      id=2;
      @(negedge clk);
      req=0;
      repeat($urandom_range(2,4))@(negedge clk);
      req=1;
      id=3;
      @(negedge clk);
      req=0;
      ///////////////////////////////////////////////
      repeat($urandom_range(3,6))@(negedge clk);
      gnt=1;
      id=2;
      @(negedge clk);
      gnt=0;
      repeat($urandom_range(3,6))@(negedge clk);
      gnt=1;
      id=3;
      @(negedge clk);
      gnt=0;
    end
  
  property ppt;
    logic [1:0]id1;
    ($rose(req),id1=id) |-> ##[1:$] $rose(gnt) ##0 (id1==id);
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

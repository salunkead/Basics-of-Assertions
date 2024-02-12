//nexttime operator in system verilog assertions
/*
1.the nexttime operator checks if a property holds true at some point of time
2.the nexttime operator is similar to followed operator with antecedent equal to sequence (##k)
*/

//nexttime means,##1 here a must become high after one clock cycle when rst is deasserted
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat($urandom_range(5,10))@(negedge clk);
      rst=0;
      @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
    end
  
  assert property(@(posedge clk) $fell(rst) |-> nexttime $rose(a)) //success as a is high after 1 clock cycle
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule


//here nexttime[2],means a must be high after 2 clock cycles i.e ##2
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat($urandom_range(5,10))@(negedge clk);
      rst=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
    end
  
  assert property(@(posedge clk) $fell(rst) |-> nexttime[2] $rose(a)) //success as a is high after 2 clock ticks
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

//assertion error in nexttime
module test;
  bit clk,a,rst;
  always #5 clk=!clk;
  
  initial
    begin
      rst=1;
      a=0;
      repeat($urandom_range(5,10))@(negedge clk);
      rst=0;
      repeat(3)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
    end
  
  assert property(@(posedge clk) $fell(rst) |-> nexttime[2] $rose(a)) //failure as signal a is high after 3 clock cycles
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//system task $sampled()
/*
1.$sampled() system task executes in the prepond region of the assertion evaluation cycle in system verilog
2.the prepond region is where the values of variables that are used in concurrent assertion are sampled,before the clock expressions are evaluated
3.$info() :- it executes in Reactive region of assertion evaluation cycle.the reactive region where action block are executed such as
  the pass statements,the fail statements,else statement and disable statement
*/

module test;
  bit a,clk;
  always #5 clk=~clk;
  initial a=1;
  always #5 a=~a;
  
  always@(posedge clk)
    begin
      $info("a=%b , $sampled: %b at t=%0t",a,$sampled(a),$time); //$sampled will print the value of a in prepond region and $info will give value of a in reactive region
    end
  
  assert property(@(posedge clk)a==$sampled(a)) $info("passed at t=%0t",$time);  //this assertion will always be true,because concurrent assertion use prepond region values for assertion evaluation
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

///Checkers in system verilog assertions
/*
1.checker is a way to group and reuse mutliple assertions and related code that performs a common verification task
2.checkers can be declared inside module,interface and can be instantiated or bound to design units.
3.checkers can have ports,parameters,local variables and local functions
4.checkers can be instantiated from procedural block as well as from outside procedural block
5.the formal parameters of checker can be sequence,properties.(module I/O donot allow this)
  syntax:-
    checker checker_identifier(checker port list);
    endchecker
*/

///Assertion in checker
checker check(clk,a,b,start);
  let seqExpr(a1,b1)=a1&&b1;
  
  property ppt;
    $rose(start)|-> ##1 seqExpr(a,b)
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);

endchecker


//testbench for checker
module test;
  bit clk,a,b,start;
  always #5 clk=~clk;
  check chk(clk,a,b,start);  //checker instantiated outside procedural block
  
  initial
    begin
      {a,b,start}=0;
      repeat(3)@(negedge clk);
      start=1;
      @(negedge clk);
      start=0;
      a=1;
      b=1;
      @(negedge clk);
      a=0;
      b=0;
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
  
endmodule

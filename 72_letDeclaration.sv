//The let declartion in system verilog assertion
/*
1.let declaration can be used for customization and can replace the text macros in many cases
2.the let construct has local scope unlike the `define macro that has global scope
3.a let declaration can be used to simplify complex expression or reuse common expressions in different assertions
 syntax:-
    let identifier(let port list)=expression
*/

////a simple example to demonstrate use of let declaration
module test;
  let multiply(a,b)=a*b;
  let add(a,b)=a+b;
  
  initial
    begin
      $display("multiply using let declaration : %0d",multiply(5,8));
      $display("multiply using let declaration : %0d",multiply(9,7));
      $display("addition using let declaration : %0d",add(5,8));
      $display("addition using let declaration : %0d",add(9,7));
    end

endmodule

///////use of let in system verilog assertions
module test;
  let seqExpr(a1,b1)=a1&&b1;
  bit clk,a,b,start;
  always #5 clk=~clk;
  
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
  
  property ppt;
    $rose(start)|-> ##1 seqExpr(a,b)
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
  
endmodule

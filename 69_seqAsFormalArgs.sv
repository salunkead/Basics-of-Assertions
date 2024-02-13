//Sequence as a formal argument
/*
1.we can pass sequence as an actual argument in system verilog assertions.
2.this allows us to reuse the same sequence definition for different signals or values
*/

////////////////////////////////////////////
module test;
  bit clk,a,b,c;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      b=1;
      repeat(2)@(negedge clk);
      b=0;
      c=1;
      @(negedge clk);
      c=0;
      repeat(2)@(negedge clk);
      c=1;
      @(negedge clk);
      c=0;
    end
  
  sequence seq;
    b[*2] ##1 c[=2];
  endsequence
  
  property ppt(seq1);    //sequence as a formal argument
    $rose(a) |-> ##1 seq1;
  endproperty
  
  assert property(@(posedge clk) ppt(seq))  
    $info("passed at t=%0t",$time);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

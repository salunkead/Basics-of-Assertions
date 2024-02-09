//throughout operator
/*
1.The throughout operator is used to check if a boolean expression is true for every clock cycle that a sequence is true
  syntax: <expression> throughout <sequence>
2.the requirements for throughout operator to match are:-
  1.the sequence expression must start and end
  2.the boolean expression must be true for every clock that the sequence is true
  3.the end time of the composite sequence is the end time of the sequence
3.the L.H.S of the throughout operator can be a signal or boolean expression but can not be a sequence
*/

//Demonstration of throughout operator
//when b is asserted in next cycle c must be high for two consecutive clock cycles,during this duration a must be high
module test;
  bit clk,a,b,c;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      b=1;
      @(negedge clk);
      b=0;
      c=1;
      repeat(2)@(negedge clk);
      c=0;
      @(negedge clk);
      a=0;
      ////////////////success
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      b=1;
      @(negedge clk);
      b=0;
      c=1;
      repeat(2)@(negedge clk);
      c=0;
      a=0;
      /////////////success
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      b=1;
      @(negedge clk);
      b=0;
      c=1;
      @(negedge clk);
      a=0;
      @(negedge clk);
      c=0;
      ///though sequence is true but a is not high.therefore, failure
    end
  
  sequence seq1;
    $rose(b) ##1 c[*2];
  endsequence
  
  property ppt;
    @(posedge clk) $rose(a) |-> a throughout seq1;
  endproperty
  
  assert property(ppt)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

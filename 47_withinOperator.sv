//within operator
/*
1.syntax:-
  test_sequence within ref_sequence;
2.with operator is used to check test_sequence is within the ref_sequence 
3.if test_sequence is within the ref_sequence then assertion check will pass else fails
4.smaller sequence must be within the larger sequence,larger sequence must on RHS of the within operator
*/


//Demonstration of within operator
module test;
  bit clk,a,b,c,d;
  always #5 clk=!clk;
  
  initial
    begin
      {a,b,c,d}=0;
      @(negedge clk);
      a=1;
      repeat(4)@(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      repeat(2)@(negedge clk);
      b=0;
    end
  
  initial
    begin
      repeat(2)@(negedge clk);
      c=1;
      @(negedge clk);
      c=0;
      @(negedge clk);
      c=1;
      @(negedge clk);
      c=0;
      ///
      d=1;
      @(negedge clk);
      d=0;
      @(negedge clk);
      d=1;
      @(negedge clk);
      d=0;
      ///////success
      
    end
  
  sequence ref_seq;
    a[*4] ##2 b[*2];
  endsequence
  
  sequence seq1;
    c[=2] ##1 d[=2];
  endsequence
  
  assert property(@(posedge clk) $rose(a) |-> seq1 within ref_seq)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

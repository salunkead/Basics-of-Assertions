///Boolean Operator - or
/*
1.the or operator is used to check if at least one of the two sequence expressions is true,but not necessarily at the same time.
  syntax:-
   <seq_expr1> or <seq_expr2>
2.it is necessary that both the sequences must start at the same time in case of 'or' operator.
3.when both the sequences are true then success of assertion is shown when smaller sequence becomes true
4.when both the sequence becomes false then failure message will be shown at the time when longer sequence becomes false.
*/


//Demonstration of 'or' operator
module test;
  bit clk,a,b,start;
  always #5 clk=~clk;
  
  initial
    begin
      {start,a,b}=0;
      repeat(2)@(negedge clk);
      start=1;
      a=1;
      repeat(2)@(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      repeat(2)@(negedge clk);
      b=0;
      ////////////////////////success as both the sequence becomes true
      {start,a,b}=0;
      repeat(2)@(negedge clk);
      start=1;
      a=1;
      repeat(2)@(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      repeat(1)@(negedge clk);
      b=0;
      ///////////////////////////////////success sequence 1 is true
      {start,a,b}=0;
      repeat(2)@(negedge clk);
      start=1;
      a=1;
      repeat(1)@(negedge clk);
      a=0;
      repeat(2)@(negedge clk);
      b=1;
      repeat(2)@(negedge clk);
      b=0;
      //////////////////////////////success as sequence 2 is true
      {start,a,b}=0;
      repeat(2)@(negedge clk);
      start=1;
      a=1;
      repeat(1)@(negedge clk);
      a=0;
      repeat(2)@(negedge clk);
      b=1;
      repeat(1)@(negedge clk);
      b=0;
      ////failure as both the sequence,seq1 and seq2 are false
    end
  
  sequence seq1;
    a[*2];
  endsequence
  
  sequence seq2;
    !b[*3] ##1 b[*2];
  endsequence
  
  andOp:assert property(@(posedge clk) $rose(start)|-> seq1 or seq2)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      $assertvacuousoff;
      #300 $finish;
    end
endmodule

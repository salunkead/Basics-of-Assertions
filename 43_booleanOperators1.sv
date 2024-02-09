//Boolean operator - and 
/*
1.the and operatoris used to check if two sequence expressions are true,but not necessarily at the same time
  syntax:- <sequence1> and <sequence2>
2.the requirements for the and operator to match are:
  1.both the sequences must start at the same time
  2.both sequence expression must be true
  3.the end time of the composite sequence is the end time of the expression that finishes last.(success of the assertion will be shown when longer sequence becomes true)
*/

//when start is asserted a must be high for 2 consecutive clock cycles and b must be low for 3 cosecutive clock cylces after one clock cycle b must be high for two consecutive clock cycles. 
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
      ///////////////////////////////////failure as sequence 2 becomes false
      {start,a,b}=0;
      repeat(2)@(negedge clk);
      start=1;
      a=1;
      repeat(1)@(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      repeat(2)@(negedge clk);
      b=0;
      //////////////////////////////failure as sequence 1 becomes false
    end
  
  sequence seq1;
    a[*2];
  endsequence
  
  sequence seq2;
    !b[*3] ##1 b[*2];
  endsequence
  
  andOp:assert property(@(posedge clk) $rose(start)|-> seq1 and seq2)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

//Boolean operator - not
/*
1.the not operator is used to express the non-occurrence of a sequence in system verilog assertions.
  syntax:- not <seq_expression>
*/

//when start signal is asserted then in next clock cycle ,a must not be high for two consecutive clock cycles
module test;
  bit clk,a,start;
  always #5 clk=~clk;
  
  initial
    begin
      {start,a}=0;
      repeat(2)@(negedge clk);
      start=1;
      @(negedge clk);
      start=0;
      a=1;
      repeat(2)@(negedge clk);
      a=0;
      //////////////////////////////
      {start,a}=0;
      repeat(2)@(negedge clk);
      start=1;
      @(negedge clk);
      start=0;
      a=1;
      repeat(1)@(negedge clk);
      a=0;
    end
  
  sequence seq1;
    a[*2];
  endsequence
  
  
  notOp:assert property(@(posedge clk) $rose(start)|=> not(seq1))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      $assertvacuousoff;
      #150 $finish;
    end
endmodule

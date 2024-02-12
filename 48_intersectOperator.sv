//intersect operator
/*
1.intersect operator checks if two sequences match and have same ending time
  syntax: <sequence1> intersect <sequence2>
2.starting time and ending time of both the sequence must be same
*/

//signal a is high for four consecutive clock cycles in next 2 clock cycles signal b is high for 2 consecutive clock cycles
//when signal a is high first time,signal c should be low and in next clock cycle c should be high for 2 non-consecutive clock cycles and in next clock s
//signal d should be high for 2 non-consecutive clock cycles

//intersect operator -> success
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
      ///////success as starting time and ending time of both the sequences are same
      
    end
  
  sequence ref_seq;
    a[*4] ##2 b[*2];
  endsequence
  
  sequence seq1;
    !c ##1 c[=2] ##1 d[=2];
  endsequence
  
  assert property(@(posedge clk) $rose(a) |-> seq1 intersect ref_seq)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

///////intersect operator failure
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
      repeat(2)@(negedge clk);
      d=0;
      ///////failure as starting time and ending time of seq1 and ref_seq are not same
      
    end
  
  sequence ref_seq;
    a[*4] ##2 b[*2];
  endsequence
  
  sequence seq1;
    c[=2] ##1 d[=3];
  endsequence
  
  assert property(@(posedge clk) $rose(a) |-> seq1 intersect ref_seq)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

//// intersect operator failure 2
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
      ///////failure as starting time of seq1 and ref_Seq is not same but ending time is same
      
    end
  
  sequence ref_seq;
    a[*4] ##2 b[*2];
  endsequence
  
  sequence seq1;
    c[=2] ##1 d[=3];
  endsequence
  
  assert property(@(posedge clk) $rose(a) |-> seq1 intersect ref_seq)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

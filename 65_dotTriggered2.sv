///Difference when we use .triggered in antecedent and with using .triggered in antecedent
/*
1.when we donnot use .triggered method on sequence the evaluation of the consequent starts from the first match of the sequence
2.but when we use .triggered method on sequence the evaluation of the consequent starts when endpoint of the sequence is reached
*/

/////////////////
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
      @(negedge clk);
      b=0;
      c=1;
      @(negedge clk);
      c=0;
    end
  
  sequence seq;
    @(posedge clk) a ##1 b;
  endsequence
  
  triggered:assert property(@(posedge clk) seq.triggered |-> ##1 c) 
    $info("passed at t=%0t",$time);
  
    general:assert property(@(posedge clk) seq |-> ##1 c) 
      $info("passed at t=%0t",$time);
  
  initial
    begin
      wait(seq.triggered);
      $display("end point of the sequence is matched at t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

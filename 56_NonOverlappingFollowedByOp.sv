//Difference between non-overlapping Implication operator and Non-overlapping followed by operator
/*
1.The truth table is same as given in file no. 55
*/

/////////////////
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b}=0;
      repeat(3)@(negedge clk);
      a=1;
      @(negedge clk);
      b=1;
    end
  
  Overlapping_ImplicationOp:assert property(@(posedge clk) $rose(a)|->$rose(b))
    $info("passed at t=%0t",$time);
  
    Overlapping_FollowedBy:assert property(@(posedge clk) $rose(a) #=# $rose(b))
      $info("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

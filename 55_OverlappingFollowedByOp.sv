//Diference between overlapping implication and overlapping followed by operator

/*
1.Truth table of Overlapping Implication Operator ( |-> )
   
   antencedent  consequent    Result
   --------------------------------------
      F            F          Vacuous success
      F            T          Vacuous success
      T            F              F
      T            T              T

2.Truth Table of Overlapping Followed by operator

  antecedent    consequent    Result
 -------------------------------------
     F              F           F
     F              T           F
     T              F           F
     T              T           T

*/

//Difference between overlapping implication and overlapping followed By operator
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b}=0;
      repeat(3)@(negedge clk);
      a=1;
      b=1;
    end
  
  Overlapping_ImplicationOp:assert property(@(posedge clk) $rose(a)|->$rose(b))
    $info("passed at t=%0t",$time);
  
  Overlapping_FollowedBy:assert property(@(posedge clk) $rose(a) #-# $rose(b))
      $info("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

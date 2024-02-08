//Overlapping implication operator
/*
1.There two types of implication operators in system verilog assertions
  1.Overlapping implication operator ( -> )
  2.Non-Overlapping implication operator ( |=> )
2. L.H.S |-> R.H.S or L.H.S |=> R.H.S
   The L.H.S of implication operator is called antecedent and R.H.S of implication operator is called consequent
   Truth Table of Implication Operator:-
   antecedent    consequent   Result
      true         true        true
      true         false       false
      false        true        vacuous success
      false        false       vacuous success
3.Overlapping implication operator:- when antecedent is true then consequent is evaluated in same clock tick
4.Non-overlapping implication operator:- when antecedent is true then consequent is evaluated in next clock tick 

*/

///when req is high then gnt must be high in same clock tick (use of overlapping implication operator)
module test;
  bit req,gnt,clk;
  always #5 clk=~clk;
  task success;
    req=1;
    gnt=1;
    #12;
  endtask
  task fail;
    req=0;
    gnt=0;
    #12;
    req=1;
    gnt=0;
    #12;
    req=0;
    gnt=1;
  endtask
  
  initial
    begin
      repeat(2)fail;
      success;
      fail;
      repeat(2)success;
      fail;
      repeat(2)success;
    end
  
  overlapping:assert property(@(posedge clk) req |-> gnt)
      $info("pass at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

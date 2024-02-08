//Filtering Vacuous success
/*
1.when vacuous success occurs?
  when antecedent is false regardless of consequent the implication is true
  antecedent     consequenct  result
    false          true        vacuous success (v.s)
    false          false       vacuous success (v.s)
2.when antecedent becomes false,the consequent is not checked at all,and the implication is considered to be true by default
3.the vacuous success can be misleading or undesired in some cases.
4.to avoid vacuous success,we can use ststem task '$assertvacuousoff();'
*/

//when req is high then in same clock cycle gnt signal must be high
//without $assertvacuousoff();
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


    
/////with $assertvacuousoff() - we filtered vacuous success    
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
      $assertvacuousoff();  ///////
      #200 $finish;
    end
endmodule

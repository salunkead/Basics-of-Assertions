//a simple difference between implication operator and implies operator 

/*
notes :
in case s1 |-> s2 , the evaluation of s2 starts at the match of s1
once antecedent becomes true then we go to check consequent 

but in case of implies both L.H.S and R.H.S starts evaluating at the same time
it won't wait for L.H.S to become true 
parallel checking of L.H.S and R.H.S in case of implies operator
*/
module top;
  logic a,b,clk;
  
  initial
    begin
      clk=1'b0;
      a=0;
      b=0;
      @(negedge clk);
      a=1;
      b=1;
      repeat(3)@(negedge clk);
      b=0;
      a=0;
    end
  
  sequence s1;
    $rose(a) ##0 a[*2];
  endsequence
  
  sequence s2;
    b[*3];
  endsequence
  
  with_implies:assert property(@(posedge clk) s1 implies s2)
      $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
    
    with_implication_op:assert property(@(posedge clk) s1 |-> s2)
      $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
      
  always #5 clk=~clk;
  

  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

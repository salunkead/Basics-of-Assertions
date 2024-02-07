///concurrent assertions
/*
1.concurrent assertions can be used to check the behavior of the design over period of time,usually spanning multiple clock cycles.
2.concurrent assertions are useful for verifying temporal behavior of the design,such as a signal is high for two consecutive clock cycles then after 4 clock cyles other signal must be high for two consecutive clock cylces
3.syntax:- label:assert property(@(event) disable iff(condition) property_expression) else action_block;
 label:- is an optional identifier that names the assertion
 @(event) :- is the mandatory argument that specifies the clock or the signal that triggers the property
 disable iff(condition):- is an optional argument that specifies condition that disables property evaluation
 property_expression:- it specifies temporal logic or rule that design must follow.
 action_block:- it specifies action to be taken uopn failure such as an error,warning etc
4.concurrent assertions can be written inside or outside procedural block
*/


////req signal must be high for 2 consecutive clock cycles then after 4 clock cycles resp must be high for 2 consecutive clock cycles
module test;
  bit clk,req,resp;
  always #5 clk=~clk;
  
  initial
    begin
      repeat(5)
        begin
          req=0;
          resp=0;
          @(negedge clk);
          req=1;
          repeat(2)@(negedge clk);
          req=0;
          repeat(3)@(negedge clk);
          resp=1;
          repeat(2)@(negedge clk);
          resp=0;
        end
    end
  
  A1:assert property(@(posedge clk) req[*2] |-> ##4 resp[*2])  //it is evaluated at each clock cycle
      $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
 initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #430 $finish;
    end
endmodule

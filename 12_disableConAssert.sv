//Disabling concurrent assertions
/*
1.assert property(@(event) disable iff(condition) property_expression)
  ex:- assert property(@(posedge clk) disable iff(!rst) property_expression)  -> disables assertion check when rst signal is low
*/

module test;
  bit en,rst,clk;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      en=1;
      #12;
      rst=0;
      en=0;
      #12;
      rst=1;
      en=1;
      #12;
      rst=0;
      en=1;
      #12;
      rst=1;
      en=0;
    end
  
  disable1:assert property(disable iff(!rst) rst |-> en) $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

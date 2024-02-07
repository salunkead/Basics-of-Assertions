//clock edges on which concurrent assertions can work
/*
1.valid clock edges allowed in concurrent asertions 1. posedge 2.negedge 3. edge (on both edges)
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
  
   posedge1:assert property(@(posedge clk) rst |-> en) $info("passed at t=%0t",$time);
   negedge1:assert property(@(negedge clk) rst |-> en) $info("passed at t=%0t",$time);
   bothedge:assert property(@(edge clk) rst |-> en ) $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

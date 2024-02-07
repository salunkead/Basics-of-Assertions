//Default clocking in SVA
/*
1.a default clocking block is a clocking block that can be used to specify the clock and timming for assertions without explicitly mentioning them
2.a default clocking can be declared using keyword default before cloking keyword
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
  
  clocking cb1
    @(posedge clk);
  endclocking
   
  default clocking cb1;
  
  posedge1:assert property( rst |-> en) $info("passed at t=%0t",$time);//we can write assertions without mentioning clock edge explicitly
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

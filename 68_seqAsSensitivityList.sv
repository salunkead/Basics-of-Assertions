////sequence as sensitivity event

///using sequence as an event trigger for always block .
///triggers only when the sequence matches
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
    @(posedge clk) $rose(b) ##1 $rose(c);
  endsequence
  
  assert property(@(posedge clk) $rose(a)|->##1 seq);
  
  always@(seq)
    begin
      $display("displays the time at which sequence succeeds t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

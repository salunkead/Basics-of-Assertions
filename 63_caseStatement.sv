///case statement inside property

//////////////////////////////
module test;
  bit clk,start,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {start,a,b}=0;
      repeat(3)@(negedge clk);
      start=1;
      @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      b=1;
      @(negedge clk);
      b=0;
      repeat(3)@(negedge clk);
      start=0;
      @(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
    end
  
  property ppt;
    $rose(a)|-> 
    case(start)
      1:##1 $rose(b);
      0:##2 $rose(b);
    endcase
  endproperty
  
  assert property(@(posedge clk)ppt)
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

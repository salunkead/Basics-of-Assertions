///checkers can be instantiated from initial or always procedural block
///there is no output port in checker

checker check(clk,a,b,start,rst); //by default all the ports of checkers are input
  
  let seqExpr(a1,b1)=a1&&b1;
  
  property ppt;
    $rose(start)|-> ##1 seqExpr(a,b)
  endproperty
  
  assert property(@(posedge clk) ppt)
    $info("passed at t=%0t",$time);

endchecker

//testbench for checker
module test;
  bit clk,a,b,start,rst;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b,start}=0;
      rst=1;
      repeat(3)@(negedge clk);
      rst=0;
      start=1;
      @(negedge clk);
      start=0;
      a=1;
      b=1;
      @(negedge clk);
      a=0;
      b=0;
    end
  
  always@(posedge clk)
    begin
      if(!rst)
        begin
          check chk(clk,a,b,start,rst);
        end
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
  
endmodule

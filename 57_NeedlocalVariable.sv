///Need of local variables in system verilog assertions
///we donot need local variable here
module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      repeat(3)
        begin
          {req,gnt}=0;
          repeat(2)@(negedge clk);
          req=1;
          @(negedge clk);
          req=0;
          repeat($urandom_range(3,6))@(negedge clk);
          gnt=1;
          @(negedge clk);
          gnt=0;
        end
    end
  
  assert property(@(posedge clk) $rose(req)|-> ##[1:$] $rose(gnt))
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #300 $finish;
    end
endmodule

///if one request is followed by another request,and after second request if there are two grants followed by another grant 
//then assertion doesnot check intended behavior
//in such a cases,we need local variable
module test;
  bit clk,req,gnt;
  always #5 clk=~clk;
  
  initial
    begin
      {req,gnt}=0;
      repeat(2)@(negedge clk);
      req=1;
      @(negedge clk);
      req=0;
      repeat($urandom_range(2,4))@(negedge clk);
      req=1;
      @(negedge clk);
      req=0;
      repeat(2)
        begin
          repeat($urandom_range(3,6))@(negedge clk);
          gnt=1;
          @(negedge clk);
          gnt=0;
        end
    end
  
  assert property(@(posedge clk) $rose(req)|-> ##[1:$] $rose(gnt))
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #200 $finish;
    end
endmodule

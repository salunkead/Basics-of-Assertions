//a simple check using system verilog,when req is asserted gnt must asserted after four clock cycles

//system verilog code to check this property
module test;
  bit req,gnt,clk;
  always #5 clk=~clk;
  initial
    begin
      req=0;
      gnt=0;
      @(negedge clk);
      req=1;
      @(negedge clk);
      req=0;
      repeat(3)@(negedge clk);
      gnt=1;
    end
  
  always@(posedge clk)
    begin
      if(req==1'b1)
        begin
          repeat(4)@(posedge clk);
          if(gnt==1'b1)
            $info("passed at t=%0t",$time);
          else
            $error("failed at t=%0t",$time);
        end
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

//system verilog assertion code
/*
1.SVA based codes are more concise and easy to understand
2.they can be turned ON or OFF during simulation
3.the number of lines of code is reduced in SVA
*/

module test;
  bit req,gnt,clk;
  always #5 clk=~clk;
  initial
    begin
      req=0;
      gnt=0;
      @(negedge clk);
      req=1;
      @(negedge clk);
      req=0;
      repeat(3)@(negedge clk);
      gnt=1;
    end
  
  assert property(@(posedge clk) req |-> ##4 gnt)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule


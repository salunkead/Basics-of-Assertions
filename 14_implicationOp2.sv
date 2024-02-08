//Non-overlapping implication operator (|=>)

//when req is high in next clock cycle gnt must be high
module test;
  bit req,gnt,clk;
  always #5 clk=!clk;
  
  task success;
    req=1;
    @(negedge clk);
    gnt=1;
  endtask
  
  task fail;
    @(negedge clk);
    req=0;
    @(negedge clk);
    gnt=0;
    ////////////////////////
    @(negedge clk);
    req=1;
    @(negedge clk);
    gnt=0;
    ///////////////////////
    @(negedge clk);
    req=0;
    @(negedge clk);
    gnt=1;
  endtask
  
  initial
    begin
      repeat(2)fail;
      success;
      fail;
      repeat(2)success;
      fail;
      repeat(2)success;
    end
  
  Non_overlapping:assert property(@(posedge clk) req |=> gnt)
      $info("pass at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

//eventually operator in system verilog assertions
/*
1.success and failure of eventually operator:-
  1.if the no of clock cycles are within the simulation time and if a doesnot become eventually then eventually operator throws 
    assertion error
  2.if the no. of clock cycles are not within the range then eventually operator doenot commit anything
  3.in below code, $finish is called at t=200 time unit,no of clock ticks available are 200/10=20
*/

//success and failure of eventually operator
module test;
  bit clk,a;
  always #5 clk=!clk;
  
  initial
    begin
      a=0;
      //repeat($urandom_range(5,18))@(negedge clk);
    end
  
  initial assert property(@(posedge clk) eventually[1:15] a) //within range of max 20 clock cycles.therefore throws error
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule


//eventually operator doesnot commit anything,i.e it doesnot throw error
module test;
  bit clk,a;
  always #5 clk=!clk;
  
  initial
    begin
      a=0;
      //repeat($urandom_range(5,18))@(negedge clk);
    end
  
  initial assert property(@(posedge clk) eventually[1:25] a) //max clock ticks are 25 therefore,eventually operator doesnot throws assertion error
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

/////
module test;
  bit clk,a;
  always #5 clk=!clk;
  
  initial
    begin
      a=0;
      //repeat($urandom_range(5,18))@(negedge clk);
    end
  
  initial assert property(@(posedge clk) s_eventually[1:25] a)  //s_eventually throws an error as it is strong form of eventually 
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

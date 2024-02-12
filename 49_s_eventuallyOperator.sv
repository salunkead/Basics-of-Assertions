//s_eventually operator in system verilog assertions
/*
1.the eventually operator in system verilog assertions checks if a property holds true at some point of time in the future
2.for example,evenetually p means that the property p must must be true at some clock cyles after the current clock cycle.
3.eventually operator can also specify a clock cycle delay range such as eventually[2:5] p,which means that the property p must 
  be true at some clock cycles between 2 to 5 cycles after the current one
4. there are two forms of eventually operator 
    1.eventually:- it is a weak in nature   2.s_eventually:- it is a strong in nature
*/

//signal a must be high somewhere during simulation
module test;
  bit clk,a;
  always #5 clk=!clk;
  
  initial
    begin
      a=0;
      repeat($urandom_range(5,18))@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
    end
  
  initial assert property(@(posedge clk) s_eventually (a)) //successs
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule

///failure - as a is not high during entire simulation
module test;
  bit clk,a;
  always #5 clk=!clk;
  
  initial
    begin
      a=0;
      repeat($urandom_range(5,18))@(negedge clk);
    end
  
  initial assert property(@(posedge clk) s_eventually a) 
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
      #200 $finish;
    end
endmodule











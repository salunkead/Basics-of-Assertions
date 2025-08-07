//a named property is recursive if it's declaraton involves instantiation of itself
 
//example: instead of always i have used recursive property 
module test;
  bit clk=0,rst;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(5) @(negedge clk);
      rst=0;
      
      repeat(3)@(negedge clk);
      rst=1;
    end
  
  property p;
    !rst and (1'b1 |=> p);//we can use recursive property instead of always operator
    //due to and operator, recursion call will proceed
    //note to add and operator while using recursion
  endproperty
  
  initial
    begin
      without_always:assert property(@(posedge clk) rst[*5] |=>  p)
        $info("passed at t=%0t",$time);
        
        with_always:assert property(@(posedge clk) rst[*5] |=> always !rst)
          $info("passed at t=%0t",$time);
    end
  
 
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

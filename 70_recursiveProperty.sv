//Recursive property in system verilog assertions
/*
1.a recursive property in system verilog assertion is a property that calls itself within it's own definition.
2.a recursive property must include some time interval to avoid infinite recursion.
*/

//Recursive property
module test;
  bit clk,rst;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(3)@(negedge clk);
      rst=0;
    end
    
  property ppt;    //calling property inside property
    !rst and (1'b1 |=> ppt); //non-overlapping operator is neccessary
  endproperty
  
  assert property(@(posedge clk) $fell(rst) |=> ppt)  
    $info("passed at t=%0t",$time);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

//event control as formal argument
module top;
  bit clk,a,b;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b}=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      @(negedge clk);
      b=1;
      @(negedge clk);
      b=0;
    end
  
  property ppt(event1,a1,b1);
    @(event1) $rose(a1) |-> nexttime[2] $rose(b1);
  endproperty
  
  assert property(ppt(posedge clk,a,b))  //ou can pass event control as an actual argument
    $info("passed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule
    

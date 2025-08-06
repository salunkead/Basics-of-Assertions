//iff (if and only if) operator 

/*

notes :
p1 iff p2 is an equivalence operator.
this property is true iff properties p1 and p2 both are true

*/

//example:-

property p;
  @(posedge clk)
  (a iff enable) |-> b;
endproperty
/*
here a is only considered if enable == 1
if the enable ==0, the left hand side of the implication is not triggered, so the implication doesnot evaluate.
*/

//example-2
module top;
  logic a,b,clk;
  
  initial
    begin
      clk=1'b0;
      a=0;
      b=0;
      @(negedge clk);
      a=1;
      b=1;
      repeat(3)@(negedge clk);
      b=0;
      a=0;
    end
  
  property p1;
    a[*2];
  endproperty
  
  property p2;
    b[*3];
  endproperty
  
  iff_operator:assert property(@(posedge clk) $rose(a) |-> p1 iff p2)
      $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
    
      
  always #5 clk=~clk;
  

  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

/*
1. $rose() with delay (##)  --> Yes
2. $rose() with logical operator  --> Yes
3.  why a[*4] && $fell(a) is not valid ?
In SVA, a[*4] is a sequence repetition operator -> it creates sequence
$fell(a) is a boolean expression, not a sequence
the && operator is a logical operator and it expects boolean expression , not sequence
so when you are trying to logically combine a sequence with a[*4] with the a boolean ,which is not allowed in SVS synatx.

we need to use it using a cycle delay operator (##n)
*/

module top;
  bit clk,a,b,c,d;
  
  initial
    begin
      {a,b,c,d}=4'd0;
      repeat(3) @(posedge clk);
      a=1'b1;
      repeat(3) @(posedge clk);
      b=1'b1;
      repeat(4) @(posedge clk);
      b=1'b0;
      c=1'b1;
      repeat(4) @(posedge clk);
      c=1'b0;
      d=1'b1;
      repeat(4) @(posedge clk);
      d=1'b0;
    end
  
  always #5 clk=~clk;
  
  property p;
    $rose(a) |-> ##3 $rose(b) ##0 b[*4] ##1 $fell(b) ##0 $rose(c) ##0 c[*4] ##1 $fell(c) ##0 $rose(d) ##0 d[*4];
  endproperty

  //or 
  property p;
    $rose(a) |-> ##3 $rose(b)|-> b[*4] |=> $fell(b) |-> $rose(c) |-> c[*4] |=> $fell(c) |-> $rose(d) |-> d[*4];
  endproperty
  
  assert property(@(posedge clk) p)
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

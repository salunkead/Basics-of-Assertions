///Passing arguments to property and sequence
/*
1.Arguments are useful for making sequences and properties more flexible and resuable,as they allow us to specify different values.
2.arguments can be declared in the parentheses after the sequence or property name and they can have different types,directions
3.arguments can be passed to sequence or property.
4.arguments can have default values,which are used when no arguments are passed
*/

//when rst signal is low,in same cycle c and d must be high and after one clock cycle a=1 and b=0
module test;
  bit rst,a,b,c,d,clk;
  always #5 clk=~clk;
  
  task success;
    @(negedge clk);
    rst=0;
    c=1;
    d=1;
    @(negedge clk);
    a=1;
    b=0;
  endtask
  
  task fail1;
    @(negedge clk);
    rst=1;
    c=1;
    d=1;
    @(negedge clk);
    a=1;
    b=0;
  endtask
  
  task fail2;
    @(negedge clk);
    rst=0;
    c=0;
    d=1;
    @(negedge clk);
    a=1;
    b=0;
  endtask
  
  task fail3;
    @(negedge clk);
    rst=0;
    c=1;
    d=1;
    @(negedge clk);
    a=1;
    b=1;
  endtask
  
  initial
    begin
      fail1;
      success;
      fail2;
      success;
      fail3;
      success;
    end
  
  sequence seq(logic a1,logic a2);
    (a1==1 && a2==0);
  endsequence
  
  property ppt(logic c1,logic d1);
    (c1&&d1) |-> ##1 seq(a,b);
  endproperty
  
  assert property(@(posedge clk) !rst |-> ppt(c,d))
      $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
    
    initial
      begin
        $dumpfile("dump.vcd");
        $dumpvars;
        $assertvacuousoff;
        #200 $finish;
      end
endmodule

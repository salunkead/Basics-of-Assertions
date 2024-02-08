///Sequence and property construct in concurrent assertions
/*
1.sequence construct :- 
  1.a sequence is a series of boolean expression that specify the order and timming of events that form a property
  2.a sequence can be matched by single or multiple clock cycles depending on expression and operators used.
  3.operators used in sequence as follows:-
    1.logical operators (&&,||,!)
    2.Relational Operators (>,<,>=,<=,==)
    3.arithmatic operators (+,-,*,/)
      example:-  sequence seq;
                   @(posedge clk) x+y==z;
                 endsequence
    4.timming operators (##,[*],[=],[->])

2.property construct:-
  1.a property is a statement that describes the expected behvior of the design using one or more sequences
  2.a property can be checked by an assert statement,which reports an error if the property is violated.
  3.operators that are used inside sequence can be used inside property.
  4.implication operators can only be used inside property construct only
*/

//when a is high then after two clock cycles b must be high
module test;
  bit a,b,clk;
  
  always #5 clk=~clk;
  
  task success;
    a=1;
    repeat(2)@(negedge clk);
    b=1;
  endtask
  
  task fail1;
    a=1;
    repeat(2)@(negedge clk);
    b=0;
  endtask
  
  task fail2;
    a=0;
    repeat(2)@(negedge clk);
    b=1;
  endtask
  
  task fail3;
    a=0;
    repeat(2)@(negedge clk);
    b=0;
  endtask
  
  initial
    begin
      fail1;
      fail2;
      success;
      fail3;
      success;
      fail2;
      success;
      fail1;
      success;
    end
  
  //sequence seq_1 checks that the signal a is high on every positive edge of the clock
  sequence seq_1;
    @(posedge clk) a==1;
  endsequence
  
  //property p_1 checks that signal b is high two clock cycles after the seq_1 is matched
  property p_1;
    @(posedge clk) seq_1 |-> ##2 b;
  endproperty
  
  check:assert property(p_1)
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

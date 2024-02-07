//Observed deferred immediate assertion
/*
1.the problem with simple immediate assertion is that they are evaluated immediately without waiting for variables in it's combinatorial expression to settle down
  due to this simple immediate assertions prone to glitches as the combinatorial expression settle down and may fire multiple times. 
2.we can use Observed immediate assertion to overcome the problem associated with the simple immediate assertion
3.observed deffered immediate assertion are evaluated in 'reactive region' when all the variables in combinatorial expression settles down.
4.observed deffered immediate assertion use #0 after assert i.e assert #0
*/

///in below code,simple immediate assertion is used and there is glitch at t=0 time unit
module test;
  logic a,b,cin,sum,cout;
  
  assign {cout,sum}=a+b+cin;

  //initial block to apply inputs to a,b and cin
  initial
    begin
      for(int i=0;i<15;i++)
        begin
          {a,b,cin}=i;
          #5;
        end
    end

  //assertion procedural block 
  always_comb
    begin
      assert (sum==(a^b^cin) && cout==((a&b)|(a&cin)|(b&cin)))  //simple immediate assertion
        $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule


//////The use of observed deffered immediate assertion
module test;
  logic a,b,cin,sum,cout;
  
  assign {cout,sum}=a+b+cin;

  //initial block to apply inputs to a,b and cin
  initial
    begin
      for(int i=0;i<15;i++)
        begin
          {a,b,cin}=i;
          #5;
        end
    end

  //assertion procedural block 
  always_comb
    begin
      assert #0 (sum==(a^b^cin) && cout==((a&b)|(a&cin)|(b&cin)))  /// observed deffered immediate assertion
        $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

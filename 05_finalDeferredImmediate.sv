//Final deferred immediate assertions
/*
1.syntax: assert final()
2.the final deferred immediate assertions are evaluated in postpone region
3.the observed deferred immediate assertions are prone to glitches when there is PLI (Programming Language Interface) call that may change the values of the variables
4.to avoid this problem,we do use final deferred immediate assertion which are evaluated in postponed region after all PLI calls have completed
*/

/////////////
module test;
  logic a,b,cin,sum,cout;
  
  assign {cout,sum}=a+b+cin;
  
  initial
    begin
      for(int i=0;i<15;i++)
        begin
          {a,b,cin}=i;
          #5;
        end
    end
  
  always_comb
    begin
      assert final (sum==(a^b^cin) && cout==((a&b)|(a&cin)|(b&cin)))
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

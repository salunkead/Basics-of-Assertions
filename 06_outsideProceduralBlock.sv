//Deferred immediate assertions can be written outside procedural block
/*
1. Both observed deferred immediate assertions and final deferred immediate assertions can be written outside procedural block
2. assert #0() and assert final() can be written outside procedural block for combinational circuits
3. they must be written inside procedural block for sequential circuits
4. simple immediate assertions must be written inside procedural block only,they cannot be written outside procedural block ( assert() )
*/

////////////
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
  
  assert final(sum==(a^b^cin) && cout==((a&b)|(a&cin)|(b&cin)))
    $info("passed at t=%0t",$time);
  else
    $error("failed at t=%0t",$time);
  
  /*
  assert #0(sum==(a^b^cin) && cout==((a&b)|(a&cin)|(b&cin)))
    $info("passed at t=%0t",$time);
  else
    $error("failed at t=%0t",$time);
  */
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

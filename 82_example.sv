//Q.when b is high then a should toggle 4 times
module test;
  bit clk,a,b;
  always #5 clk=~clk;
  initial
    begin
      repeat(2)@(posedge clk);
      b=1;
      repeat(5)
        begin
          @(posedge clk);
          a=~a;
        end
      b=0;
      a=0;
    end
  
  sequence seq;
    ((a==1 || a==0) ##1 ~$past(a));
  endsequence
  
  assert property(@(posedge clk) $rose(b)|-> b throughout seq[*2])
    $info("passed at t=%0t",$time);
                  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

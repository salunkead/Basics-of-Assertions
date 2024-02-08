//$past with gating signal

/*
1.syntax:-
  $past(signal,no. clock tick ,gating expression,edge);
*/

///////////
module test;
  bit clk,gate;
  always #5 clk=~clk;
  always #12 gate=~gate;
  bit[3:0]a;
  
  initial
    begin
      for(int i=0;i<16;i++)
        begin
          @(negedge clk);
          a=i;
        end
    end
  
  always@(posedge clk)
    begin
      $display("one clock cycle past value of a is : %0h at t=%0t",$past(a,1,gate),$time);
      ///if the gate signal is 1 in previous cycle then only $past function will return value
      ///if the gate signal is 0 in previous cycle then it will display the value which was captured when gate signal was 1
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

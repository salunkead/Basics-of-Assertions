//$past() system task
/*
1.$past system task is used to reference the past value of signal.
2.it allows you to check the value of the signal in a previous clock cycle or at specified past time.
3.syntax of $past:-
  $past(signal_name,no_of_clock,gating_signal,clocking_event);
  1.signal_name:- name of the signl whose past value is to be found.
  2.no_clock_cycle:- it is the number of clock cycle to go past in simulation.
    default clock cycle is 1
  3.gating signal:- if gating signal expression is true then only $past will be evaluated
  4.clocking event :- the edge on which $past function to be evaluated
*/

////one cycle and two cycle past value of signal a
module test;
  bit clk;
  always #5 clk=~clk;
  bit[3:0]a;
  
  initial
    begin
      repeat(10)
        begin
          a=$urandom_range(0,15);
          @(negedge clk);
        end
    end
  
  always@(posedge clk)
    begin
      $display("one clock cycle past value of a is : %0h at t=%0t",$past(a),$time);
      $display("two clock cycle past value of a is : %0h at t=%0t",$past(a,2),$time);
      $display("------------------------------------------------------------------");
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule


  

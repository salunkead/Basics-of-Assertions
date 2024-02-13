//.triggered method on sequence
/*
1.the method triggered is used to test whetger a sequence has reached its end point at a particular point in time.
  syntax:-
    sequence_instance.triggered,where triggered is a method on a sequence.the result is true or false
2.an endpoint of a sequence is reached whenever the ending clock tick of a match of the sequence is reached,regardless of the starting tick of the match
*/

/////
module test;
  bit clk,a,b,c;
  always #5 clk=~clk;
  
  initial
    begin
      {a,b,c}=0;
      repeat(2)@(negedge clk);
      a=1;
      @(negedge clk);
      a=0;
      b=1;
      @(negedge clk);
      b=0;
      c=1;
      @(negedge clk);
      c=0;
    end
  
  sequence seq;
    @(posedge clk) a ##1 b ##1 c;
  endsequence
  
  initial
    begin
      wait(seq.triggered);
      $display("end point of the sequence is matched at t=%0t",$time); //endpoint of the sequence is reached when c is true,regardless of when a and b where true 
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

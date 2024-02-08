//$countones() system task
/*
1.$countones() system task returns no. of 1's present in multibit variable
2.syntax:-
  $countones(expression)
*/

module test;
  reg [3:0]a;
  
  initial
    begin
      a=4'b1110;
      $display("no. of 1's in a is %0d",$countones(a));
      $display("---------------------------------------------------");
      #1;
      a=4'b110x;
      $display("no. of 1's in a is %0d",$countones(a));
      $display("---------------------------------------------------");
      #1;
      a=4'b01xx;
      $display("no. of 1's in a is %0d",$countones(a));
      $display("---------------------------------------------------");
      #1;
      a=4'b10zz;
      $display("no. of 1's in a is %0d",$countones(a));
      $display("---------------------------------------------------");
      #1;
      a=4'b0000;
      $display("no. of 1's in a is %0d",$countones(a));
    end
endmodule

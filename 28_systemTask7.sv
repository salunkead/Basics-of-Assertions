//$onehot() and $onehot0() system task
/*
1.if any single bit in a multibit variable is '1' then $onehot() or $onehot0 returns 1 else it will return 0
2.the main difference between $onehot and $onehot0 is
  for 4'b000 -> $onehot returns '0' and $onehot0() returns 1 except everything is same in case of $onehot and $onehot0
*/

//Demonstration of $onehot() and $onehot0()
module test;
  bit [3:0]a;
  
  initial
    begin
      a=4'b0000;
      $display("value of $onehot() : %b at t=%0t",$onehot(a),$time);
      $display("value of $onehot0() : %b at t=%0t",$onehot0(a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b0001;
      $display("value of $onehot() : %b at t=%0t",$onehot(a),$time);
      $display("value of $onehot0() : %b at t=%0t",$onehot0(a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b0100;
      $display("value of $onehot() : %b at t=%0t",$onehot(a),$time);
      $display("value of $onehot0() : %b at t=%0t",$onehot0(a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b1010;
      $display("value of $onehot() : %b at t=%0t",$onehot(a),$time);
      $display("value of $onehot0() : %b at t=%0t",$onehot0(a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b1110;
      $display("value of $onehot() : %b at t=%0t",$onehot(a),$time);
      $display("value of $onehot0() : %b at t=%0t",$onehot0(a),$time);
    end
endmodule

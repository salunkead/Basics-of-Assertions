//$onehot() as a $onecold()
/*
1.if exactly one bit of the expression is low,while rest of the bits are high then we call it as onecold
*/

module test;
  bit [3:0]a;
  initial
    begin
      a=4'b1110;
      $display("value of $onehot(~a) : %b at t=%0t",$onehot(~a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b1101;
      $display("value of $onehot(~a) : %b at t=%0t",$onehot(~a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b0111;
      $display("value of $onehot(~a) : %b at t=%0t",$onehot(~a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b1010;
      $display("value of $onehot(~a) : %b at t=%0t",$onehot(~a),$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b1111;
      $display("value of $onehot(~a) : %b at t=%0t",$onehot(~a),$time);
    end
endmodule

//$isunknown() system task
/*
1.syntax:- $isunknown(expression)
2.this function returns true if any one bit is 'x' or 'z'
*/

//Demonstration of $isunknown()
module test;
  reg [3:0]a;
  initial
    begin
      a=4'b1110;
      $display("value of $isunknown(a) : %b at t=%0t",$isunknown(a) ,$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b110x;
      $display("value of $isunknown(a)  : %b at t=%0t",$isunknown(a) ,$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b01xx;
      $display("value of $isunknown(a)  : %b at t=%0t",$isunknown(a) ,$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b101z;
      $display("value of $isunknown(a)  : %b at t=%0t",$isunknown(a) ,$time);
      $display("---------------------------------------------------");
      #1;
      a=4'b0000;
      $display("value of $isunknown(a)  : %b at t=%0t",$isunknown(a) ,$time);
    end
endmodule

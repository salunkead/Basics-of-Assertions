//$countbits() system task
/*
1.$countbits() system task returns the number of bits in a bit vector that matches specific values
2.you can use this function to write assertions that checks the number of bits in certain state,such as 1,0,x or z.
3.for example you can write an assertion that checks if a 4 bit signal a has exactly two bits set to 1
4.syntax:- $countbits(expression,control_bit1,control_bit2,..)
  control_bit1,control_bit2,... are the values of the bits that you want to count.
*/

module test;
  reg [3:0]a;
  
  initial
    begin
      a=4'b1110;
      $display("no. of 1's in a is %0d",$countbits(a,1'b1));
      $display("---------------------------------------------------");
      #1;
      a=4'b110x;
      $display("no. of x's in a is %0d",$countbits(a,1'bx));
      $display("---------------------------------------------------");
      #1;
      a=4'b01xx;
      $display("no. of x's in a is %0d",$countbits(a,1'bx));
      $display("---------------------------------------------------");
      #1;
      a=4'b10zz;
      $display("no. of z's in a is %0d",$countbits(a,1'bz));
      $display("---------------------------------------------------");
      #1;
      a=4'b0000;
      $display("no. of 0's in a is %0d",$countbits(a,1'b0));
    end
endmodule

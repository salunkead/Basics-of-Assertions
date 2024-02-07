//$asserton and $assertoff system task
/*
1.we can use system task $assertoff(delay,scope) to turn off assertion check
2.to enable assertion check,we can use $asserton(delay,scope) system task
*/

//////////////////////////
module test;
  bit a,b;
  wire y;
  
  assign y=a|b;
  
  initial
    begin
      a=0;
      b=0;
      #10;
      a=1;
      b=0;
      #10;
      a=0;
      b=1;
      #10
      a=1;
      b=1;
    end
  
  always_comb
    begin
      assert #0(y==a|b)
        $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
    end
  
  initial
    begin
      $assertoff(); //turning off assertion check for time interval 0 to 20
      #20;
      $asserton();  //turning On assertion check at t=20 time unit
    end
endmodule

//let declaration with default values
/*
1.if the let declaration has a port list ,some or all of the ports can be assigned a default value that will be used if no actual
  arguments is passed for that port.
*/

////////let decaration with default value
module test;
  let default1(a,b=10)=a+b;
  
  initial
    begin
      $display("let declaration with default value");
      $display("result with default value is : %0d",default1(28));
    end
endmodule

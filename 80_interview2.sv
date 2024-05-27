///assertion to check duty cycle 
module test;
  bit clk,clk0;
  always #5 clk=~clk;
  
  /*
  always@(posedge clk)
    begin
      clk0=~clk0; //reference clock is f/2
    end
  */
  initial
    begin
      @(posedge clk);
      repeat(10)
        begin
          clk0=1;
          @(negedge clk);
          clk0=0;
          repeat(2)@(posedge clk);
        end
    end
  
  property ppt;
    realtime t1,t2,t3;
    (1'b1,t1=$realtime)|=>(1'b1,t2=$realtime)|=>(1'b1,t3=$realtime)##0(((t2-t1)/(t3-t1))*100==25);
  endproperty
  
  initial begin
  assert property(@(edge clk0)ppt)
    $info("passed at t=%0t",$time);
    end
    
  initial
    begin
      $dumpfile("altmash.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

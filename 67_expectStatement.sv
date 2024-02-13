//The expect statement in system verilog assertions
/*
1.the expect statement is a procedural blocking statement that is similar to assert statement and used to block the execution until the property is evaluated.
2.it must be used with procedural blocks like always,initial.
3.the difference between assert and expect statement is that an assert statement works concurrently like a separate thread and behaves in non-blocking manner.
4.expect statement works in procedural way like a single thread that unblocks after property evaluation(doesnot matter success or failure)
*/

////the below code demonstrate that expect is blocking and assert is a non-blocking 
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
  
  property ppt;
    @(posedge clk) ##2 $rose(a)|-> ##1 $rose(b) ##1 $rose(c);
  endproperty
  
 initial
   begin
     expect1:expect(ppt) begin
       $info("passed at t=%0t",$time);
     end
     $display("this verifies that expect is a blocking .....: time t=%0t",$time);
   end
  
  initial
    begin
      assert_ppt:assert property(ppt) begin
        $info("passed at t=%0t",$time);
      end
     $display("this verifies that assert property is a non-blocking.....: time t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #100 $finish;
    end
endmodule

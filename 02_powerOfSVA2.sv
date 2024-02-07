//reset must be high for three clock tick and then it should remain low till end of the simulation

//system verilog code to check this property
module test;
  bit rst,clk;
  int rst1,rst0;
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      repeat(3)@(negedge clk);
      rst=0;
      #10;
      rst=1;
    end
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          rst1++;
        end
      else
        begin
          rst0++;
        end
    end
  
  initial assert property(@(posedge clk) rst[*3] |=> always !rst) $info("passed at t=%0t",$time); //SVA code to check the property
  
  initial
    begin
      #90;  //system verilog check will be done at the end of simulation i.e at t=90 time unit
      if(rst1==3 && rst0==0)
        $info("passed at t=%0t",$time);
      else
        $error("failed at t=%0t",$time);
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100 $finish;
    end
endmodule

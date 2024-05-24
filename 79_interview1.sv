///

module test;
  bit[7:0]din,dout;
  bit din_enb,dout_enb,clk;
  always #5 clk=~clk;
  
  initial
    begin
      repeat(3)@(posedge clk);
      din_enb=1;
      din=7;
      @(posedge clk);
      din_enb=0;
      repeat($urandom_range(1,25))@(posedge clk);
      dout_enb=1;
      dout=5*din;
      @(posedge clk);
      dout_enb=0;
    end
  
  property ppt;
    int ref_data;
    (din_enb,ref_data=din)|-> ##[1:30] (dout_enb==1'b1 && dout==5*ref_data);
  endproperty
  
  assert property(@(posedge clk)ppt)
    $info("passed at t=%0t",$time);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end
endmodule

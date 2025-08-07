//variable clock delay

/*
##delay 
delay cannot be variable as the delay value must be known before run time.

##[0:lv_data]
in the range operator also variable delay is not possible.

in short,delay values must be constants and it cannot be variables.

what if you want variable delay value?
1. this can be done using local_variable

*/

//Example:-

module top;
  logic wr,clk=0;
  int read_data,exp_data;
  time t;
  
  initial
    begin
      repeat(5) begin
        wr=1;
        repeat(5)@(negedge clk);
        wr=0;
        read_data=$urandom_range(10,100);
        t=$urandom_range(10,20);
        repeat(t)@(negedge clk);
        exp_data=read_data+10;
        @(negedge clk);
      end
    end
  
  property p(time l_lat);
    time latency=0;
    @(posedge clk)
    (
    ($fell(wr),latency=l_lat,$display("inside first at t=%0t",$time)) ##1
      (latency!=0,latency=latency-1,$display("latency=%0t",latency))[*0:$] ##1 latency==0 |->
    (exp_data==read_data+10)
    );
  endproperty
  
  assert property( p(t))
    $info("passed at t=%0t",$time);
    else
      $error("failed at t=%0t",$time);
  
    
      
  always #5 clk=~clk;
  

  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff;
      #1000 $finish;
    end
 endmodule

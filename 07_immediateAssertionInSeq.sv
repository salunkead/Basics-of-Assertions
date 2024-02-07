///final deferred immediate assertion in sequential designs 
/*
1.we can write immdiate assertions or observed deferred immediate assertion or final deferred immediate assertions in sequential design if there is non-temporal expression in the design

*/

///Design module with assertions
module d_ff(input rst,d,clk,output reg q,output q_bar);
  always@(posedge clk)
    begin
      if(rst)
        begin
          q<=1'b0;
        end
      else
        begin
          q<=d;
        end
    end
  
  assign q_bar=~q;

  //assertion procedural block
  always@(posedge clk)
    begin
      if(rst)
        begin
          #2;
          assert final(q==1'b0 && q_bar==1'b1)
            $info("passed at t=%0t",$time);
          else
            $error("failed at t=%0t",$time);
        end
      else
        begin
          #2;
          assert final(q==d && q_bar==~d)
             $info("passed at t=%0t",$time);
          else
            $error("failed at t=%0t",$time);          
        end
    end
endmodule

//Testbench
module tb;
  logic clk,rst,d,q,q_bar;
  d_ff dut(rst,d,clk,q,q_bar);
  
  initial clk=0;
  
  always #5 clk=~clk;
  
  initial
    begin
      rst=1;
      d=0;
      repeat(2)@(negedge clk);
      rst=0;
      repeat(10)
        begin
          @(negedge clk);
          d=$random;
        end
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

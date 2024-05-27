//assertion for watchdog timer reset pulse length
/*
Reset Pulse Length
Writes have no effect when the configuration parameter WDT_HC_
RPL is 1, making the register bits read-only. This is used to select the
number of pclk cycles for which the system reset stays asserted. The
range of values available is 2 to 256 pclk cycles.
0x0 = 2 pclk cycles
0x1 = 4 pclk cycles
0x2 = 8 pclk cycles
0x3 = 16 pclk cycles
0x4 = 32 pclk cycles
0x5 = 64 pclk cycles
0x6 = 128 pclk cycles
0x7 = 256 pclk cycles
*/
////code 
module test;
  bit wdt_rst,pclk;
  always #5 pclk=~pclk;
  bit[3:0]rpl;
  initial
    begin
      rpl=3;
      repeat(2**(rpl+1)+1)
        begin
          @(posedge pclk);
          wdt_rst=1;
        end
      wdt_rst=0;
    end
  
  property ppt;
    (rpl==0 || rpl==1 || rpl==2 || rpl==3 || rpl==4 || rpl==5 || rpl==6 || rpl==7)|-> 
    case(rpl)
      0: wdt_rst[*2] ##1 $fell(wdt_rst);
      1:wdt_rst[*4] ##1 $fell(wdt_rst);
      2:wdt_rst[*8] ##1 $fell(wdt_rst);
      3:wdt_rst[*16]##1 $fell(wdt_rst);
      4:wdt_rst[*32]##1 $fell(wdt_rst);
      5:wdt_rst[*64]##1 $fell(wdt_rst);
      6:wdt_rst[*128]##1 $fell(wdt_rst);
      7:wdt_rst[*256]##1 $fell(wdt_rst);
    endcase
  endproperty
  
  assert property(@(posedge pclk)$rose(wdt_rst)|->ppt)
    $info("passed at t=%0t",$time);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

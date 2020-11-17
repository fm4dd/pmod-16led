// -------------------------------------------------------
// This program tests the LED16 PMOD with a counter
// D16 blinks with 1Hz, while D1..15 bit counts up.
// ULX3S clock is 25Mhz, set breakpoint at 25'd12499999
//--------------------------------------------------------
module pmod_16led_1 (
  input clk,
  output [15:0] pmod_16led,
  output gpio0
);

  // Tie GPIO0, keep board from rebooting
  assign gpio0 = 1'b1;
  reg [24:0] count;
  reg clk_1hz;
  reg [14:0] lednum;
  assign pmod_16led[15] = clk_1hz;
  assign pmod_16led[14:0] = lednum;

  initial begin
    clk_1hz = 1'b1;
    count = 0;
    lednum = 15'd0;
  end

  always@(posedge clk)
  begin
    count <= count + 1;
    if(count == 25'd12499999)
    begin
      count <= 0;
      clk_1hz <= ~clk_1hz;
      lednum <= lednum + 1;
    end
  end
endmodule


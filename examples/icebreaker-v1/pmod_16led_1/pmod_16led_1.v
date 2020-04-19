// -------------------------------------------------------
// This program is a binary counter displayed on the
// on the pmod D2-8, and 9-16. D1 is pulsing 1Hz clock.
// 12MHz clock: set breakpoint at 25'd5999999
// 50MHz clock: set breakpoint at 25'd24999999
//--------------------------------------------------------
module pmod16led_1 (
  input clk,
  output reg [0:7] pmodled1,
  output reg [0:7] pmodled2,
);

  reg [22:0] count = 23'd0;
  reg clk_1hz = 1'b0;
  assign pmodled1[0] = clk_1hz;

  reg [6:0] lednum1 = 7'd0;
  assign pmodled1[7:1] = lednum1;

  reg [7:0] lednum2 = 8'd0;
  assign pmodled2[7:0] = lednum2;

  always @(posedge clk)
  begin
    count   <= count + 1;
    if(count == 23'd5999999)
    begin
      count   <= 0;
      clk_1hz <= ~clk_1hz;
      lednum1 <= lednum1 + 1;
      lednum2 <= lednum2 + 1;
    end
  end
endmodule

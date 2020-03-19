## 16LED PMOD

### Description

[![16LED PMOD](images/16led-top.jpg)](images/16led-top.jpg)

This PMOD provides a sixteen LED display output to FPGA designs via two double-row PMODs.

### Schematic

[![16LED PMOD Schematics](images/16led-schema.png)](images/16led-schema.png)

### Pin Assignments

#### IceBreaker v1.0

 J1# |  Label | Description   | PMOD1A
-----|--------|---------------|-------
1    |  D1    | LED D1        | 4
7    |  D2    | LED D2        | 2
2    |  D3    | LED D3        | 47
8    |  D4    | LED D4        | 45
3    |  D5    | LED D5        | 3
9    |  D6    | LED D6        | 48
4    |  D7    | LED D7        | 46
10   |  D8    | LED D8        | 44

 J2# |  Label | Description   | PMOD1B
-----|--------|---------------|-------
1    |  D9    | LED D9        | 43
7    |  D10   | LED D10       | 38
2    |  D11   | LED D11       | 34
8    |  D12   | LED D12       | 31
3    |  D13   | LED D13       | 42
9    |  D14   | LED D14       | 36
4    |  D15   | LED D15       | 32
10   |  D16   | LED D16       | 28


#### DE0-Nano-SoC

 J1# |  Label | Description   | GPIO0A | GPIO1A
-----|--------|---------------|--------|--------
1    |  D1    | LED D1 green  | PIN_W12|PIN_AA15
2    |  D2    | LED D2 green  | PIN_Y8 |PIN_AG26
3    |  D3    | LED D3 green  | PIN_W8 |PIN_AF23
4    |  D4    | LED D4 green  | PIN_Y5 |PIN_AF21
5    |  D5    | LED D5 green  | PIN_AF8|PIN_AH27
6    |  D6    | LED D6 green  | PIN_AB4|PIN_AH24
7    |  D7    | LED D7 green  | PIN_Y4 |PIN_AE22
8    |  D8    | LED D8 green  | PIN_U11|PIN_AG20

 J2# |  Label | Description   | GPIO0B | GPIO1B
-----|--------|---------------|--------|--------
1    |  D1    | LED D1 red    | PIN_AF4| PIN_AH23
2    |  D2    | LED D2 red    | PIN_AF5| PIN_AE19
3    |  D3    | LED D3 red    | PIN_T13| PIN_AD19
4    |  D4    | LED D4 red    | PIN_AE7| PIN_AE24
5    |  D5    | LED D5 red    | PIN_AG6| PIN_AG23
6    |  D6    | LED D6 red    | PIN_AE4| PIN_AF18
7    |  D7    | LED D7 red    | PIN_T11| PIN_AE20
8    |  D8    | LED D8 red    | PIN_AF6| PIN_AD20

### Example Code

#### Verilog

Verilog test program pmod16led_1.v (top-level):
```
// -------------------------------------------------------
// This program tests HW pin assignment, and lights up D1
// -------------------------------------------------------
module pmod16led_1 (
  output [0:7] pmodledr
);

  reg led;
  assign pmodledr[7] = led;

  always
  begin
    led = 1'b1;  // light up D1
  end
endmodule
```

Verilog test program pmod16led_2.v (top-level):
```
// -------------------------------------------------------
// This program is a binary counter, displayed on the pmod
// LED D2-8 green color. The 1Hz clock pulse is on D1 red.
// 12MHz clock: set breakpoint at 23'd5999999 (icebreaker)
// 50MHz clock: set breakpoint at 25'd24999999 (de0-nano)
// -------------------------------------------------------
module pmod16led_2 (
  input clk,
  output reg [0:7] pmodledg,
  output reg [0:7] pmodledr
);

  reg clk_1hz = 1'b0;
  reg [22:0] count = 23'd0;
  reg [6:0] lednum = 7'd0;
  assign [1:7] pmodledg = lednum;
  assign [1:7] pmodledr = 7'b0000000;
  assign pmodledr[0] = clk_1hz;

  always @(posedge clk)
  begin
    count   <= count + 1;
    if(count == 23'd5999999)
    begin
      count   <= 0;
      clk_1hz <= ~clk_1hz;
      lednum  <= lednum + 1;
    end
  end
endmodule
```

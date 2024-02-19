// -----------------------------------------------------------------------------
// Auto-Generated by:        __   _ __      _  __
//                          / /  (_) /____ | |/_/
//                         / /__/ / __/ -_)>  <
//                        /____/_/\__/\__/_/|_|
//                     Build your hardware, easily!
//                   https://github.com/enjoy-digital/litex
//
// Filename   : on_chip_memory.v
// Device     : gemini
// LiteX sha1 : c0f31dc8
// Date       : 2023-12-12 11:14:44
//------------------------------------------------------------------------------
// This file is Copyright (c) 2022 RapidSilicon
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps

//------------------------------------------------------------------------------
// Module
//------------------------------------------------------------------------------

module model #(
	parameter INIT           = {32768{1'b0}},
	parameter INIT_PARITY    = {4096{1'b0}},
	parameter READ_WIDTH_B   = 9
)
(
    input  wire    [9:0] addr_B,
    input  wire          ren_B,
    output wire   [35:0] dout_B,
    input  wire          clk
);


//------------------------------------------------------------------------------
// Signals
//------------------------------------------------------------------------------

wire          sys_clk;
wire    [9:0] addr_B_1;
wire    [35:0] dout_B_1;
wire          ren_B_1;
wire   [31:0] bram_out_A;
wire   [31:0] bram_out_B;
wire    [3:0] rparity_A;
wire    [3:0] rparity_B;

//------------------------------------------------------------------------------
// Combinatorial Logic
//------------------------------------------------------------------------------

assign addr_B_1 = addr_B;
assign ren_B_1 = ren_B;
assign dout_B = dout_B_1;
assign sys_clk = clk;
assign dout_B_1[35:0] = {rparity_B[3], bram_out_B[31:24], rparity_B[2], bram_out_B[23:16], rparity_B[1], bram_out_B[15:8], rparity_B[0], bram_out_B[7:0]};

TDP_RAM36K_org # (
    .INIT(INIT),
    .INIT_PARITY(INIT_PARITY),
    .WRITE_WIDTH_A(36),
    .READ_WIDTH_A(36),
    .WRITE_WIDTH_B(36),
    .READ_WIDTH_B(READ_WIDTH_B)
  )
  TDP_RAM36K_org_inst (
    .WEN_A(1'b0),
    .WEN_B(1'b0),
    .REN_A(1'b0),
    .REN_B(ren_B_1),
    .CLK_A(1'b0),
    .CLK_B(sys_clk),
    .BE_A({4{1'b0}}),
    .BE_B({4{1'b0}}),
    .ADDR_A({15{1'b0}}),
    .ADDR_B({addr_B_1[9:0], {5{1'd0}}}),
    .WDATA_A({32{1'b0}}),
    .WPARITY_A({4{1'b0}}),
    .WDATA_B({32{1'b0}}),
    .WPARITY_B({4{1'b0}}),
    .RDATA_A(bram_out_A[31:0]),
    .RPARITY_A(rparity_A[3:0]),
    .RDATA_B(bram_out_B[31:0]),
    .RPARITY_B(rparity_B[3:0])
  );

endmodule

// -----------------------------------------------------------------------------
//  Auto-Generated by LiteX on 2023-12-12 11:14:44.
//------------------------------------------------------------------------------
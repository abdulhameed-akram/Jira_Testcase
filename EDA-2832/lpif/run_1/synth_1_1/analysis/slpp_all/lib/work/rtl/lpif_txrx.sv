////////////////////////////////////////////////////////////
//
//        Copyright (C) 2021 Eximius Design
//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Functional Descript: LPIF Adapter IP txrx datapath
//
//
//
////////////////////////////////////////////////////////////

module lpif_txrx
  #(
    parameter AIB_VERSION = 2,
    parameter AIB_GENERATION = 2,
    parameter AIB_LANES = 4,
    parameter AIB_BITS_PER_LANE = 80,
    parameter LPIF_DATA_WIDTH = 32,
    parameter LPIF_CLOCK_RATE = 2000,
    parameter MEM_CACHE_STREAM_ID = 8'h1,
    parameter IO_STREAM_ID = 8'h2,
    parameter ARB_MUX_STREAM_ID = 8'h3,
    localparam LPIF_VALID_WIDTH = ((LPIF_DATA_WIDTH == 128) ? 2 : 1),
    localparam LPIF_CRC_WIDTH = ((LPIF_DATA_WIDTH == 128) ? 32 : 16)
    )
  (
   input logic                          com_clk,
   input logic                          rst_n,

   input logic                          tx_online,
   input logic                          rx_online,
   input logic                          m_gen2_mode,
   input logic [1:0]                    remote_rate_port,

   input logic [15:0]                   delay_x_value,
   input logic [15:0]                   delay_y_value,
   input logic [15:0]                   delay_z_value,

   input logic [AIB_LANES-1:0]          fifo_full,      // unused
   input logic [AIB_LANES-1:0]          fifo_pfull,     // unused
   input logic [AIB_LANES-1:0]          fifo_empty,     // unused
   input logic [AIB_LANES-1:0]          fifo_pempty,    // unused
   output logic [5:0]                   fifo_full_val,
   output logic [5:0]                   fifo_pfull_val,
   output logic [2:0]                   fifo_empty_val,
   output logic [2:0]                   fifo_pempty_val,

   input logic [319:0]                  rx_phy0,
   input logic [319:0]                  rx_phy1,
   input logic [319:0]                  rx_phy2,
   input logic [319:0]                  rx_phy3,
   input logic [319:0]                  rx_phy4,
   input logic [319:0]                  rx_phy5,
   input logic [319:0]                  rx_phy6,
   input logic [319:0]                  rx_phy7,
   input logic [319:0]                  rx_phy8,
   input logic [319:0]                  rx_phy9,
   input logic [319:0]                  rx_phy10,
   input logic [319:0]                  rx_phy11,
   input logic [319:0]                  rx_phy12,
   input logic [319:0]                  rx_phy13,
   input logic [319:0]                  rx_phy14,
   input logic [319:0]                  rx_phy15,

   input logic [3:0]                    dstrm_state,
   input logic [1:0]                    dstrm_protid,
   input logic [LPIF_DATA_WIDTH*8-1:0]  dstrm_data,
   input logic [LPIF_VALID_WIDTH-1:0]   dstrm_dvalid,
   input logic [LPIF_CRC_WIDTH-1:0]     dstrm_crc,
   input logic                          dstrm_crc_valid,
   input logic                          dstrm_valid,

   output logic [319:0]                 tx_phy0,
   output logic [319:0]                 tx_phy1,
   output logic [319:0]                 tx_phy2,
   output logic [319:0]                 tx_phy3,
   output logic [319:0]                 tx_phy4,
   output logic [319:0]                 tx_phy5,
   output logic [319:0]                 tx_phy6,
   output logic [319:0]                 tx_phy7,
   output logic [319:0]                 tx_phy8,
   output logic [319:0]                 tx_phy9,
   output logic [319:0]                 tx_phy10,
   output logic [319:0]                 tx_phy11,
   output logic [319:0]                 tx_phy12,
   output logic [319:0]                 tx_phy13,
   output logic [319:0]                 tx_phy14,
   output logic [319:0]                 tx_phy15,

   output logic [3:0]                   ustrm_state,
   output logic [1:0]                   ustrm_protid,
   output logic [LPIF_DATA_WIDTH*8-1:0] ustrm_data,
   output logic [LPIF_VALID_WIDTH-1:0]  ustrm_dvalid,
   output logic [LPIF_CRC_WIDTH-1:0]    ustrm_crc,
   output logic                         ustrm_crc_valid,
   output logic                         ustrm_valid,

   output logic [15:0]                  lpif_tx_stb_intv,
   output logic [15:0]                  lpif_rx_stb_intv,

   output logic                         tx_mrk_userbit_vld,

   output logic [31:0]                  rx_upstream_debug_status,
   output logic [31:0]                  tx_downstream_debug_status
   );

  /*AUTOWIRE*/

  logic                                 tx_stb_userbit;
  logic [3:0]                           tx_mrk_userbit;

  assign tx_mrk_userbit_vld = |tx_mrk_userbit;

  /* TX & RX datapath */

//`include "lpif_configs.svh"

localparam X16_Q2 = ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  4) && (AIB_BITS_PER_LANE == 320));
localparam X16_H2 = ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  4) && (AIB_BITS_PER_LANE == 160));
localparam X16_F2 = ((LPIF_CLOCK_RATE == 2000) && (LPIF_DATA_WIDTH ==  32) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  4) && (AIB_BITS_PER_LANE ==  80));

localparam X8_Q2 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 320));
localparam X8_H2 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 160));
localparam X8_F2 =  ((LPIF_CLOCK_RATE == 2000) && (LPIF_DATA_WIDTH ==  32) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE ==  80));

localparam X4_Q2 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  1) && (AIB_BITS_PER_LANE == 320));
localparam X4_H2 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  1) && (AIB_BITS_PER_LANE == 160));
localparam X4_F2 =  ((LPIF_CLOCK_RATE == 2000) && (LPIF_DATA_WIDTH ==  32) && (AIB_VERSION == 2) &&  (AIB_GENERATION == 2) && (AIB_LANES ==  1) && (AIB_BITS_PER_LANE ==  80));

localparam X16_H1 = ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES == 16) && (AIB_BITS_PER_LANE == 80));
localparam X16_F1 = ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES == 16) && (AIB_BITS_PER_LANE == 40));

localparam X8_H1 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  8) && (AIB_BITS_PER_LANE == 80));
localparam X8_F1 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  8) && (AIB_BITS_PER_LANE == 40));

localparam X4_H1 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  4) && (AIB_BITS_PER_LANE == 80));
localparam X4_F1 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  4) && (AIB_BITS_PER_LANE == 40));

localparam X2_H1 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 80));
localparam X2_F1 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 40));

// X1_H1 and X1_F1 are deprecated
/* -----\/----- EXCLUDED -----\/-----
localparam X1_H1 =  ((LPIF_CLOCK_RATE ==  500) && (LPIF_DATA_WIDTH == 128) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 80));
localparam X1_F1 =  ((LPIF_CLOCK_RATE == 1000) && (LPIF_DATA_WIDTH ==  64) && (((AIB_VERSION == 2) && (AIB_GENERATION == 1)) || (AIB_VERSION == 1)) && (AIB_LANES ==  2) && (AIB_BITS_PER_LANE == 40));
 -----/\----- EXCLUDED -----/\----- */
localparam X1_H1 =  0;
localparam X1_F1 =  0;


localparam G2X16 = X16_Q2 | X16_H2 | X16_F2 ;
localparam G2X8  = X8_Q2  | X8_H2  | X8_F2  ;
localparam G2X4  = X4_Q2  | X4_H2  | X4_F2  ;

localparam G1X16 = X16_F1 | X16_H1 ;
localparam G1X8  = X8_F1  | X8_H1  ;
localparam G1X4  = X4_F1  | X4_H1  ;
localparam G1X2  = X2_F1  | X2_H1  ;

localparam G2F = X16_F2 | X8_F2 | X4_F2 ;
localparam G2H = X16_H2 | X8_H2 | X4_H2 ;
localparam G2Q = X16_Q2 | X8_Q2 | X4_Q2 ;

localparam G1F = X16_F1 | X8_F1 | X4_F1 | X2_F1 ;
localparam G1H = X16_H1 | X8_H1 | X4_H1 | X2_H1 ;




wire        x16_q2 = X16_Q2;
wire        x16_h2 = X16_H2;
wire        x16_f2 = X16_F2;

wire        x8_q2  = X8_Q2;
wire        x8_h2  = X8_H2;
wire        x8_f2  = X8_F2;

wire        x4_q2  = X4_Q2;
wire        x4_h2  = X4_H2;
wire        x4_f2  = X4_F2;

wire        x16_h1 = X16_H1;
wire        x16_f1 = X16_F1;

wire        x8_h1  = X8_H1;
wire        x8_f1  = X8_F1;

wire        x4_h1  = X4_H1;
wire        x4_f1  = X4_F1;

wire        x2_h1  = X2_H1;
wire        x2_f1  = X2_F1;

wire        x1_h1  = X1_H1;
wire        x1_f1  = X1_F1;

wire [15:0] lpif_clock_rate = LPIF_CLOCK_RATE;
wire [15:0] lpif_data_width = LPIF_DATA_WIDTH;
wire [15:0] aib_version = AIB_VERSION;
wire [15:0] aib_generation = AIB_GENERATION;
wire [15:0] aib_lanes = AIB_LANES;
wire [15:0] aib_bits_per_lane = AIB_BITS_PER_LANE;

wire [7:0]  mem_cache_stream_id = MEM_CACHE_STREAM_ID;
wire [7:0]  io_stream_id = IO_STREAM_ID;
wire [7:0]  arb_mux_stream_id = ARB_MUX_STREAM_ID;


  logic [319:0]                         ll_tx_phy0;
  logic [319:0]                         ll_tx_phy1;
  logic [319:0]                         ll_tx_phy2;
  logic [319:0]                         ll_tx_phy3;
  logic [319:0]                         ll_tx_phy4;
  logic [319:0]                         ll_tx_phy5;
  logic [319:0]                         ll_tx_phy6;
  logic [319:0]                         ll_tx_phy7;
  logic [319:0]                         ll_tx_phy8;
  logic [319:0]                         ll_tx_phy9;
  logic [319:0]                         ll_tx_phy10;
  logic [319:0]                         ll_tx_phy11;
  logic [319:0]                         ll_tx_phy12;
  logic [319:0]                         ll_tx_phy13;
  logic [319:0]                         ll_tx_phy14;
  logic [319:0]                         ll_tx_phy15;

  generate
    if (X16_H1 | X16_F1)
      begin
        if (X16_H1)
          begin
            assign tx_phy0  = {240'b0, ll_tx_phy0[79:0]};
            assign tx_phy1  = {240'b0, ll_tx_phy1[79:0]};
            assign tx_phy2  = {240'b0, ll_tx_phy2[79:0]};
            assign tx_phy3  = {240'b0, ll_tx_phy3[79:0]};
            assign tx_phy4  = {240'b0, ll_tx_phy4[79:0]};
            assign tx_phy5  = {240'b0, ll_tx_phy5[79:0]};
            assign tx_phy6  = {240'b0, ll_tx_phy6[79:0]};
            assign tx_phy7  = {240'b0, ll_tx_phy7[79:0]};
            assign tx_phy8  = {240'b0, ll_tx_phy8[79:0]};
            assign tx_phy9  = {240'b0, ll_tx_phy9[79:0]};
            assign tx_phy10 = {240'b0, ll_tx_phy10[79:0]};
            assign tx_phy11 = {240'b0, ll_tx_phy11[79:0]};
            assign tx_phy12 = {240'b0, ll_tx_phy12[79:0]};
            assign tx_phy13 = {240'b0, ll_tx_phy13[79:0]};
            assign tx_phy14 = {240'b0, ll_tx_phy14[79:0]};
            assign tx_phy15 = {240'b0, ll_tx_phy15[79:0]};
          end
        else if (X16_F1)
          begin
            assign tx_phy0  = {280'b0, ll_tx_phy0[39:0]};
            assign tx_phy1  = {280'b0, ll_tx_phy1[39:0]};
            assign tx_phy2  = {280'b0, ll_tx_phy2[39:0]};
            assign tx_phy3  = {280'b0, ll_tx_phy3[39:0]};
            assign tx_phy4  = {280'b0, ll_tx_phy4[39:0]};
            assign tx_phy5  = {280'b0, ll_tx_phy5[39:0]};
            assign tx_phy6  = {280'b0, ll_tx_phy6[39:0]};
            assign tx_phy7  = {280'b0, ll_tx_phy7[39:0]};
            assign tx_phy8  = {280'b0, ll_tx_phy8[39:0]};
            assign tx_phy9  = {280'b0, ll_tx_phy9[39:0]};
            assign tx_phy10 = {280'b0, ll_tx_phy10[39:0]};
            assign tx_phy11 = {280'b0, ll_tx_phy11[39:0]};
            assign tx_phy12 = {280'b0, ll_tx_phy12[39:0]};
            assign tx_phy13 = {280'b0, ll_tx_phy13[39:0]};
            assign tx_phy14 = {280'b0, ll_tx_phy14[39:0]};
            assign tx_phy15 = {280'b0, ll_tx_phy15[39:0]};
          end
      end // if (X16_H1 | X16_F1)
    else if (X8_H1 | X8_F1)
      begin
        if (X8_H1)
          begin
            assign tx_phy0  = {240'b0, ll_tx_phy0[79:0]};
            assign tx_phy1  = {240'b0, ll_tx_phy1[79:0]};
            assign tx_phy2  = {240'b0, ll_tx_phy2[79:0]};
            assign tx_phy3  = {240'b0, ll_tx_phy3[79:0]};
            assign tx_phy4  = {240'b0, ll_tx_phy4[79:0]};
            assign tx_phy5  = {240'b0, ll_tx_phy5[79:0]};
            assign tx_phy6  = {240'b0, ll_tx_phy6[79:0]};
            assign tx_phy7  = {240'b0, ll_tx_phy7[79:0]};
          end
        else if (X8_F1)
          begin
            assign tx_phy0  = {280'b0, ll_tx_phy0[39:0]};
            assign tx_phy1  = {280'b0, ll_tx_phy1[39:0]};
            assign tx_phy2  = {280'b0, ll_tx_phy2[39:0]};
            assign tx_phy3  = {280'b0, ll_tx_phy3[39:0]};
            assign tx_phy4  = {280'b0, ll_tx_phy4[39:0]};
            assign tx_phy5  = {280'b0, ll_tx_phy5[39:0]};
            assign tx_phy6  = {280'b0, ll_tx_phy6[39:0]};
            assign tx_phy7  = {280'b0, ll_tx_phy7[39:0]};
          end
        assign tx_phy8  = 320'b0;
        assign tx_phy9  = 320'b0;
        assign tx_phy10 = 320'b0;
        assign tx_phy11 = 320'b0;
        assign tx_phy12 = 320'b0;
        assign tx_phy13 = 320'b0;
        assign tx_phy14 = 320'b0;
        assign tx_phy15 = 320'b0;
      end
    else if (X16_Q2 | X16_H2 | X16_F2 | X4_H1 | X4_F1)
      begin
        if (X16_Q2)
          begin
            assign tx_phy0  = ll_tx_phy0[319:0];
            assign tx_phy1  = ll_tx_phy1[319:0];
            assign tx_phy2  = ll_tx_phy2[319:0];
            assign tx_phy3  = ll_tx_phy3[319:0];
          end
        else if (X16_H2)
          begin
            assign tx_phy0  = {160'b0, ll_tx_phy0[159:0]};
            assign tx_phy1  = {160'b0, ll_tx_phy1[159:0]};
            assign tx_phy2  = {160'b0, ll_tx_phy2[159:0]};
            assign tx_phy3  = {160'b0, ll_tx_phy3[159:0]};
          end
        else if (X16_F2 | X4_H1)
          begin
            assign tx_phy0  = {240'b0, ll_tx_phy0[79:0]};
            assign tx_phy1  = {240'b0, ll_tx_phy1[79:0]};
            assign tx_phy2  = {240'b0, ll_tx_phy2[79:0]};
            assign tx_phy3  = {240'b0, ll_tx_phy3[79:0]};
          end
        else if (X4_F1)
          begin
            assign tx_phy0  = {280'b0, ll_tx_phy0[39:0]};
            assign tx_phy1  = {280'b0, ll_tx_phy1[39:0]};
            assign tx_phy2  = {280'b0, ll_tx_phy2[39:0]};
            assign tx_phy3  = {280'b0, ll_tx_phy3[39:0]};
          end
        assign tx_phy4  = 320'b0;
        assign tx_phy5  = 320'b0;
        assign tx_phy6  = 320'b0;
        assign tx_phy7  = 320'b0;
        assign tx_phy8  = 320'b0;
        assign tx_phy9  = 320'b0;
        assign tx_phy10 = 320'b0;
        assign tx_phy11 = 320'b0;
        assign tx_phy12 = 320'b0;
        assign tx_phy13 = 320'b0;
        assign tx_phy14 = 320'b0;
        assign tx_phy15 = 320'b0;
      end // if (X16_Q2 | X16_H2 | X16_F2 | X4_H1 | X4_F1)
    else if (X8_Q2 | X8_H2 | X8_F2 | X2_H1 | X2_F1 | X1_F1)
      begin
        if (X8_Q2)
          begin
            assign tx_phy0  = ll_tx_phy0[319:0];
            assign tx_phy1  = ll_tx_phy1[319:0];
          end
        else if (X8_H2)
          begin
            assign tx_phy0  = {160'b0, ll_tx_phy0[159:0]};
            assign tx_phy1  = {160'b0, ll_tx_phy1[159:0]};
          end
        else if (X8_F2 | X2_H1)
          begin
            assign tx_phy0  = {240'b0, ll_tx_phy0[79:0]};
            assign tx_phy1  = {240'b0, ll_tx_phy1[79:0]};
          end
        else if (X2_F1 | X1_F1)
          begin
            assign tx_phy0  = {280'b0, ll_tx_phy0[39:0]};
            assign tx_phy1  = {280'b0, ll_tx_phy1[39:0]};
          end
        assign tx_phy2  = 320'b0;
        assign tx_phy3  = 320'b0;
        assign tx_phy4  = 320'b0;
        assign tx_phy5  = 320'b0;
        assign tx_phy6  = 320'b0;
        assign tx_phy7  = 320'b0;
        assign tx_phy8  = 320'b0;
        assign tx_phy9  = 320'b0;
        assign tx_phy10 = 320'b0;
        assign tx_phy11 = 320'b0;
        assign tx_phy12 = 320'b0;
        assign tx_phy13 = 320'b0;
        assign tx_phy14 = 320'b0;
        assign tx_phy15 = 320'b0;
      end
    else if (X4_Q2 | X4_H2 | X4_F2)
      begin
        if (X4_Q2)
          begin
            assign tx_phy0  = ll_tx_phy0[319:0];
          end
        else if (X4_H2)
          begin
            assign tx_phy0  = {160'b0, ll_tx_phy0[159:0]};
          end
        else if (X4_F2)
          begin
            assign tx_phy0  = {240'b0, ll_tx_phy0[79:0]};
          end
        assign tx_phy1  = 320'b0;
        assign tx_phy2  = 320'b0;
        assign tx_phy3  = 320'b0;
        assign tx_phy4  = 320'b0;
        assign tx_phy5  = 320'b0;
        assign tx_phy6  = 320'b0;
        assign tx_phy7  = 320'b0;
        assign tx_phy8  = 320'b0;
        assign tx_phy9  = 320'b0;
        assign tx_phy10 = 320'b0;
        assign tx_phy11 = 320'b0;
        assign tx_phy12 = 320'b0;
        assign tx_phy13 = 320'b0;
        assign tx_phy14 = 320'b0;
        assign tx_phy15 = 320'b0;
      end
  endgenerate

  logic [(4*4)-1:0]                     ustrm_state_tmp;
  logic [(4*2)-1:0]                     ustrm_protid_tmp;
  logic [(4*1)-1:0]                     ustrm_valid_tmp;
  logic [(4*1)-1:0]                     ustrm_crc_valid_tmp;
  logic [(4*1)-1:0]                     ustrm_dvalid_tmp;
  logic [(4*16)-1:0]                    ustrm_crc_tmp;
  logic [(4*256)-1:0]                   ustrm_data_tmp;

  assign ustrm_state          = ustrm_state_tmp[3:0]  ;
  assign ustrm_protid         = ustrm_protid_tmp[1:0] ;
  assign ustrm_valid          = ustrm_valid_tmp[0]    ;

  generate

    if (X16_Q2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[3]      , ustrm_dvalid_tmp[1]      } ; 
         assign ustrm_crc_valid      =   ustrm_crc_valid_tmp[3]   | ustrm_crc_valid_tmp[1]    ; 
         assign ustrm_crc            = { ustrm_crc_tmp[3*16+:16]  , ustrm_crc_tmp[1*16+:16]  } ; 
         assign ustrm_data           = { ustrm_data_tmp[768+:256] , ustrm_data_tmp[512+:256] , ustrm_data_tmp[256+:256] , ustrm_data_tmp[0+:256] } ; 
      end
    else if (X16_H2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[1]       } ; 
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]    } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*16+:16]   } ; 
         assign ustrm_data           = { ustrm_data_tmp[256+:256] , ustrm_data_tmp[0+:256] } ; 
      end
    else if (X16_F2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]    } ; 
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0] } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:16]   } ; 
         assign ustrm_data           = { ustrm_data_tmp[0+:256] } ; 
      end

    else if (X8_Q2)
      begin
         assign ustrm_dvalid         = { 1'b0, ustrm_dvalid_tmp[3]  } ; 
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[3]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[3*8+:8]      , ustrm_crc_tmp[2*8+:8]    } ;
         assign ustrm_data           = { ustrm_data_tmp[3*128+:128] , ustrm_data_tmp[2*128+:128] , ustrm_data_tmp[1*128+:128] , ustrm_data_tmp[0*128+:128] } ;
      end
    else if (X8_H2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[1]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*8+:8]      , ustrm_crc_tmp[0*8+:8]      } ;
         assign ustrm_data           = { ustrm_data_tmp[1*128+:128] , ustrm_data_tmp[0*128+:128] } ;
      end
    else if (X8_F2)
      begin
         assign ustrm_dvalid         = {ustrm_dvalid_tmp[0]    } ;
         assign ustrm_crc_valid      = {ustrm_crc_valid_tmp[0] } ;
         assign ustrm_crc            = {ustrm_crc_tmp[0+:8]    } ;
         assign ustrm_data           = {ustrm_data_tmp[0+:128] } ;
      end

    else if (X4_Q2)
      begin
         assign ustrm_dvalid         = { 1'b0 , ustrm_dvalid_tmp[3] } ; 
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[3]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[3*4+:4]    , ustrm_crc_tmp[2*4+:4]    ,  ustrm_crc_tmp[1*4+:4]    , ustrm_crc_tmp[0*4+:4]    } ;
         assign ustrm_data           = { ustrm_data_tmp[3*64+:64] , ustrm_data_tmp[2*64+:64] ,  ustrm_data_tmp[1*64+:64] , ustrm_data_tmp[0*64+:64] } ;
      end
    else if (X4_H2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[1]      } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]   } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*4+:4]    , ustrm_crc_tmp[0*4+:4]    } ;
         assign ustrm_data           = { ustrm_data_tmp[1*64+:64] , ustrm_data_tmp[0*64+:64] } ;
      end
    else if (X4_F2)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]      } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0]   } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:4]      } ;
         assign ustrm_data           = { ustrm_data_tmp[0+:64]    } ;
      end
    else if (X16_H1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[1]        , ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      =   ustrm_crc_valid_tmp[1]     | ustrm_crc_valid_tmp[0]       ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*16+:16]    , ustrm_crc_tmp[0*16+:16]    } ;
         assign ustrm_data           = { ustrm_data_tmp[1*512+:512] , ustrm_data_tmp[0*512+:512] } ;
      end
    else if (X16_F1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:16]       } ;
         assign ustrm_data           = { ustrm_data_tmp[0+:512]     } ;
      end

    else if (X8_H1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*8+:8]      , ustrm_crc_tmp[0*8+:8]      } ;
         assign ustrm_data           = { ustrm_data_tmp[1*256+:256] , ustrm_data_tmp[0*256+:256] } ;
      end
    else if (X8_F1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:8]        } ;
         assign ustrm_data           = { ustrm_data_tmp[0+:256]     } ;
      end

    else if (X4_H1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*4+:4]      , ustrm_crc_tmp[0*4+:4]      } ;
         assign ustrm_data           = { ustrm_data_tmp[1*128+:128] , ustrm_data_tmp[0*128+:128] } ;
      end
    else if (X4_F1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:4]        } ;
         assign ustrm_data           = { ustrm_data_tmp[0+:128]     } ;
      end

    else if (X2_H1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[1]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[1*2+:2]      , ustrm_crc_tmp[0*2+:2]      } ;
         assign ustrm_data           = { ustrm_data_tmp[1*64+:64] , ustrm_data_tmp[0*64+:64] } ;
      end
    else if (X2_F1)
      begin
         assign ustrm_dvalid         = { ustrm_dvalid_tmp[0]        } ;
         assign ustrm_crc_valid      = { ustrm_crc_valid_tmp[0]     } ;
         assign ustrm_crc            = { ustrm_crc_tmp[0+:2]        } ;
         assign ustrm_data           = { ustrm_data_tmp[0+:64]     } ;
      end

  endgenerate

  logic [(4*4)-1:0]                     dstrm_state_tmp;
  logic [(4*2)-1:0]                     dstrm_protid_tmp;
  logic [(4*1)-1:0]                     dstrm_valid_tmp;
  logic [(4*1)-1:0]                     dstrm_crc_valid_tmp;
  logic [(4*1)-1:0]                     dstrm_dvalid_tmp;
  logic [(4*16)-1:0]                    dstrm_crc_tmp;
  logic [(4*256)-1:0]                   dstrm_data_tmp;


  // These values are upsized to prevent undriven signals in the _tmp even though they would be unused
  assign dstrm_state_tmp      = {4{dstrm_state}}    ;
  assign dstrm_protid_tmp     = {4{dstrm_protid}}   ;
  assign dstrm_valid_tmp      = {4{dstrm_valid}}    ;

  generate
    if (X16_Q2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[1]        , dstrm_dvalid[1]        , dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 , dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[16+:16]      , 16'h0 , dstrm_crc[0+:16]       , 16'h0 } ;
         assign dstrm_data_tmp       = { dstrm_data[3*256+:256] , dstrm_data[2*256+:256] , dstrm_data[1*256+:256] , dstrm_data[0*256+:256] } ;
      end
    else if (X16_H2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:16]       , 16'h0 } ;
         assign dstrm_data_tmp       = { dstrm_data[1*256+:256] , dstrm_data[0*256+:256] } ;
      end
    else if (X16_F2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]    } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid    } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:16]   } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:256] } ;
      end

    else if (X8_Q2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        , dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 , 1'b0 , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*8+:8]      , dstrm_crc[0*8+:8]      , 8'h0 , 8'h0 } ;
         assign dstrm_data_tmp       = { dstrm_data[3*128+:128] , dstrm_data[2*128+:128] , dstrm_data[1*128+:128] , dstrm_data[0*128+:128] } ;
      end
    else if (X8_H2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*8+:8]      , dstrm_crc[0*8+:8]      } ;
         assign dstrm_data_tmp       = { dstrm_data[1*128+:128] , dstrm_data[0*128+:128] } ;
      end
    else if (X8_F2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:8]        } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:128]     } ;
      end

    else if (X4_Q2)
      begin
         assign dstrm_dvalid_tmp    = { dstrm_dvalid[0]      , dstrm_dvalid[0]      , dstrm_dvalid[0]      , dstrm_dvalid[0]      } ;
         assign dstrm_crc_valid_tmp = { dstrm_crc_valid      , 1'b0 , 1'b0 , 1'b0 } ;
         assign dstrm_crc_tmp       = { dstrm_crc[3*4+:4]    , dstrm_crc[2*4+:4]    , dstrm_crc[1*4+:4]    , dstrm_crc[0*4+:4]    } ;
         assign dstrm_data_tmp      = { dstrm_data[3*64+:64] , dstrm_data[2*64+:64] , dstrm_data[1*64+:64] , dstrm_data[0*64+:64] } ;
      end
    else if (X4_H2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*4+:4]      , dstrm_crc[0*4+:4]      } ;
         assign dstrm_data_tmp       = { dstrm_data[1*64+:64]   , dstrm_data[0*64+:64]   } ;
      end
    else if (X4_F2)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:4]        } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:64]      } ;
      end

    else if (X16_H1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[1]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , dstrm_crc_valid          } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*16+:16]    , dstrm_crc[0*16+:16]    } ;
         assign dstrm_data_tmp       = { dstrm_data[1*512+:512] , dstrm_data[0*512+:512] } ;
      end
    else if (X16_F1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:16]       } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:512]     } ;
      end

    else if (X8_H1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*8+:8]      , dstrm_crc[0*8+:8]      } ;
         assign dstrm_data_tmp       = { dstrm_data[1*256+:256] , dstrm_data[0*256+:256] } ;
      end
    else if (X8_F1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:8]        } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:256]     } ;
      end

    else if (X4_H1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*4+:4]      , dstrm_crc[0*4+:4]      } ;
         assign dstrm_data_tmp       = { dstrm_data[1*128+:128] , dstrm_data[0*128+:128] } ;
      end
    else if (X4_F1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:4]        } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:128]     } ;
      end

    else if (X2_H1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        , dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        , 1'b0 } ;
         assign dstrm_crc_tmp        = { dstrm_crc[1*2+:2]      , dstrm_crc[0*2+:2]      } ;
         assign dstrm_data_tmp       = { dstrm_data[1*64+:64]   , dstrm_data[0*64+:64]   } ;
      end
    else if (X2_F1)
      begin
         assign dstrm_dvalid_tmp     = { dstrm_dvalid[0]        } ;
         assign dstrm_crc_valid_tmp  = { dstrm_crc_valid        } ;
         assign dstrm_crc_tmp        = { dstrm_crc[0+:2]        } ;
         assign dstrm_data_tmp       = { dstrm_data[0+:64]      } ;
      end

  endgenerate







  // asymmetric datapaths

  /*
   lpif_txrx_x16_asym2_full_master_top AUTO_TEMPLATE
   lpif_txrx_x16_asym2_half_master_top AUTO_TEMPLATE
   lpif_txrx_x16_asym2_quarter_master_top AUTO_TEMPLATE
   lpif_txrx_x8_asym2_full_master_top AUTO_TEMPLATE
   lpif_txrx_x8_asym2_half_master_top AUTO_TEMPLATE
   lpif_txrx_x8_asym2_quarter_master_top AUTO_TEMPLATE
   lpif_txrx_x4_asym2_full_master_top AUTO_TEMPLATE
   lpif_txrx_x4_asym2_half_master_top AUTO_TEMPLATE
   lpif_txrx_x4_asym2_quarter_master_top AUTO_TEMPLATE
   lpif_txrx_x16_asym1_full_master_top AUTO_TEMPLATE
   lpif_txrx_x16_asym1_half_master_top AUTO_TEMPLATE
   lpif_txrx_x8_asym1_full_master_top AUTO_TEMPLATE
   lpif_txrx_x8_asym1_half_master_top AUTO_TEMPLATE
   lpif_txrx_x4_asym1_full_master_top AUTO_TEMPLATE
   lpif_txrx_x4_asym1_half_master_top AUTO_TEMPLATE
   lpif_txrx_x2_asym1_full_master_top AUTO_TEMPLATE
   lpif_txrx_x2_asym1_half_master_top AUTO_TEMPLATE
   lpif_txrx_x1_asym1_full_master_top AUTO_TEMPLATE
   lpif_txrx_x1_asym1_half_master_top AUTO_TEMPLATE (
   .clk_wr                 (com_clk),
   .rst_wr_n               (rst_n),
   .init_downstream_credit (8'h00),
   .ustrm_valid            (ustrm_valid_tmp[]),
   .ustrm_state            (ustrm_state_tmp[]),
   .ustrm_protid           (ustrm_protid_tmp[]),
   .ustrm_data             (ustrm_data_tmp[]),
   .ustrm_dvalid           (ustrm_dvalid_tmp[]),
   .ustrm_crc              (ustrm_crc_tmp[]),
   .ustrm_crc_valid        (ustrm_crc_valid_tmp[]),
   .dstrm_valid            (dstrm_valid_tmp[]),
   .dstrm_state            (dstrm_state_tmp[]),
   .dstrm_data             (dstrm_data_tmp[]),
   .dstrm_protid           (dstrm_protid_tmp[]),
   .dstrm_dvalid           (dstrm_dvalid_tmp[]),
   .dstrm_crc              (dstrm_crc_tmp[]),
   .dstrm_crc_valid        (dstrm_crc_valid_tmp[]),
   .tx_phy\([0-9]+\)       (ll_tx_phy\1[]),
   ); */

  generate
    if (X16_Q2) // quarter rate
      begin

        // Lint Cleanup
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x16_asym2_quarter_master_top
          lpif_txrx_x16_asym2_quarter_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[319:0]),     // Templated
             .tx_phy1                   (ll_tx_phy1[319:0]),     // Templated
             .tx_phy2                   (ll_tx_phy2[319:0]),     // Templated
             .tx_phy3                   (ll_tx_phy3[319:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[15:0]), // Templated
             .ustrm_protid              (ustrm_protid_tmp[7:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[1023:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[3:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[63:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[3:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[3:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[319:0]),
             .rx_phy1                   (rx_phy1[319:0]),
             .rx_phy2                   (rx_phy2[319:0]),
             .rx_phy3                   (rx_phy3[319:0]),
             .dstrm_state               (dstrm_state_tmp[15:0]), // Templated
             .dstrm_protid              (dstrm_protid_tmp[7:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[1023:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[3:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[63:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[3:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[3:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[3:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X16_Q2)
    if (X16_H2) // half rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:8]     = '0 ;
        assign  ustrm_protid_tmp    [7:4]      = '0 ;
        assign  ustrm_valid_tmp     [3:2]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign  ustrm_crc_tmp       [63:32]    = '0 ;
        assign  ustrm_data_tmp      [1023:512] = '0 ;

        assign  ll_tx_phy0  [319:160] = '0;
        assign  ll_tx_phy1  [319:160] = '0;
        assign  ll_tx_phy2  [319:160] = '0;
        assign  ll_tx_phy3  [319:160] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x16_asym2_half_master_top
          lpif_txrx_x16_asym2_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[159:0]),     // Templated
             .tx_phy1                   (ll_tx_phy1[159:0]),     // Templated
             .tx_phy2                   (ll_tx_phy2[159:0]),     // Templated
             .tx_phy3                   (ll_tx_phy3[159:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[511:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[31:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[159:0]),
             .rx_phy1                   (rx_phy1[159:0]),
             .rx_phy2                   (rx_phy2[159:0]),
             .rx_phy3                   (rx_phy3[159:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[511:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[31:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X16_H2)
    if (X16_F2) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:16]    = '0 ;
        assign  ustrm_data_tmp      [1023:256] = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:80] = '0;
        assign  ll_tx_phy3  [319:80] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x16_asym2_full_master_top
          lpif_txrx_x16_asym2_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[79:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[255:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[15:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .rx_phy2                   (rx_phy2[79:0]),
             .rx_phy3                   (rx_phy3[79:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[255:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[15:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X16_F2)
    if (X8_Q2) // quarter rate
      begin

        // Lint Cleanup
        assign  ustrm_crc_tmp       [63:32]    = '0 ;
        assign  ustrm_data_tmp      [1023:512] = '0 ;

        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x8_asym2_quarter_master_top
          lpif_txrx_x8_asym2_quarter_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[319:0]),     // Templated
             .tx_phy1                   (ll_tx_phy1[319:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[15:0]), // Templated
             .ustrm_protid              (ustrm_protid_tmp[7:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[511:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[3:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[31:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[3:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[3:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[319:0]),
             .rx_phy1                   (rx_phy1[319:0]),
             .dstrm_state               (dstrm_state_tmp[15:0]), // Templated
             .dstrm_protid              (dstrm_protid_tmp[7:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[511:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[3:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[31:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[3:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[3:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[3:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X8_H2) // half rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:8]     = '0 ;
        assign  ustrm_protid_tmp    [7:4]      = '0 ;
        assign  ustrm_valid_tmp     [3:2]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign  ustrm_crc_tmp       [63:16]    = '0 ;
        assign  ustrm_data_tmp      [1023:256] = '0 ;

        assign  ll_tx_phy0  [319:160] = '0;
        assign  ll_tx_phy1  [319:160] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x8_asym2_half_master_top
          lpif_txrx_x8_asym2_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[159:0]),     // Templated
             .tx_phy1                   (ll_tx_phy1[159:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[255:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[15:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[159:0]),
             .rx_phy1                   (rx_phy1[159:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[255:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[15:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X8_F2) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:8]     = '0 ;
        assign  ustrm_data_tmp      [1023:128] = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x8_asym2_full_master_top
          lpif_txrx_x8_asym2_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[127:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[7:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[127:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[7:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X4_Q2) // quarter rate
      begin

        // Lint Cleanup
        assign  ustrm_crc_tmp       [63:16]    = '0 ;
        assign  ustrm_data_tmp      [1023:256] = '0 ;

        assign  ll_tx_phy1  [319:0] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x4_asym2_quarter_master_top
          lpif_txrx_x4_asym2_quarter_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[319:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[15:0]), // Templated
             .ustrm_protid              (ustrm_protid_tmp[7:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[255:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[3:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[15:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[3:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[3:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[319:0]),
             .dstrm_state               (dstrm_state_tmp[15:0]), // Templated
             .dstrm_protid              (dstrm_protid_tmp[7:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[255:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[3:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[15:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[3:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[3:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[3:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X4_H2) // half rate
      begin

        // Lint Cleanup
        assign ustrm_state_tmp     [15:8]     = '0 ;
        assign ustrm_protid_tmp    [7:4]      = '0 ;
        assign ustrm_valid_tmp     [3:2]      = '0 ;
        assign ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign ustrm_crc_tmp       [63:8]     = '0 ;
        assign ustrm_data_tmp      [1023:128] = '0 ;

        assign  ll_tx_phy0  [319:160] = '0;
        assign  ll_tx_phy1  [319:0] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x4_asym2_half_master_top
          lpif_txrx_x4_asym2_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[159:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[127:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[7:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[159:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[127:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[7:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X4_F2) // full rate
      begin

        // Lint Cleanup
        assign ustrm_state_tmp     [15:4]     = '0 ;
        assign ustrm_protid_tmp    [7:2]      = '0 ;
        assign ustrm_valid_tmp     [3:1]      = '0 ;
        assign ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign ustrm_crc_tmp       [63:4]     = '0 ;
        assign ustrm_data_tmp      [1023:64]  = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:0] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x4_asym2_full_master_top
          lpif_txrx_x4_asym2_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[63:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[3:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[63:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[3:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X16_H1) // half rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:8]     = '0 ;
        assign  ustrm_protid_tmp    [7:4]      = '0 ;
        assign  ustrm_valid_tmp     [3:2]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign  ustrm_crc_tmp       [63:32]    = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:80] = '0;
        assign  ll_tx_phy3  [319:80] = '0;
        assign  ll_tx_phy4  [319:80] = '0;
        assign  ll_tx_phy5  [319:80] = '0;
        assign  ll_tx_phy6  [319:80] = '0;
        assign  ll_tx_phy7  [319:80] = '0;
        assign  ll_tx_phy8  [319:80] = '0;
        assign  ll_tx_phy9  [319:80] = '0;
        assign  ll_tx_phy10 [319:80] = '0;
        assign  ll_tx_phy11 [319:80] = '0;
        assign  ll_tx_phy12 [319:80] = '0;
        assign  ll_tx_phy13 [319:80] = '0;
        assign  ll_tx_phy14 [319:80] = '0;
        assign  ll_tx_phy15 [319:80] = '0;

        lpif_txrx_x16_asym1_half_master_top
          lpif_txrx_x16_asym1_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[79:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[79:0]),      // Templated
             .tx_phy4                   (ll_tx_phy4[79:0]),      // Templated
             .tx_phy5                   (ll_tx_phy5[79:0]),      // Templated
             .tx_phy6                   (ll_tx_phy6[79:0]),      // Templated
             .tx_phy7                   (ll_tx_phy7[79:0]),      // Templated
             .tx_phy8                   (ll_tx_phy8[79:0]),      // Templated
             .tx_phy9                   (ll_tx_phy9[79:0]),      // Templated
             .tx_phy10                  (ll_tx_phy10[79:0]),     // Templated
             .tx_phy11                  (ll_tx_phy11[79:0]),     // Templated
             .tx_phy12                  (ll_tx_phy12[79:0]),     // Templated
             .tx_phy13                  (ll_tx_phy13[79:0]),     // Templated
             .tx_phy14                  (ll_tx_phy14[79:0]),     // Templated
             .tx_phy15                  (ll_tx_phy15[79:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[1023:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[31:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .rx_phy2                   (rx_phy2[79:0]),
             .rx_phy3                   (rx_phy3[79:0]),
             .rx_phy4                   (rx_phy4[79:0]),
             .rx_phy5                   (rx_phy5[79:0]),
             .rx_phy6                   (rx_phy6[79:0]),
             .rx_phy7                   (rx_phy7[79:0]),
             .rx_phy8                   (rx_phy8[79:0]),
             .rx_phy9                   (rx_phy9[79:0]),
             .rx_phy10                  (rx_phy10[79:0]),
             .rx_phy11                  (rx_phy11[79:0]),
             .rx_phy12                  (rx_phy12[79:0]),
             .rx_phy13                  (rx_phy13[79:0]),
             .rx_phy14                  (rx_phy14[79:0]),
             .rx_phy15                  (rx_phy15[79:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[1023:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[31:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X16_H1)
    if (X16_F1) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:16]    = '0 ;
        assign  ustrm_data_tmp      [1023:512] = '0 ;

        assign  ll_tx_phy0  [319:40] = '0;
        assign  ll_tx_phy1  [319:40] = '0;
        assign  ll_tx_phy2  [319:40] = '0;
        assign  ll_tx_phy3  [319:40] = '0;
        assign  ll_tx_phy4  [319:40] = '0;
        assign  ll_tx_phy5  [319:40] = '0;
        assign  ll_tx_phy6  [319:40] = '0;
        assign  ll_tx_phy7  [319:40] = '0;
        assign  ll_tx_phy8  [319:40] = '0;
        assign  ll_tx_phy9  [319:40] = '0;
        assign  ll_tx_phy10 [319:40] = '0;
        assign  ll_tx_phy11 [319:40] = '0;
        assign  ll_tx_phy12 [319:40] = '0;
        assign  ll_tx_phy13 [319:40] = '0;
        assign  ll_tx_phy14 [319:40] = '0;
        assign  ll_tx_phy15 [319:40] = '0;

        lpif_txrx_x16_asym1_full_master_top
          lpif_txrx_x16_asym1_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[39:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[39:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[39:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[39:0]),      // Templated
             .tx_phy4                   (ll_tx_phy4[39:0]),      // Templated
             .tx_phy5                   (ll_tx_phy5[39:0]),      // Templated
             .tx_phy6                   (ll_tx_phy6[39:0]),      // Templated
             .tx_phy7                   (ll_tx_phy7[39:0]),      // Templated
             .tx_phy8                   (ll_tx_phy8[39:0]),      // Templated
             .tx_phy9                   (ll_tx_phy9[39:0]),      // Templated
             .tx_phy10                  (ll_tx_phy10[39:0]),     // Templated
             .tx_phy11                  (ll_tx_phy11[39:0]),     // Templated
             .tx_phy12                  (ll_tx_phy12[39:0]),     // Templated
             .tx_phy13                  (ll_tx_phy13[39:0]),     // Templated
             .tx_phy14                  (ll_tx_phy14[39:0]),     // Templated
             .tx_phy15                  (ll_tx_phy15[39:0]),     // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[511:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[15:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[39:0]),
             .rx_phy1                   (rx_phy1[39:0]),
             .rx_phy2                   (rx_phy2[39:0]),
             .rx_phy3                   (rx_phy3[39:0]),
             .rx_phy4                   (rx_phy4[39:0]),
             .rx_phy5                   (rx_phy5[39:0]),
             .rx_phy6                   (rx_phy6[39:0]),
             .rx_phy7                   (rx_phy7[39:0]),
             .rx_phy8                   (rx_phy8[39:0]),
             .rx_phy9                   (rx_phy9[39:0]),
             .rx_phy10                  (rx_phy10[39:0]),
             .rx_phy11                  (rx_phy11[39:0]),
             .rx_phy12                  (rx_phy12[39:0]),
             .rx_phy13                  (rx_phy13[39:0]),
             .rx_phy14                  (rx_phy14[39:0]),
             .rx_phy15                  (rx_phy15[39:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[511:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[15:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X16_F1)
    if (X8_H1) // half rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:8]     = '0 ;
        assign  ustrm_protid_tmp    [7:4]      = '0 ;
        assign  ustrm_valid_tmp     [3:2]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign  ustrm_crc_tmp       [63:32]    = '0 ;
        assign  ustrm_data_tmp      [1023:512] = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:80] = '0;
        assign  ll_tx_phy3  [319:80] = '0;
        assign  ll_tx_phy4  [319:80] = '0;
        assign  ll_tx_phy5  [319:80] = '0;
        assign  ll_tx_phy6  [319:80] = '0;
        assign  ll_tx_phy7  [319:80] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x8_asym1_half_master_top
          lpif_txrx_x8_asym1_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[79:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[79:0]),      // Templated
             .tx_phy4                   (ll_tx_phy4[79:0]),      // Templated
             .tx_phy5                   (ll_tx_phy5[79:0]),      // Templated
             .tx_phy6                   (ll_tx_phy6[79:0]),      // Templated
             .tx_phy7                   (ll_tx_phy7[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[511:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[15:0]),   // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .rx_phy2                   (rx_phy2[79:0]),
             .rx_phy3                   (rx_phy3[79:0]),
             .rx_phy4                   (rx_phy4[79:0]),
             .rx_phy5                   (rx_phy5[79:0]),
             .rx_phy6                   (rx_phy6[79:0]),
             .rx_phy7                   (rx_phy7[79:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[511:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[15:0]),   // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X8_H1)
    if (X8_F1) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:8]     = '0 ;
        assign  ustrm_data_tmp      [1023:256] = '0 ;

        assign  ll_tx_phy0  [319:40] = '0;
        assign  ll_tx_phy1  [319:40] = '0;
        assign  ll_tx_phy2  [319:40] = '0;
        assign  ll_tx_phy3  [319:40] = '0;
        assign  ll_tx_phy4  [319:40] = '0;
        assign  ll_tx_phy5  [319:40] = '0;
        assign  ll_tx_phy6  [319:40] = '0;
        assign  ll_tx_phy7  [319:40] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x8_asym1_full_master_top
          lpif_txrx_x8_asym1_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[39:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[39:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[39:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[39:0]),      // Templated
             .tx_phy4                   (ll_tx_phy4[39:0]),      // Templated
             .tx_phy5                   (ll_tx_phy5[39:0]),      // Templated
             .tx_phy6                   (ll_tx_phy6[39:0]),      // Templated
             .tx_phy7                   (ll_tx_phy7[39:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[255:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[7:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[39:0]),
             .rx_phy1                   (rx_phy1[39:0]),
             .rx_phy2                   (rx_phy2[39:0]),
             .rx_phy3                   (rx_phy3[39:0]),
             .rx_phy4                   (rx_phy4[39:0]),
             .rx_phy5                   (rx_phy5[39:0]),
             .rx_phy6                   (rx_phy6[39:0]),
             .rx_phy7                   (rx_phy7[39:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[255:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[7:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X8_F1)
    if (X4_H1) // half rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:8]     = '0 ;
        assign  ustrm_protid_tmp    [7:4]      = '0 ;
        assign  ustrm_valid_tmp     [3:2]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign  ustrm_crc_tmp       [63:8]     = '0 ;
        assign  ustrm_data_tmp      [1023:256] = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:80] = '0;
        assign  ll_tx_phy3  [319:80] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x4_asym1_half_master_top
          lpif_txrx_x4_asym1_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[79:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[255:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[7:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .rx_phy2                   (rx_phy2[79:0]),
             .rx_phy3                   (rx_phy3[79:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[255:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[7:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X4_H1)
    if (X4_F1) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:4]     = '0 ;
        assign  ustrm_data_tmp      [1023:128] = '0 ;

        assign  ll_tx_phy0  [319:40] = '0;
        assign  ll_tx_phy1  [319:40] = '0;
        assign  ll_tx_phy2  [319:40] = '0;
        assign  ll_tx_phy3  [319:40] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x4_asym1_full_master_top
          lpif_txrx_x4_asym1_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[39:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[39:0]),      // Templated
             .tx_phy2                   (ll_tx_phy2[39:0]),      // Templated
             .tx_phy3                   (ll_tx_phy3[39:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[127:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[3:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[39:0]),
             .rx_phy1                   (rx_phy1[39:0]),
             .rx_phy2                   (rx_phy2[39:0]),
             .rx_phy3                   (rx_phy3[39:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[127:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[3:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end // if (X4_F1)
    if (X2_H1) // half rate
      begin

        // Lint Cleanup
        assign ustrm_state_tmp     [15:8]     = '0 ;
        assign ustrm_protid_tmp    [7:4]      = '0 ;
        assign ustrm_valid_tmp     [3:2]      = '0 ;
        assign ustrm_crc_valid_tmp [3:2]      = '0 ;
        assign ustrm_dvalid_tmp    [3:2]      = '0 ;
        assign ustrm_crc_tmp       [63:4]     = '0 ;
        assign ustrm_data_tmp      [1023:128] = '0 ;

        assign  ll_tx_phy0  [319:80] = '0;
        assign  ll_tx_phy1  [319:80] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x2_asym1_half_master_top
          lpif_txrx_x2_asym1_half_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[79:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[79:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[7:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[3:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[127:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[1:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[3:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[1:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[1:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[79:0]),
             .rx_phy1                   (rx_phy1[79:0]),
             .dstrm_state               (dstrm_state_tmp[7:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[3:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[127:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[1:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[3:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[1:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[1:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[1:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
    if (X2_F1) // full rate
      begin

        // Lint Cleanup
        assign  ustrm_state_tmp     [15:4]     = '0 ;
        assign  ustrm_protid_tmp    [7:2]      = '0 ;
        assign  ustrm_valid_tmp     [3:1]      = '0 ;
        assign  ustrm_crc_valid_tmp [3:1]      = '0 ;
        assign  ustrm_dvalid_tmp    [3:1]      = '0 ;
        assign  ustrm_crc_tmp       [63:2]     = '0 ;
        assign  ustrm_data_tmp      [1023:64]  = '0 ;

        assign  ll_tx_phy0  [319:40] = '0;
        assign  ll_tx_phy1  [319:40] = '0;
        assign  ll_tx_phy2  [319:0] = '0;
        assign  ll_tx_phy3  [319:0] = '0;
        assign  ll_tx_phy4  [319:0] = '0;
        assign  ll_tx_phy5  [319:0] = '0;
        assign  ll_tx_phy6  [319:0] = '0;
        assign  ll_tx_phy7  [319:0] = '0;
        assign  ll_tx_phy8  [319:0] = '0;
        assign  ll_tx_phy9  [319:0] = '0;
        assign  ll_tx_phy10 [319:0] = '0;
        assign  ll_tx_phy11 [319:0] = '0;
        assign  ll_tx_phy12 [319:0] = '0;
        assign  ll_tx_phy13 [319:0] = '0;
        assign  ll_tx_phy14 [319:0] = '0;
        assign  ll_tx_phy15 [319:0] = '0;

        lpif_txrx_x2_asym1_full_master_top
          lpif_txrx_x2_asym1_full_master_top_i
            (/*AUTOINST*/
             // Outputs
             .tx_phy0                   (ll_tx_phy0[39:0]),      // Templated
             .tx_phy1                   (ll_tx_phy1[39:0]),      // Templated
             .ustrm_state               (ustrm_state_tmp[3:0]),  // Templated
             .ustrm_protid              (ustrm_protid_tmp[1:0]), // Templated
             .ustrm_data                (ustrm_data_tmp[63:0]),
             .ustrm_dvalid              (ustrm_dvalid_tmp[0:0]), // Templated
             .ustrm_crc                 (ustrm_crc_tmp[1:0]),    // Templated
             .ustrm_crc_valid           (ustrm_crc_valid_tmp[0:0]), // Templated
             .ustrm_valid               (ustrm_valid_tmp[0:0]),  // Templated
             .tx_downstream_debug_status(tx_downstream_debug_status[31:0]),
             .rx_upstream_debug_status  (rx_upstream_debug_status[31:0]),
             // Inputs
             .clk_wr                    (com_clk),               // Templated
             .rst_wr_n                  (rst_n),                 // Templated
             .tx_online                 (tx_online),
             .rx_online                 (rx_online),
             .init_downstream_credit    (8'h00),                 // Templated
             .rx_phy0                   (rx_phy0[39:0]),
             .rx_phy1                   (rx_phy1[39:0]),
             .dstrm_state               (dstrm_state_tmp[3:0]),  // Templated
             .dstrm_protid              (dstrm_protid_tmp[1:0]), // Templated
             .dstrm_data                (dstrm_data_tmp[63:0]),
             .dstrm_dvalid              (dstrm_dvalid_tmp[0:0]), // Templated
             .dstrm_crc                 (dstrm_crc_tmp[1:0]),    // Templated
             .dstrm_crc_valid           (dstrm_crc_valid_tmp[0:0]), // Templated
             .dstrm_valid               (dstrm_valid_tmp[0:0]),  // Templated
             .m_gen2_mode               (m_gen2_mode),
             .tx_mrk_userbit            (tx_mrk_userbit[0:0]),
             .tx_stb_userbit            (tx_stb_userbit),
             .delay_x_value             (delay_x_value[15:0]),
             .delay_y_value             (delay_y_value[15:0]),
             .delay_z_value             (delay_z_value[15:0]));
      end
  endgenerate

  // strobe and marker generation

  localparam STB_INTERVAL = 16'h8;
  localparam STB_DELAY = 16'h14;

  // external rate encodings

  localparam [1:0] /* auto enum ext_rate_info */
    PORT_FULL		= 2'h0,
    PORT_HALF		= 2'h1,
    PORT_QUARTER	= 2'h2;

  logic [1:0]         /* auto enum ext_rate_info */
                      remote_rate_port_int;
  assign remote_rate_port_int = remote_rate_port;

  /*AUTOASCIIENUM("remote_rate_port_int", "remote_rate_port_ascii", "")*/
  // Beginning of automatic ASCII enum decoding
  reg [95:0]            remote_rate_port_ascii; // Decode of remote_rate_port_int
  always @(remote_rate_port_int) begin
    case ({remote_rate_port_int})
      PORT_FULL:    remote_rate_port_ascii = "port_full   ";
      PORT_HALF:    remote_rate_port_ascii = "port_half   ";
      PORT_QUARTER: remote_rate_port_ascii = "port_quarter";
      default:      remote_rate_port_ascii = "%Error      ";
    endcase // case ({remote_rate_port_int})
  end
  // End of automatics

  // internal rate encodings

  localparam [3:0] /* auto enum int_rate_info */
    RATE_FULL		= 4'h1,
    RATE_HALF		= 4'h2,
    RATE_QUARTER	= 4'h4;


  logic [3:0]         /* auto enum int_rate_info */
                      local_rate, remote_rate;

  /*AUTOASCIIENUM("local_rate", "local_rate_ascii", "")*/
  // Beginning of automatic ASCII enum decoding
  reg [95:0]            local_rate_ascii;       // Decode of local_rate
  always @(local_rate) begin
    case ({local_rate})
      RATE_FULL:    local_rate_ascii = "rate_full   ";
      RATE_HALF:    local_rate_ascii = "rate_half   ";
      RATE_QUARTER: local_rate_ascii = "rate_quarter";
      default:      local_rate_ascii = "%Error      ";
    endcase // case ({local_rate})
  end
  // End of automatics
  /*AUTOASCIIENUM("remote_rate", "remote_rate_ascii", "")*/
  // Beginning of automatic ASCII enum decoding
  reg [95:0]            remote_rate_ascii;      // Decode of remote_rate
  always @(remote_rate) begin
    case ({remote_rate})
      RATE_FULL:    remote_rate_ascii = "rate_full   ";
      RATE_HALF:    remote_rate_ascii = "rate_half   ";
      RATE_QUARTER: remote_rate_ascii = "rate_quarter";
      default:      remote_rate_ascii = "%Error      ";
    endcase // case ({remote_rate})
  end
  // End of automatics

  wire                local_rate_f = x16_f2 | x8_f2 | x4_f2 | x16_f1 | x8_f1 | x4_f1 | x2_f1 | x1_f1;
  wire                local_rate_h = x16_h2 | x8_h2 | x4_h2 | x16_h1 | x8_h1 | x4_h1 | x2_h1 | x1_h1;
  wire                local_rate_q = x16_q2 | x8_q2 | x4_q2;

  always_comb
    begin
      case ({local_rate_f, local_rate_h, local_rate_q})
        3'b100: local_rate = RATE_FULL;
        3'b010: local_rate = RATE_HALF;
        3'b001: local_rate = RATE_QUARTER;
        default: local_rate = RATE_FULL;
      endcase // case ({local_rate_f, local_rate_h, local_rate_q})
      case (remote_rate_port)
        PORT_FULL: remote_rate = RATE_FULL;
        PORT_HALF: remote_rate = RATE_HALF;
        PORT_QUARTER: remote_rate = RATE_QUARTER;
        default: remote_rate = RATE_FULL;
      endcase // case (remote_rate_port)
    end

  localparam RX_FIFO_DEPTH = 8'd8;
  localparam BASE_STB_INTV = 12'd3 * RX_FIFO_DEPTH;  // 3 is the recommended factor

  assign fifo_full_val   = RX_FIFO_DEPTH;
  assign fifo_pfull_val  = RX_FIFO_DEPTH-4;
  assign fifo_pempty_val = 3'h4;
  assign fifo_empty_val  = 3'h0;

  always_comb
    begin
       lpif_rx_stb_intv = BASE_STB_INTV;
       
       // The below is implementing lpif_tx_stb_intv = BASE_STB_INTV * remote_rate / local_rate;
       lpif_tx_stb_intv = (BASE_STB_INTV << remote_rate[3:1]) >> local_rate[3:1];
    end

  /* strobe_gen_w_delay AUTO_TEMPLATE (
   .clk         (com_clk),
   .rst_n       (rst_n),
   .user_strobe (tx_stb_userbit),
   .interval    (lpif_tx_stb_intv),
   .delay_value (STB_DELAY),
   .user_marker (tx_mrk_userbit_vld),
   .online      (tx_online),
   ); */

  strobe_gen_w_delay
    strobe_gen_w_delay_i
      (/*AUTOINST*/
       // Outputs
       .user_strobe                     (tx_stb_userbit),        // Templated
       // Inputs
       .clk                             (com_clk),               // Templated
       .rst_n                           (rst_n),                 // Templated
       .interval                        (lpif_tx_stb_intv),      // Templated
       .delay_value                     (STB_DELAY),             // Templated
       .user_marker                     (tx_mrk_userbit_vld),    // Templated
       .online                          (tx_online));             // Templated

  /* marker_gen AUTO_TEMPLATE (
   .clk         (com_clk),
   .rst_n       (rst_n),
   .user_marker (tx_mrk_userbit[]),
   ); */

  marker_gen
    marker_gen_i
      (/*AUTOINST*/
       // Outputs
       .user_marker                     (tx_mrk_userbit[3:0]),   // Templated
       // Inputs
       .clk                             (com_clk),               // Templated
       .rst_n                           (rst_n),                 // Templated
       .local_rate                      (local_rate[3:0]),
       .remote_rate                     (remote_rate[3:0]));

endmodule // lpif_txrx

// Local Variables:
// verilog-library-directories:("." "./lpif_txrx" "./lpif_txrx_asym" "${PROJ_DIR}/common/rtl" "${PROJ_DIR}/common/dv")
// verilog-auto-inst-param-value:t
// End:

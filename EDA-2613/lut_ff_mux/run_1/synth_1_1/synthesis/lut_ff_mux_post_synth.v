/* Generated by Yosys 0.18+10 (git sha1 22058a10a, gcc 11.2.1 -fPIC -Os) */

module lut_ff_mux(clk, in, rst, Q, mux_sel);
  input clk;
  output Q;
  input [3:0] in;
  input mux_sel;
  input rst;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/lut_map.v:12.23-12.24" *)
  wire [5:0] \$techmap648$abc$634$auto$blifparse.cc:515:parse_blif$635.A ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/lut_map.v:13.13-13.14" *)
  wire \$techmap648$abc$634$auto$blifparse.cc:515:parse_blif$635.Y ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap647$iopadmap$lut_ff_mux.rst.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap647$iopadmap$lut_ff_mux.rst.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap647$iopadmap$lut_ff_mux.rst.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap646$iopadmap$lut_ff_mux.mux_sel.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap646$iopadmap$lut_ff_mux.mux_sel.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap646$iopadmap$lut_ff_mux.mux_sel.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap645$iopadmap$lut_ff_mux.in_3.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap645$iopadmap$lut_ff_mux.in_3.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap645$iopadmap$lut_ff_mux.in_3.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap644$iopadmap$lut_ff_mux.clk.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap644$iopadmap$lut_ff_mux.clk.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap644$iopadmap$lut_ff_mux.clk.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap643$iopadmap$lut_ff_mux.in_2.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap643$iopadmap$lut_ff_mux.in_2.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap643$iopadmap$lut_ff_mux.in_2.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap642$iopadmap$lut_ff_mux.in_1.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap642$iopadmap$lut_ff_mux.in_1.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap642$iopadmap$lut_ff_mux.in_1.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:37.16-37.17" *)
  wire \$techmap641$iopadmap$lut_ff_mux.Q.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:38.16-38.17" *)
  wire \$techmap641$iopadmap$lut_ff_mux.Q.C ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:39.16-39.17" *)
  wire \$techmap641$iopadmap$lut_ff_mux.Q.O ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:24.16-24.17" *)
  wire \$techmap640$iopadmap$lut_ff_mux.in.I ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:25.16-25.18" *)
  wire \$techmap640$iopadmap$lut_ff_mux.in.EN ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:26.16-26.17" *)
  wire \$techmap640$iopadmap$lut_ff_mux.in.O ;
  wire \$iopadmap$clk ;
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:3.11-3.14" *)
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:3.11-3.14" *)
  wire clk;
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:5.12-5.13" *)
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:5.12-5.13" *)
  wire Q;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:2.17-2.19" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:2.17-2.19" *)
  wire [3:0] in;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:4.11-4.18" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:4.11-4.18" *)
  wire mux_sel;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:3.16-3.19" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:3.16-3.19" *)
  wire rst;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:11.12-11.13" *)
  wire \$techmap639$auto$clkbufmap.cc:261:execute$636.O ;
  wire \$auto$clkbufmap.cc:294:execute$638 ;
  wire \$iopadmap$Q ;
  wire \$abc$317$li0_li0 ;
  wire [3:0] \$iopadmap$in ;
  wire \$auto$clkbufmap.cc:262:execute$637 ;
  (* hdlname = "ff_inst Q" *)
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:12.15-12.58|/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:40.16-40.17" *)
  wire \ff_inst.Q ;
  (* hdlname = "ff_inst clk" *)
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:12.15-12.58|/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/Jira/./rtl/lut_ff_mux.v:38.15-38.18" *)
  wire \ff_inst.clk ;
  wire \$iopadmap$mux_sel ;
  wire \$iopadmap$rst ;
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:10.12-10.13" *)
  wire \$techmap639$auto$clkbufmap.cc:261:execute$636.I ;
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/lut_map.v:37.38-37.69" *)
  LUT6 #(
    .INIT_VALUE(64'h000f00f400f0000b)
  ) \$abc$634$auto$blifparse.cc:515:parse_blif$635  (
    .Y(\$abc$317$li0_li0 ),
    .A({ \$iopadmap$mux_sel , \$iopadmap$in [1], \$iopadmap$rst , \$iopadmap$in [0], \$iopadmap$in [2], \$iopadmap$in [3] })
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.in_3  (
    .O(\$iopadmap$in [3]),
    .EN(1'h1),
    .I(in[3])
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.clk  (
    .O(\$iopadmap$clk ),
    .EN(1'h1),
    .I(clk)
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.in_1  (
    .O(\$iopadmap$in [1]),
    .EN(1'h1),
    .I(in[1])
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$iopadmap$lut_ff_mux.Q  (
    .O(Q),
    .I(\$iopadmap$Q )
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.mux_sel  (
    .O(\$iopadmap$mux_sel ),
    .EN(1'h1),
    .I(mux_sel)
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.in  (
    .O(\$iopadmap$in [0]),
    .EN(1'h1),
    .I(in[0])
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.in_2  (
    .O(\$iopadmap$in [2]),
    .EN(1'h1),
    .I(in[2])
  );
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:14.13-14.45" *)
  CLK_BUF \$auto$clkbufmap.cc:261:execute$636  (
    .O(\$auto$clkbufmap.cc:294:execute$638 ),
    .I(\$auto$clkbufmap.cc:262:execute$637 )
  );
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/ffs_map.v:10.11-10.70" *)
  DFFRE \$abc$317$auto$blifparse.cc:362:parse_blif$318  (
    .C(\$auto$clkbufmap.cc:294:execute$638 ),
    .D(\$abc$317$li0_li0 ),
    .E(1'h1),
    .Q(\$iopadmap$Q ),
    .R(1'h1)
  );
  (* keep = 32'h00000001 *)
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/03_20_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$iopadmap$lut_ff_mux.rst  (
    .O(\$iopadmap$rst ),
    .EN(1'h1),
    .I(rst)
  );
  assign \ff_inst.Q  = \$iopadmap$Q ;
  assign \ff_inst.clk  = \$auto$clkbufmap.cc:294:execute$638 ;
  assign \$auto$clkbufmap.cc:262:execute$637  = \$iopadmap$clk ;
endmodule

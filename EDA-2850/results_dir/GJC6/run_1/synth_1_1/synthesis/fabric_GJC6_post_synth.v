/* Generated by Yosys 0.38 (git sha1 45a28179e, gcc 11.2.1 -fPIC -Os) */

module fabric_GJC6(\$auto$clkbufmap.cc:298:execute$445 , \$auto$rs_design_edit.cc:841:execute$452 , \$auto$rs_design_edit.cc:841:execute$453 , \$auto$rs_design_edit.cc:841:execute$454 , \$iopadmap$din , \$iopadmap$oe , \$iopadmap$tristate_out );
  input \$iopadmap$din ;
  input \$iopadmap$oe ;
  output \$iopadmap$tristate_out ;
  input \$auto$clkbufmap.cc:298:execute$445 ;
  output \$auto$rs_design_edit.cc:841:execute$452 ;
  output \$auto$rs_design_edit.cc:841:execute$453 ;
  output \$auto$rs_design_edit.cc:841:execute$454 ;
  wire \$iopadmap$din ;
  wire \$iopadmap$oe ;
  wire \$iopadmap$tristate_out ;
  wire \$auto$clkbufmap.cc:298:execute$445 ;
  wire \$auto$rs_design_edit.cc:841:execute$452 ;
  wire \$auto$rs_design_edit.cc:841:execute$453 ;
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/13may/Validation/RTL_testcases/GJC-IO-Testcases/GJC6/results_dir/.././rtl/GJC6.v:19.8-19.10" *)
  wire q1;
  (* keep = 32'h00000001 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/13may/Validation/RTL_testcases/GJC-IO-Testcases/GJC6/results_dir/.././rtl/GJC6.v:20.8-20.10" *)
  wire q2;
  wire \$auto$rs_design_edit.cc:841:execute$454 ;
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_14_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/lut_map.v:21.38-21.69" *)
  LUT2 #(
    .INIT_VALUE(4'h8)
  ) \$abc$441$auto$blifparse.cc:535:parse_blif$442  (
    .A({ q2, \$iopadmap$oe  }),
    .Y(\$iopadmap$tristate_out )
  );
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_14_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/ffs_map.v:10.11-10.70" *)
  DFFRE \$abc$196$auto$blifparse.cc:377:parse_blif$197  (
    .C(\$auto$clkbufmap.cc:298:execute$445 ),
    .D(\$iopadmap$din ),
    .E(1'h1),
    .Q(q1),
    .R(1'h1)
  );
  (* module_not_derived = 32'h00000001 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_14_2024_09_15_01/bin/../share/yosys/rapidsilicon/genesis3/ffs_map.v:10.11-10.70" *)
  DFFRE \$abc$196$auto$blifparse.cc:377:parse_blif$198  (
    .C(\$auto$clkbufmap.cc:298:execute$445 ),
    .D(q1),
    .E(1'h1),
    .Q(q2),
    .R(1'h1)
  );
  assign \$auto$rs_design_edit.cc:841:execute$452  = 1'h1;
  assign \$auto$rs_design_edit.cc:841:execute$453  = 1'h1;
  assign \$auto$rs_design_edit.cc:841:execute$454  = 1'h1;
endmodule

/* Generated by Yosys 0.38 (git sha1 d70ee20a8, gcc 11.2.1 -fPIC -Os) */

module I_DELAY_primitive_inst_post_route (reset, in, DLY_LOAD, DLY_ADJ, DLY_INCDEC, DLY_TAP_VALUE, CLK_IN, O);
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:10.9-10.15" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:7.9-7.16" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:8.9-8.19" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:6.9-6.17" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:9.16-9.29" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:11.10-11.11" *)
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:14.5-14.8" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:5.9-5.11" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:4.9-4.14" *)
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:10.9-10.15" *)
  input CLK_IN;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:7.9-7.16" *)
  input DLY_ADJ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:8.9-8.19" *)
  input DLY_INCDEC;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:6.9-6.17" *)
  input DLY_LOAD;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:9.16-9.29" *)
  output [5:0] DLY_TAP_VALUE;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:11.10-11.11" *)
  output O;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:14.5-14.8" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:5.9-5.11" *)
  input in;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:4.9-4.14" *)
  input reset;
  wire \$auto$clkbufmap.cc:298:execute$428 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 ;
  wire \$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 ;
  wire \$auto$rs_design_edit.cc:657:execute$444 ;
  wire \$auto$rs_design_edit.cc:657:execute$445 ;
  wire \$auto$rs_design_edit.cc:657:execute$446 ;
  wire \$auto$rs_design_edit.cc:657:execute$447 ;
  wire \$auto$rs_design_edit.cc:657:execute$448 ;
  wire \$auto$rs_design_edit.cc:657:execute$449 ;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:10.9-10.15" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.CLK_IN ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:7.9-7.16" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.DLY_ADJ ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:8.9-8.19" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.DLY_INCDEC ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:6.9-6.17" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.DLY_LOAD ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:9.16-9.29" *)
  wire [5:0] \$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:11.10-11.11" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.O ;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:14.5-14.8" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.dff ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:5.9-5.11" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.in ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:4.9-4.14" *)
  wire \$auto$rs_design_edit.cc:943:execute$465.reset ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$clkbufmap.cc:298:execute$428 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$444 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$445 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$446 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$447 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$448 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$449 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$458 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$459 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$460 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$461 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$462 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$463 ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$CLK_IN ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_ADJ ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_INCDEC ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_LOAD ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$in ;
  wire \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$reset ;
  wire \$iopadmap$CLK_IN ;
  wire \$iopadmap$DLY_ADJ ;
  wire \$iopadmap$DLY_INCDEC ;
  wire \$iopadmap$DLY_LOAD ;
  wire \$iopadmap$in ;
  wire \$iopadmap$reset ;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:10.9-10.15" *)
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:10.9-10.15" *)
  wire CLK_IN;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:7.9-7.16" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:7.9-7.16" *)
  wire DLY_ADJ;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:8.9-8.19" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:8.9-8.19" *)
  wire DLY_INCDEC;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:6.9-6.17" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:6.9-6.17" *)
  wire DLY_LOAD;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:9.16-9.29" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:9.16-9.29" *)
  wire [5:0] DLY_TAP_VALUE;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:11.10-11.11" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:11.10-11.11" *)
  wire O;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:14.5-14.8" *)
  wire dff;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:5.9-5.11" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:5.9-5.11" *)
  wire in;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:4.9-4.14" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:4.9-4.14" *)
  wire reset;
  fabric_I_DELAY_primitive_inst \$auto$rs_design_edit.cc:941:execute$464  (
    .\$auto$clkbufmap.cc:298:execute$428 (\$auto$clkbufmap.cc:298:execute$428 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 ),
    .\$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 (\$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 ),
    .\$auto$rs_design_edit.cc:657:execute$444 (\$auto$rs_design_edit.cc:657:execute$444 ),
    .\$auto$rs_design_edit.cc:657:execute$445 (\$auto$rs_design_edit.cc:657:execute$445 ),
    .\$auto$rs_design_edit.cc:657:execute$446 (\$auto$rs_design_edit.cc:657:execute$446 ),
    .\$auto$rs_design_edit.cc:657:execute$447 (\$auto$rs_design_edit.cc:657:execute$447 ),
    .\$auto$rs_design_edit.cc:657:execute$448 (\$auto$rs_design_edit.cc:657:execute$448 ),
    .\$auto$rs_design_edit.cc:657:execute$449 (\$auto$rs_design_edit.cc:657:execute$449 ),
    .\$iopadmap$in (\$iopadmap$in ),
    .\$iopadmap$reset (\$iopadmap$reset ),
    .dff(dff)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/os_fpga2/Validation/RTL_testcases/RS_FPGA_PRIMITIVES_new/I_DELAY_primitive_inst/results_dir/.././rtl/I_DELAY_primitive_inst.v:18.3-26.2" *)
  I_DELAY #(
    .DELAY(32'sd0)
  ) \$auto$rs_design_edit.cc:943:execute$465.inst  (
    .CLK_IN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$clkbufmap.cc:298:execute$428 ),
    .DLY_ADJ(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_ADJ ),
    .DLY_INCDEC(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_INCDEC ),
    .DLY_LOAD(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_LOAD ),
    .DLY_TAP_VALUE({ \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$463 , \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$458 , \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$459 , \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$462 , \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$460 , \$flatten$auto$rs_design_edit.cc:943:execute$465.$delete_wire$461  }),
    .I(\$auto$rs_design_edit.cc:943:execute$465.dff ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 )
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:14.13-14.45" *)
  CLK_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$clkbufmap.cc:265:execute$426  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$CLK_IN ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$clkbufmap.cc:298:execute$428 )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.CLK_IN  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$444 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.CLK_IN ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$CLK_IN )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_ADJ  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$445 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.DLY_ADJ ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_ADJ )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_INCDEC  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$446 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.DLY_INCDEC ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_INCDEC )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_LOAD  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$447 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.DLY_LOAD ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$DLY_LOAD )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [0])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE_1  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [1])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE_2  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [2])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE_3  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [3])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE_4  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [4])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.DLY_TAP_VALUE_5  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE [5])
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:41.13-41.44" *)
  O_BUF \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.O  (
    .I(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 ),
    .O(\$auto$rs_design_edit.cc:943:execute$465.O )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.in  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$448 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.in ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$in )
  );
  (* keep = 32'd1 *)
  (* module_not_derived = 32'd1 *)
  (* src = "/nfs_eda_sw/softwares/Raptor/instl_dir/05_07_2024_09_15_02/bin/../share/yosys/rapidsilicon/genesis3/io_cell_final_map.v:29.41-29.81" *)
  I_BUF #(
    .WEAK_KEEPER("NONE")
  ) \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$I_DELAY_primitive_inst.reset  (
    .EN(\$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$449 ),
    .I(\$auto$rs_design_edit.cc:943:execute$465.reset ),
    .O(\$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$reset )
  );
  assign \$auto$rs_design_edit.cc:332:add_wire_btw_prims$457  = \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$457 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$456  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$456 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$455  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$455 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$454  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$454 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$453  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$453 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$452  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$452 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$451  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$451 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:332:add_wire_btw_prims$450  = \$auto$rs_design_edit.cc:332:add_wire_btw_prims$450 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$449  = \$auto$rs_design_edit.cc:657:execute$449 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$448  = \$auto$rs_design_edit.cc:657:execute$448 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$447  = \$auto$rs_design_edit.cc:657:execute$447 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$446  = \$auto$rs_design_edit.cc:657:execute$446 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$445  = \$auto$rs_design_edit.cc:657:execute$445 ;
  assign \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$rs_design_edit.cc:657:execute$444  = \$auto$rs_design_edit.cc:657:execute$444 ;
  assign \$auto$clkbufmap.cc:298:execute$428  = \$flatten$auto$rs_design_edit.cc:943:execute$465.$auto$clkbufmap.cc:298:execute$428 ;
  assign \$iopadmap$in  = \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$in ;
  assign \$iopadmap$reset  = \$flatten$auto$rs_design_edit.cc:943:execute$465.$iopadmap$reset ;
  assign \$auto$rs_design_edit.cc:943:execute$465.CLK_IN  = CLK_IN;
  assign \$auto$rs_design_edit.cc:943:execute$465.DLY_ADJ  = DLY_ADJ;
  assign \$auto$rs_design_edit.cc:943:execute$465.DLY_INCDEC  = DLY_INCDEC;
  assign \$auto$rs_design_edit.cc:943:execute$465.DLY_LOAD  = DLY_LOAD;
  assign DLY_TAP_VALUE = \$auto$rs_design_edit.cc:943:execute$465.DLY_TAP_VALUE ;
  assign O = \$auto$rs_design_edit.cc:943:execute$465.O ;
  assign \$auto$rs_design_edit.cc:943:execute$465.dff  = dff;
  assign \$auto$rs_design_edit.cc:943:execute$465.in  = in;
  assign \$auto$rs_design_edit.cc:943:execute$465.reset  = reset;
endmodule


/* Generated by Yosys 0.18+10 (git sha1 07c42e625, gcc 11.2.1 -fPIC -Os) */

module dsp_multiplier_accum_with_add_neg(clk, reset, sel_c_or_p, A, B, C, D, P);
  input [15:0] D;
  output [31:0] P;
  input [15:0] C;
  input [15:0] B;
  input clk;
  input sel_c_or_p;
  input [15:0] A;
  input reset;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.31-3.32" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.31-3.32" *)
  wire [15:0] D;
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:4.27-4.28" *)
  (* keep = 32'd1 *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:4.27-4.28" *)
  wire [31:0] P;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.28-3.29" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.28-3.29" *)
  wire [15:0] C;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.25-3.26" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.25-3.26" *)
  wire [15:0] B;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.8-2.11" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.8-2.11" *)
  wire clk;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.20-2.30" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.20-2.30" *)
  wire sel_c_or_p;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.22-3.23" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:3.22-3.23" *)
  wire [15:0] A;
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.13-2.18" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/abdul_hameed/5th-march/dsp_multiplier_accum_with_add_neg/results_dir/.././rtl/dsp_multiplier_accum_with_add_neg.v:2.13-2.18" *)
  wire reset;
  fabric_dsp_multiplier_accum_with_add_neg \$auto$rs_design_edit.cc:561:execute$4589  (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .P(P),
    .clk(clk),
    .reset(reset),
    .sel_c_or_p(sel_c_or_p)
  );
  interface_dsp_multiplier_accum_with_add_neg \$auto$rs_design_edit.cc:563:execute$4590  (
  );
endmodule

module interface_dsp_multiplier_accum_with_add_neg();
endmodule

/* Generated by Yosys 0.18+10 (git sha1 f797bf10a, gcc 11.2.0 -fPIC -Os) */

module mux_8_1(out, D0, D1, D2, D3, D4, D5, D6, D7, S0, S1, S2);
  input D0;
  input D1;
  input D2;
  input D3;
  input D4;
  input D5;
  input D6;
  input D7;
  input S0;
  input S1;
  input S2;
  output out;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D0;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D1;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D2;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D3;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D4;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D5;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D6;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:3" *)
  wire D7;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  wire S0;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  wire S1;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:4" *)
  wire S2;
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:5" *)
  (* src = "/nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/test2/ArchBench/Testcases/mux_8_1/jira/./rtl/mux_8_1.v:5" *)
  wire out;
  \$lut  #(
    .LUT(32'hbfff8000),
    .WIDTH(32'h00000005)
  ) _0_ (
    .A({ D0, S1, S2, S0, D1 }),
    .Y(out)
  );
endmodule

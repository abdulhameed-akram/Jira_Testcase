read_verilog -sv /nfs_eda_sw/softwares/Raptor/instl_dir/10_11_2023_09_15_01/share/raptor/sim_models/rapidsilicon/genesis3/cell_sim_blackbox.v
verilog_defines 
read_verilog  -I../../../../.././rtl -I../../../../.. -I/nfs_scratch/scratch/CompilerValidation/abdul_hameed/blif_fifo_tb/Compiler_Validation/RTL_testcases/DSP_Designs/accumulator/results_dir/.././rtl  /nfs_scratch/scratch/CompilerValidation/abdul_hameed/blif_fifo_tb/Compiler_Validation/RTL_testcases/DSP_Designs/accumulator/results_dir/.././rtl/accumulator.v 

analyze -top accumulator

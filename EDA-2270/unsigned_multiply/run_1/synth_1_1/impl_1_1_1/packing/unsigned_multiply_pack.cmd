/nfs_eda_sw/softwares/Raptor/instl_dir/11_17_2023_09_15_01/bin/vpr /nfs_eda_sw/softwares/Raptor/instl_dir/11_17_2023_09_15_01/share/raptor/etc/devices/gemini_compact_10x8/gemini_vpr.xml /nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/EDA-2270/unsigned_multiply/run_1/synth_1_1/synthesis/unsigned_multiply_post_synth.eblif --sdc_file /nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/EDA-2270/unsigned_multiply/run_1/synth_1_1/impl_1_1_1/packing/unsigned_multiply_openfpga.sdc --route_chan_width 160 --suppress_warnings check_rr_node_warnings.log,check_rr_node --clock_modeling ideal --absorb_buffer_luts off --skip_sync_clustering_and_routing_results off --constant_net_method route --post_place_timing_report unsigned_multiply_post_place_timing.rpt --device castor10x8_heterogeneous --allow_unrelated_clustering on --allow_dangling_combinational_nodes on --place_delta_delay_matrix_calculation_method dijkstra --gen_post_synthesis_netlist on --post_synth_netlist_unconn_inputs gnd --inner_loop_recompute_divider 1 --max_router_iterations 1500 --timing_report_detail detailed --timing_report_npaths 100 --top unsigned_multiply --net_file /nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/EDA-2270/unsigned_multiply/run_1/synth_1_1/impl_1_1_1/packing/unsigned_multiply_post_synth.net --place_file /nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/EDA-2270/unsigned_multiply/run_1/synth_1_1/impl_1_1_1/placement/unsigned_multiply_post_synth.place --route_file /nfs_scratch/scratch/CompilerValidation/zaheer_ahmad/bitstream_simulation_new/EDA-2270/unsigned_multiply/run_1/synth_1_1/impl_1_1_1/routing/unsigned_multiply_post_synth.route --pack

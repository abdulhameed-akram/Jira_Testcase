/nfs_eda_sw/softwares/Raptor/instl_dir/03_06_2023_09_15_01/bin/vpr /nfs_eda_sw/softwares/Raptor/instl_dir/03_06_2023_09_15_01/share/raptor/etc/devices/gemini_compact_82x68/gemini_vpr.xml dsp_mul_signed_reg_neg_gemini_compact_post_synth.v --sdc_file dsp_mul_signed_reg_neg_gemini_compact_openfpga.sdc --route_chan_width 192 --suppress_warnings check_rr_node_warnings.log,check_rr_node --clock_modeling ideal --timing_report_npaths 100 --absorb_buffer_luts off --skip_sync_clustering_and_routing_results on --constant_net_method route --timing_report_detail detailed --post_place_timing_report dsp_mul_signed_reg_neg_gemini_compact_post_place_timing.rpt --device castor82x68_heterogeneous --gen_post_synthesis_netlist on --allow_dangling_combinational_nodes on --pack

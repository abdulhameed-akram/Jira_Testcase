/nfs_cadtools/raptor/instl_dir/bin/vpr /nfs_cadtools/raptor/instl_dir/share/raptor/etc/devices/gemini/gemini_vpr.xml rams_sp_reg_addr_1024x32_post_synth.blif --sdc_file rams_sp_reg_addr_1024x32_openfpga.sdc --route_chan_width 180 --suppress_warnings check_rr_node_warnings.log,check_rr_node --clock_modeling ideal --timing_report_npaths 100 --absorb_buffer_luts off --constant_net_method route --timing_report_detail detailed --post_place_timing_report rams_sp_reg_addr_1024x32_post_place_timing.rpt --device 78x66 --gen_post_synthesis_netlist on --allow_dangling_combinational_nodes on --place --fix_pins rams_sp_reg_addr_1024x32_pin_loc.place

create_design aes_decrypt128
target_device GEMINI
add_include_path ../rtl_no_synth_flags
add_design_file -SV_2017 ../rtl_no_synth_flags/aes_decrypt128.sv
set_top_module aes_decrypt128
 
synthesize


create_design b_registered_input_to_output
target_device GEMINI_COMPACT_10x8
add_design_file ./rtl/b_registered_input_to_output.v
set_top_module b_registered_input_to_output
analyze
synthesize
packing
place
route
sta
power
bitstream
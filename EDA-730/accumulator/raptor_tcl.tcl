create_design accumulator
target_device GEMINI
add_include_path ./rtl
add_library_path ./rtl
add_library_ext .v .sv
add_design_file ./rtl/accumulator.v
set_top_module accumulator
synthesize delay
packing
global_placement
place
route
sta
power
bitstream 

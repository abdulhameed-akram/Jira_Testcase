create_design ram_true_reg_addr_dp_1024x32
target_device GEMINI
add_include_path ./rtl
add_library_path ./rtl
add_library_ext .v .sv
add_design_file ./rtl/ram_true_reg_addr_dp_1024x32.v
set_top_module ram_true_reg_addr_dp_1024x32
synthesize delay
packing
global_placement
place
route
sta
power
bitstream 

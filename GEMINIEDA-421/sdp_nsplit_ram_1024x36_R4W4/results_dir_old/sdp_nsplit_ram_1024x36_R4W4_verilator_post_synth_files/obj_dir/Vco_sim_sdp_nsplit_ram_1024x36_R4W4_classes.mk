# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Make include file with class lists
#
# This file lists generated Verilated files, for including in higher level makefiles.
# See Vco_sim_sdp_nsplit_ram_1024x36_R4W4.mk for the caller.

### Switches...
# C11 constructs required?  0/1 (always on now)
VM_C11 = 1
# Timing enabled?  0/1
VM_TIMING = 1
# Coverage output mode?  0/1 (from --coverage)
VM_COVERAGE = 0
# Parallel builds?  0/1 (from --output-split)
VM_PARALLEL_BUILDS = 0
# Threaded output mode?  0/1/N threads (from --threads)
VM_THREADS = 0
# Tracing output mode?  0/1 (from --trace/--trace-fst)
VM_TRACE = 1
# Tracing output mode in VCD format?  0/1 (from --trace)
VM_TRACE_VCD = 1
# Tracing output mode in FST format?  0/1 (from --trace-fst)
VM_TRACE_FST = 0

### Object file lists...
# Generated module classes, fast-path, compile with highest optimization
VM_CLASSES_FAST += \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4 \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4___024root__DepSet_h6f5b6168__0 \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4___024root__DepSet_h621c27f2__0 \

# Generated module classes, non-fast-path, compile with low/medium optimization
VM_CLASSES_SLOW += \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4__ConstPool_0 \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4___024root__Slow \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4___024root__DepSet_h6f5b6168__0__Slow \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4___024root__DepSet_h621c27f2__0__Slow \

# Generated support classes, fast-path, compile with highest optimization
VM_SUPPORT_FAST += \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4__Trace__0 \

# Generated support classes, non-fast-path, compile with low/medium optimization
VM_SUPPORT_SLOW += \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4__Syms \
	Vco_sim_sdp_nsplit_ram_1024x36_R4W4__Trace__0__Slow \

# Global classes, need linked once per executable, fast-path, compile with highest optimization
VM_GLOBAL_FAST += \
	verilated \
	verilated_vcd_c \
	verilated_vcd_sc \
	verilated_timing \

# Global classes, need linked once per executable, non-fast-path, compile with low/medium optimization
VM_GLOBAL_SLOW += \


# Verilated -*- Makefile -*-

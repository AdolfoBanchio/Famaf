transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/writeback.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/flopr.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/imem.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/maindec.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/memory.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/mux2.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/processor_arm.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/regfile.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/signext.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/sl2.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/fetch.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/execute.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/decode.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/datapath.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/aludec.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/controller.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/alu.sv}
vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/adder.sv}
vcom -2008 -work work {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/dmem.vhd}

vlog -sv -work work +incdir+/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor {/home/adolfo/Documents/Famaf/3ro/Arqui/TP2_arm_processor/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all

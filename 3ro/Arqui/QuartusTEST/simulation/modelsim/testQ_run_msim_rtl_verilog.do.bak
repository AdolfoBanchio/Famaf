transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/adolfobanchio/Documents/Famaf/3ro/Arqui/QuartusTEST {/home/adolfobanchio/Documents/Famaf/3ro/Arqui/QuartusTEST/sillyfunction.sv}

vlog -sv -work work +incdir+/home/adolfobanchio/Documents/Famaf/3ro/Arqui/QuartusTEST {/home/adolfobanchio/Documents/Famaf/3ro/Arqui/QuartusTEST/sillyfunction_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sillyfunction_tb

add wave *
view structure
view signals
run -all

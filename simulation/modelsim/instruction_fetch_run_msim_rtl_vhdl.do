transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/karman/6-staged-pipelined-processor/memory.vhd}
vcom -93 -work work {/home/karman/6-staged-pipelined-processor/components_init.vhd}
vcom -93 -work work {/home/karman/6-staged-pipelined-processor/register_16.vhd}
vcom -93 -work work {/home/karman/6-staged-pipelined-processor/instruction_memory.vhd}
vcom -93 -work work {/home/karman/6-staged-pipelined-processor/incrementer_pc.vhd}
vcom -93 -work work {/home/karman/6-staged-pipelined-processor/instruction_fetch.vhd}


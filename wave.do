onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /gray_code_testbench/clock
add wave -noupdate /gray_code_testbench/reset
add wave -noupdate /gray_code_testbench/counter
add wave -noupdate /gray_code_testbench/input_valid
add wave -noupdate -color Blue -radix unsigned /gray_code_testbench/gray_code_input
add wave -noupdate /gray_code_testbench/output_valid
add wave -noupdate /gray_code_testbench/gray_code_output
add wave -noupdate -color Red /gray_code_testbench/gray_code/gray_code
add wave -noupdate /gray_code_testbench/gray_code/data_input
add wave -noupdate /gray_code_testbench/gray_code/i
add wave -noupdate /gray_code_testbench/gray_code/carry
add wave -noupdate /gray_code_testbench/gray_code/addend_a
add wave -noupdate /gray_code_testbench/gray_code/addend_b
add wave -noupdate /gray_code_testbench/gray_code/sum
add wave -noupdate /gray_code_testbench/current_gray_code
add wave -noupdate /gray_code_testbench/previous_gray_code
add wave -noupdate /gray_code_testbench/gray_code_difference
add wave -noupdate /gray_code_testbench/difference_sum
add wave -noupdate /gray_code_testbench/data_valid_reg0
add wave -noupdate /gray_code_testbench/data_valid_reg1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {656320975 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 277
configure wave -valuecolwidth 206
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {43177570 ps}

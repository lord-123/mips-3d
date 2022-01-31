# assume a 512x256 display at 0x10010000
.eqv DISPLAY_BASE 0x1001
.eqv DISPLAY_END  0X1009

.macro load_colour(%x, %r, %g, %b)
addi %x, $zero, %r
sll %x, %x, 8
ori %x, %x, %g
sll %x, %x, 8
ori %x, %x, %b
.end_macro

j main

# a0 - colour
set_bg:
lui $t0, DISPLAY_BASE
lui $t1, DISPLAY_END
bg_loop:
sw $a0, 0($t0)
addi $t0, $t0, 4
bne $t0, $t1, bg_loop
jr $ra

# a0 - colour, a1 - x, a2 - y1, a3 - y2
vline:
sll $a1, $a1, 2

sll $a2, $a2, 11
sll $a3, $a3, 11

lui $t0, DISPLAY_BASE
add $t1, $t0, $a3
add $t0, $t0, $a2
add $t0, $t0, $a1
add $t1, $t1, $a1
vline_loop:
sw $a0, 0($t0)
addi $t0, $t0, 2048
bne $t0, $t1, vline_loop
jr $ra

main:
load_colour($a0, 0x32, 0x93, 0xA8)
jal set_bg

load_colour($a0, 0xFF, 0x00, 0xFF)
addi $a1, $zero, 100
addi $a2, $zero, 50
addi $a3, $zero, 200
jal vline
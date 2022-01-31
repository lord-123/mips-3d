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

main:
load_colour($a0, 0x32, 0x93, 0xA8)
jal set_bg
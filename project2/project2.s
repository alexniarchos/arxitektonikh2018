.data
    array:
        .word   0x00000006  0x00000003  0x00000001  0x00000002 0x00000004  0x00000009  0x00000008  0x00000007 0x00000010  0x00000005
    arraySize:
        .word 10
.text

main:

la $t0,arraySize
lw $t0,0($t0)
la $s0,array

addi $t0,$t0,-1 # n-1
addi $t1,$zero,-1

# initialize $t1 to 0
# t1 -> i
# t2 -> j
loop1:
    addi $t1,$t1,1
    beq $t1, $t0, end
    # t3 -> n-i-1
    sub $t3,$t0,$t1
    addi $t2,$zero,-1
    la $s1,-4($s0)
    loop2:
        addi $t2,$t2,1
        beq $t2, $t3, loop1
        addiu $s1,$s1,4
        lw $t5,0($s1) #arr[j]
        lw $t6,4($s1) #arr[j+1]
        sub $t7,$t5,$t6
        blez $t7,loop2
        #swap
        sw $t6,0($s1) #arr[j]
        sw $t5,4($s1) #arr[j+1]


    jal loop2

end:
    li $v0,10 #au revoir...
    syscall
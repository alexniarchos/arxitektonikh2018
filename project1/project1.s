.data
    array:  
        .word 0x7FF0000000000000,0x7FF0000000000000

    len:  .word 2
    
    mask: .word 0x7FF0000000000000,0x000FFFFFFFFFFFFF,0x0000000000000001,0x0010000000000000,0x7FFFFFFFFFFFFFFF,0x8000000000000000

    CONTROL: .word 0x10000
	DATA:    .word 0x10008

.text

main:
    # r26-r31 counters
    dadd r23,$zero,$zero # r23 counter
    ld r24,len($zero)
    daddi r18,$zero,8
    dmul r24,r24,r18
bigloop:    
    slt r19,r23,r24
    beq r19,$zero,end
    daddi r20,$zero,0
    ld r1,array(r23)
    ld r3,mask($zero)
    and r2,r1,r3
    daddi r10,$zero,52
    dsrav r2,r2,r10         
    daddi r10,$zero,1023    
    dsub r2,r2,r10          # r2 exponent without polarazation
    daddi r10,$zero,8
    ld r3,mask(r10)
    and r3,r1,r3            # r3 mantissa
    daddi r10,$zero,63      
    dsrav r6,r1,r10
    daddi r10,$zero,16
    ld r5,mask(r10)
    and r4,r6,r5            # r4 sign
    daddi r10,$zero,1024
    beq r2,r10,checkabnormal
normal:
    daddi r10,$zero,24
    ld r6,mask(r10)
    slt r11,r2,$zero
    bne r11,$zero,negative_exp # check exponent 8etikos h arnhtikos
    # 8etikos h oudeteros
    slti r11,r2,62 # overflow check
    beq r11,$zero,overflow # overflow check
    daddi r5,$zero,1       # pairnw deutero kataxwrhth
loop:
    beq r2,$zero,endloop    
    dsll r3,r3,1    # bit bit shift aristera thn mantissa
    dsll r5,r5,1    # shift kai ton deutero kataxwrhth
    and r7,r3,r6    # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth:pairnw mono to stoixeio p bghke me bitwise and
    daddi r8,$zero,52  # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth: bazw sto kataxwrhth pou 8a xrhsimopoihsw san noumero to poses fores na kanei shift
    dsrlv r7,r7,r8   # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth shift 52 fores de3ia
    dadd r5,r5,r7   # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth: pros8etw to stoixeio ston deutero kataxwrhth
    daddi r8,$zero,1 # afairesh apo exponent
    dsub r2,r2,r8 # afairesh apo exponent
    jal loop
endloop: 
    dsll r3,r3,1    # teleutaio shift mantisa
    and r7,r3,r6    # an to bit pou bgei aristera twn 52 einai 1
    daddi r8,$zero,52  # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth: bazw sto kataxwrhth pou 8a xrhsimopoihsw san noumero to poses fores na kanei shift
    dsrlv r7,r7,r8
    beq r7,$zero,roundDown
    ld r9,array(r10)
    beq r5,r9,roundDown
    daddi r10,$zero,32
    daddi r5,r5,1   # tote stroggulopoihsh pros ta epanw
    daddi r20,$zero,1  # flag
    roundDown:      # alliws stroggulopoihsh pros ta katw
    beq r4,$zero,positive
    daddi r8,$zero,-1
    dmul r5,r5,r8
    daddi r27,r27,1
    jal cvt
positive:
    daddi r26,r26,1
    jal cvt
overflow:
    daddi r28,r28,1
    daddi r29,r29,1
    beq r4,$zero,posoverflow
    daddi r10,$zero,40
    ld r5,mask(r10)
    jal cvt
posoverflow:
    daddi r10,$zero,32
    ld r5,mask(r10)
    jal cvt
negative_exp:  # arnhtiko exponent
    daddi r12,$zero,-2
    slt r10,r12,r2 # tsekarw ton exponent an einai <-1 apeu8eias 0 an einai -1 tote 1 h -1 analoga to sign
    bne r10,$zero,applysign
    daddi r28,r28,1
    bne r3,$zero,simzero
    daddi r10,$zero,-1023
    bne r2,r10,simzero
    daddi r30,r30,1
    dadd r5,$zero,$zero
    jal cvt

simzero:
    dadd r5,$zero,$zero
    beq r4,$zero,poszero
    daddi r27,r27,1
    jal cvt
poszero:
    daddi r26,r26,1                 
    jal cvt
applysign:
    daddi r20,$zero,1  # flag
    beq r4,$zero,pos
    daddi r5,$zero,-1
    daddi r27,r27,1
    jal cvt
pos:
    daddi r5,$zero,1
    daddi r26,r26,1
    jal cvt
checkabnormal:
    bne r3,$zero,normal
    daddi r25,r25,1
    jal overflow
cvt: 
    l.d f2,array(r23)
    daddi r23,r23,8
    cvt.l.d f2,f2
    mfc1 r6,f2
    bne r20,$zero,round
    jal bigloop

round:
    bne r4,$zero,neg
    daddi r6,r6,1
    jal bigloop

neg:
    daddi r6,r6,-1
    jal bigloop

end:
    halt

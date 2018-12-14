.data
    array:  
        .word 0xD410402200200000

    len:  .word 150
    
    mask: .word 0x7FF0000000000000,0x000FFFFFFFFFFFFF,0x8000000000000000

    CONTROL: .word 0x10000
	DATA:    .word 0x10008

.text

main:
    ld r1,array($zero)
    ld r3,mask($zero)
    and r2,r1,r3
    daddi r10,$zero,52
    dsrav r2,r2,r10         
    daddi r10,$zero,1023    
    dsub r2,r2,r10          # r2 exponent without polarazation
    daddi r10,$zero,8
    ld r3,mask(r10)
    and r3,r1,r3            # r3 mantissa
    daddi r10,$zero,63      # problem
    dsrav r4,r1,r10
    daddi r10,$zero,16
    ld r5,mask(r10)
    halt
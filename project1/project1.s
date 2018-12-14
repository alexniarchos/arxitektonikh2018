.data
    array:  
        .word 0x5410402200200000

    len:  .word 150
    
    mask: .word 0x7FF0000000000000,0x000FFFFFFFFFFFFF,0x0000000000000001

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
    daddi r10,$zero,63      
    dsrav r6,r1,r10
    daddi r10,$zero,16
    ld r5,mask(r10)
    and r4,r6,r5            # r4 sign
    
    # exponent 8etikos arnhtikos
    # 8etikos h oudeteros
        # pairnw deutero kataxwrhth
        # bit bit shift aristera thn mantissa kai to 1 p einai mprosta apo thn mantissa 1.1101
        # shift kai ton deutero kataxwrhth
        # ka8e stoixeio p baginei aristera twn 52 xamhlwn bit to pros8etw ston deutero kataxwrhth
        # overflow check
        # telos loupas
        # teleutaio shift mantisa
        # an to bit pou bgei aristera twn 52 einai 1
        # tote stroggulopoihsh pros ta epanw
        # alliws stroggulopoihsh pros ta katw
        # ftiaxnw ton tupo ths mantissas
    # arnhtikos
        # tsekarw ton exponent an einai >2 apeu8eias 0 an einai 1 tote 1
    halt
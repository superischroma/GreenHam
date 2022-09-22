BlackHoleRange = 5 ; within 5 tiles of the black hole's proximity, the player will be pulled
BlackHolePxRange = BlackHoleRange * 8

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; black hole x + 40 <= pig x

; a - offset
BlackHoleTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    ldy #$02
    lda (TempPointer), y
    cmp #$1A
    bne @Skip
    ldy #$03
    lda (TempPointer), y
    clc
    adc #$08
    sta TempValue
    ldy #$00
    lda (TempPointer), y
    clc
    adc #$08
    sta TempValue+1
    lda TempValue
    clc
    adc #40
    cmp $020F
    bcc @SkipMLeft
    jsr MoveChopLeft
@SkipMLeft:
    lda TempValue
    sec 
    sbc #40
    cmp $020F
    bcs @SkipMRight
    jsr MoveChopRight
@SkipMRight:
@Skip:
    rts
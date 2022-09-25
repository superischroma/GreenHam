; Super Cheese (02) data and subroutines

; x and y of sprite in index registers
SpawnSuperCheese:
    lda #$00
    sta TempPointer
    lda #$02
    sta TempPointer+1
    ldx #$24
    ldy SpritePointer
@Loop:
    lda TempValue+1
    cpx #$26
    bcc @SkipYOffset
    clc
    adc #$08
@SkipYOffset:
    sta (TempPointer), y
    iny
    txa
    sta (TempPointer), y
    iny
    lda #%00000000
    sta (TempPointer), y
    iny
    txa
    and #%00000001
    beq @SkipXOffset ; is tile odd? if not, branch
    lda #$00
    clc
    adc #$08
@SkipXOffset:
    clc
    adc TempValue
    sta (TempPointer), y
    iny
    inx
    cpx #$28
    bne @Loop
    sty SpritePointer
    rts
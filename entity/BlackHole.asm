; Black Hole (05) data and subroutines

BlackHoleRange = 7 ; within 5 tiles of the black hole's proximity, the player will be pulled
BlackHolePxRange = BlackHoleRange * 8
BlackHoleDelay = $03

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; black hole x + 40 <= pig x

SpawnBlackHole:
    ldy #$1A

; y - tile
SpawnBlackHoleLike:
    tya
    pha
    lda #$01
    sta TempValue+2
    jsr RenderCircularRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    pla
    tay
    lda #%10000001
    sta TempValue+2
    jsr RenderCircularRow
    rts

; a - offset
BlackHoleTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda BlackHoleTimer
    cmp #BlackHoleDelay
    beq @Continue
    inc BlackHoleTimer
    rts
@Continue:
    lda #$00
    sta BlackHoleTimer
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
    jsr ChkWithinBH
    beq @Skip
    lda TempValue
    cmp $020F
    bcc @MoveLeft
    jsr MoveChopRight
    jmp @Vertical
@MoveLeft:
    jsr MoveChopLeft
@Vertical:
    lda TempValue+1
    cmp $020C
    bcc @MoveUp
    jsr MoveChopDown
    rts
@MoveUp:
    jsr MoveChopUp
@Skip:
    rts

; check if pig is within black hole
; black hole x-pos in TempValue
; black hole y-pos in TempValue+1
ChkWithinBH:
    ; black hole x-pos >= pig x-pos
    ; black hole x-pos < pig x-pos
    lda TempValue
    sec
    sbc #BlackHolePxRange ; left side boundary of black hole range
    cmp $020F
    bcs @Not
    lda TempValue
    clc
    adc #BlackHolePxRange
    cmp $020F
    bcc @Not
    lda TempValue+1
    sec
    sbc #BlackHolePxRange
    cmp $020C
    bcs @Not
    lda TempValue+1
    clc 
    adc #BlackHolePxRange
    cmp $020C
    bcc @Not
    lda #$01
    rts
@Not:
    lda #$00
    rts
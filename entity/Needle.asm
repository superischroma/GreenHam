SpawnNeedle:
    ldx #$02
    ldy #$36
    lda #$00
    sta TempValue+2
    jsr RenderRow
    rts

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

NeedleTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    jsr IsEntityDead
    beq @End ; is needle already collected? if so, branch
    ldy #$03
    lda (TempPointer), y
    cmp $020F
    bcs @End
    ldy #$07
    lda (TempPointer), y
    clc
    adc #$08
    cmp $020F
    bcc @End
    ldy #$00
    lda (TempPointer), y
    sec
    sbc #$04
    cmp $020C
    bcs @End
    lda (TempPointer), y
    clc
    adc #$0C
    cmp $020C
    bcc @End
    ldy #$08
    jsr UnloadSprite
    lda GameStatus
    ora #%00000100
    sta GameStatus
    jsr LoadNeedleStatus
@End:
    lda TempIndex+1
    clc
    adc #$10
    sta TempIndex+1
    rts
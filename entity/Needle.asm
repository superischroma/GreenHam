SpawnNeedle:
    ldx #$02
    ldy #$36
    lda #$00
    sta TempValue+2
    jsr RenderRow
    rts

NeedleTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    jsr IsEntityDead
    beq @End ; is needle already collected? if so, branch
    lda #$08
    sta TempValue
    lda #$10
    sta TempValue+1
    jsr ChkCollison
    beq @End ; is the player colliding with the needle? if not, branch
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
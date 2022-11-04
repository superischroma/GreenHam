; Sewing Kit (17) data and subroutines

SpawnSewingKit:
    ldx #$02
    ldy #$0A
    lda #$00
    sta TempValue+2
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$0C
    lda #$00
    sta TempValue+2
    jsr RenderRow
    rts

SewingKitTick:
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
    ldy #$10
    jsr UnloadSprite
    jsr IncrementLives
@End:
    lda TempIndex+1
    clc
    adc #$10
    sta TempIndex+1
    rts
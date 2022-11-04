SpawnPartyPopper:
    ldx #$02
    ldy #$42
    lda #$01
    sta TempValue+2
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$44
    lda #$01
    sta TempValue+2
    jsr RenderRow
    rts

PartyPopperTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    jsr IsEntityDead
    beq @End
@End:
    lda TempIndex+1
    clc
    adc #$10
    sta TempIndex+1
    rts
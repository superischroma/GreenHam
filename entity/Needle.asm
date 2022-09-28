SpawnNeedle:
    ldx #$02
    ldy #$36
    lda #$00
    sta TempValue+2
    jsr RenderRow
    lda TempIndex+1
    clc
    adc #$08
    sta TempIndex+1
    rts
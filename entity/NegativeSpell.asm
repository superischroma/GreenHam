; Negative Spell (11) data and subroutines

SpawnNegativeSpell:
    ldx #$02
    ldy #$38
    lda #$01
    sta TempValue+2
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$3A
    lda #$01
    sta TempValue+2
    jsr RenderRow
    rts
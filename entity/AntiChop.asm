; Anti-Chop (04) data and subroutines

SpawnAntiChop:
    lda #$00
    sta TempValue+2
    ldx #$03
    ldy #$59
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$03
    ldy #$07
    jsr RenderRow
    rts
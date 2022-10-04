; Sandzilla (09) data and subroutines
; Uses BananaTick for movement and attacks

SpawnSandzilla:
    ldx #$02
    ldy #$2B
    lda #$01
    sta TempValue+2
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$2D
    lda #$01
    sta TempValue+2
    jsr RenderRow
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$2F
    lda #$01
    sta TempValue+2
    jsr RenderRow
    rts